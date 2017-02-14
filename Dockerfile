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

ENV USER_PUBLIC_KEY=

#Update sources
RUN apt-get -y update

#Install base packages
#TODO: maybe split into domain-specific dependecies
RUN apt-get install -y --no-install-recommends \
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
    unzip \
    bash-completion \
    man \
    make \
    php5 \
    php5-curl \
    language-pack-EN \
    language-pack-PT

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

RUN mkdir -m 700 $HOME/.ssh
#Adding my known hosts (ig. Github)
ADD ./configuration/ssh/known_hosts $HOME/.ssh/known_hosts
## Github + BitBucket
#RUN ssh-keyscan -H github.com >> $HOME/.ssh/known_hosts
#RUN ssh-keyscan -H bitbucket.com >> $HOME/.ssh/known_hosts

RUN git clone https://github.com/rupa/z .rupa-z && chmod +x .rupa-z/z.sh

#Cherry picking binaries to optimize docker build cache usage

#Install Vim
ADD ./bin/install-vim .dotfiles/bin/
RUN sudo .dotfiles/bin/install-vim $VIM_VERSION

#Install tig (for git repository browsing)
ADD ./bin/install-tig .dotfiles/bin/
RUN sudo .dotfiles/bin/install-tig $TIG_VERSION

#Install tmux
ADD ./bin/install-tmux .dotfiles/bin/
RUN sudo .dotfiles/bin/install-tmux $TMUX_VERSION

#Install python and python tools
ADD ./bin/install-python .dotfiles/bin/
RUN .dotfiles/bin/install-python $PYTHON_VERSION \
    http-prompt \
    powerline-status \
    powerline-gitstatus \
    powerline-docker

#Install ruby and ruby tools
ADD ./bin/install-ruby .dotfiles/bin/
RUN .dotfiles/bin/install-ruby $RUBY_VERSION \
    lolcat \
    tmuxinator \
    sass

#Install npm and npm tools
ADD ./bin/install-node .dotfiles/bin/
RUN .dotfiles/bin/install-node $NODE_VERSION \
    js-yaml \
    js-beautify

#dotnet core
ADD ./bin/install-dotnet .dotfiles/bin/
RUN test ! $DOTNETCORE_VERSION || sudo .dotfiles/bin/install-dotnet

#remote docker management
ADD ./bin/install-docker .dotfiles/bin/
RUN sudo .dotfiles/bin/install-docker

## dotfiles
ADD ./bin .dotfiles/bin
ADD ./configuration .dotfiles/configuration
RUN sudo chown -R $USER_NAME:$USER_NAME .dotfiles/configuration

#Ensure dotfiles symlinks
RUN .dotfiles/bin/dotfiles-symlinks -f

RUN vim +PluginInstall +qall

ADD ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT /docker-entrypoint.sh

#CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22
