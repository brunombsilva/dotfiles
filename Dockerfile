FROM ubuntu:trusty

ARG USER_NAME=ubuntu
ARG USER_ID=1000
ARG DEBIAN_FRONTEND=noninteractive
ARG VIM_VERSION=8.0.0134
ARG TIG_VERSION=2.2.1
ARG DOTNETCORE_VERSION=''
#ARG DOTNETCORE_VERSION=1.0.0-preview2.1-003177
ARG PYTHON_VERSION=2.7.9
ARG RUBY_VERSION=2.3.3
ARG NODE_VERSION=v6.9.2
ARG TMUX_VERSION=2.3

ARG DINSTALL='sudo apt-get install -y --no-install-recommends'
ARG DCLEANUP='sudo apt-get -y remove --purge $(echo $BUILD_PACKAGES) && sudo apt-get -y autoremove && sudo rm -fr /tmp/*'
#TODO: get rid of eval $DCLEANUP
#/var/lib/apt/lists/*'

ENV USER_PUBLIC_KEY=

#Update sources
RUN apt-get -y update

#Install base packages
#TODO: maybe split into domain-specific dependecies
RUN $DINSTALL \
    git \
    git-extras \
    wget \
    ca-certificates \
    curl \
    locate \
    htop \
    exuberant-ctags \
    ngrep \
    grc \
    lnav \
    unzip \
    bash-completion \
    man \
    make \
    php5 \
    php5-curl

#Ensure locales
RUN $DINSTALL language-pack-EN
RUN $DINSTALL language-pack-PT

#Dirty work will be done in /tmp
WORKDIR /tmp

# Install Vim 8.0
RUN wget https://github.com/vim/vim/archive/v${VIM_VERSION}.zip -O vim.zip && \
    BUILD_PACKAGES='build-essential ruby-dev python-dev libncurses5-dev libncursesw5-dev' && \
    $DINSTALL libruby libpython2.7 $BUILD_PACKAGES && \
    unzip vim.zip && \
    cd vim-${VIM_VERSION} && \
    ./configure --with-features=huge --enable-pythoninterp=dynamic --enable-rubyinterp --enable-multibyte && \
    make install && \
    eval $DCLEANUP

#Install tig (for git repository browsing)
RUN wget https://github.com/jonas/tig/releases/download/tig-${TIG_VERSION}/tig-${TIG_VERSION}.tar.gz -O tig.tar.gz && \
    BUILD_PACKAGES='build-essential libncurses5-dev libncursesw5-dev' && \
    $DINSTALL $BUILD_PACKAGES && \
    tar -zxvf tig.tar.gz && \
    cd tig-${TIG_VERSION} && \
    make prefix=/usr/local && \
    make install prefix=/usr/local && \
    eval $DCLEANUP

#Install tmux
RUN wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz -O tmux.tar.gz && \
    BUILD_PACKAGES='build-essential libevent-dev libncurses5-dev libncursesw5-dev' && \
    $DINSTALL $BUILD_PACKAGES libevent-2.0-5 && \
    tar -zxvf tmux.tar.gz && \
    cd tmux-${TMUX_VERSION} && \
    ./configure && \
    make prefix=/usr/local && \
    make install prefix=/usr/local && \
    eval $DCLEANUP

#dotnet core
RUN if [ $DOTNETCORE_VERSION ]; then \
        echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list && \
        $DINSTALL apt-transport-https && \
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 && \
        apt-get -y update && \
        $DINSTALL dotnet-dev-${DOTNETCORE_VERSION} \
        ; \
    fi

## Add USER
RUN useradd -u ${USER_ID} -m -s /bin/bash -U ${USER_NAME} && \
    echo "${USER_NAME}:`openssl rand -base64 32`"|chpasswd && \
    adduser ${USER_NAME} sudo && \
    echo ${USER_NAME}' ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

## SSH
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "AllowUsers ${USER_NAME}" >> /etc/ssh/sshd_config && \
    echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}

#Install python and python tools
RUN git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv && \
    cd $HOME/.pyenv/bin && \
    BUILD_PACKAGES='build-essential libssl-dev libreadline-dev libsqlite3-dev libbz2-dev' && \
    $DINSTALL $BUILD_PACKAGES && \
    eval "$(./pyenv init -)" && \
    ./pyenv install ${PYTHON_VERSION} && \
    ./pyenv global ${PYTHON_VERSION} && \
    pip install \
        http-prompt \
        powerline-status \
        powerline-gitstatus \
        #docker \
        powerline-docker \
    && \
    eval $DCLEANUP

#Install ruby and ruby tools
RUN git clone https://github.com/rbenv/rbenv.git .rbenv && \
    git clone https://github.com/rbenv/ruby-build.git .rbenv/plugins/ruby-build && \
    BUILD_PACKAGES='libssl-dev libssl-dev build-essential libreadline-dev' && \
    $DINSTALL $BUILD_PACKAGES && \
    cd .rbenv && src/configure && make -C src && \
    cd $HOME/.rbenv/bin && \
    eval "$(./rbenv init -)" && \
    ./rbenv install ${RUBY_VERSION} && \
    ./rbenv global ${RUBY_VERSION} && \
    gem install \
        lolcat \
        tmuxinator \
        sass \
    && \
    eval $DCLEANUP

#Install npm and npm tools
RUN git clone https://github.com/creationix/nvm.git .nvm && \
    cd .nvm && \
    /bin/bash -c 'source ./nvm.sh && \
        nvm install node ${NODE_VERSION} && \
    npm install -g \
        js-yaml \
        js-beautify'

## Github + BitBucket
RUN mkdir -m 700 $HOME/.ssh
RUN ssh-keyscan -H github.com >> $HOME/.ssh/known_hosts
RUN ssh-keyscan -H bitbucket.com >> $HOME/.ssh/known_hosts

RUN git clone https://github.com/rupa/z .rupa-z && chmod +x .rupa-z/z.sh

## dotfiles
ADD ./configuration .configuration
ADD ./bin bin

#remote docker management
RUN sudo /home/${USER_NAME}/bin/docker-install
RUN sudo chown -R $USER_NAME:$USER_NAME .configuration

#Ensure dotfiles symlinks
RUN bin/dotfiles-symlinks -f

RUN vim +PluginInstall +qall

ADD ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT /docker-entrypoint.sh

#CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22
