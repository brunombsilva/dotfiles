FROM ubuntu:trusty

ARG USER_NAME=ubuntu
ARG USER_ID=1000
ARG USER_PASSWORD=123456
ARG DEBIAN_FRONTEND=noninteractive
ARG VIM_VERSION=8.0.0134
ARG TIG_VERSION=2.2.1
ARG DOTNETCORE_VERSION=1.0.0-preview2.1-003177
ARG PYTHON_VERSION=2.7.9
ARG RUBY_VERSION=2.3.3
ARG NODE_VERSION=latest

#Update sources
RUN apt-get -y update

#Install base packages
#TODO: maybe split into domain-specific dependecies
RUN apt-get -y install \
	git \
	git-extras \
	wget \
	curl \
	tmux \
	libncurses5-dev \
	libncursesw5-dev \
	htop \
	exuberant-ctags \
	ngrep \
	ruby-full \
	build-essential \
	grc \
	lnav \
	unzip \
	bash-completion \
	man \
	php5 \
	php5-curl 

#Ensure locales
RUN apt-get -y install language-pack-EN
RUN apt-get -y install language-pack-PT

#Dirty work will be done in /tmp
WORKDIR /tmp

# Install Vim 8.0
RUN wget https://github.com/vim/vim/archive/v${VIM_VERSION}.zip -O vim.zip && \
	apt-get -y install ruby-dev python-dev && \
	unzip vim.zip && \
	cd vim-${VIM_VERSION} && \
	./configure --with-features=huge --enable-pythoninterp=dynamic --enable-rubyinterp --enable-multibyte && \
        make install && \
	rm -fR /tmp/*

#Install tig (for git repository browsing)
RUN wget https://github.com/jonas/tig/releases/download/tig-${TIG_VERSION}/tig-${TIG_VERSION}.tar.gz -O tig.tar.gz && \
	tar -zxvf tig.tar.gz && \
	cd tig-${TIG_VERSION} && \
	make prefix=/usr/local && \
	make install prefix=/usr/local && \
	rm -fR /tmp/*

#dotnet core
RUN echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list && \
	apt-get -y install apt-transport-https && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 && \
	apt-get -y update && \
	apt-get -y install dotnet-dev-${DOTNETCORE_VERSION}

## Add USER
RUN useradd -u ${USER_ID} -m -s /bin/bash -U ${USER_NAME} && \
    echo "${USER_NAME}:${USER_PASSWORD}"|chpasswd && \
    adduser ${USER_NAME} sudo && \
    echo ${USER_NAME}' ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

## SSH
#TODO: use only RSA
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#Some dependecies as root, because switching to user
RUN apt-get install -y \
	openssl-dev sqlite3 bzip2 `# python` \
	libreadline-dev `#ruby + python` \
	zlib1g-dev `# ruby`

USER ${USER_NAME}

WORKDIR /home/${USER_NAME}

RUN git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv

#Install python and python tools
RUN cd $HOME/.pyenv/bin && \
	eval "$(./pyenv init -)" && \
	./pyenv install ${PYTHON_VERSION} && \
	./pyenv global ${PYTHON_VERSION} && \
	pip install \
		http-prompt \
		powerline-status \
		powerline-gitstatus \
		#docker \
		powerline-docker 

#Install ruby and ruby tools
RUN git clone https://github.com/rbenv/rbenv.git .rbenv && \
	git clone https://github.com/rbenv/ruby-build.git .rbenv/plugins/ruby-build && \
	cd .rbenv && src/configure && make -C src && \
	cd $HOME/.rbenv/bin && \
	eval "$(./rbenv init -)" && \
	./rbenv install ${RUBY_VERSION} && \
	./rbenv global ${RUBY_VERSION} && \
	gem install \
		lolcat \
		sass

#Install npm and npm tools
RUN git clone https://github.com/creationix/nvm.git .nvm && \
	cd .nvm && \
	./nvm.sh && \
        nvm install node ${NODE_VERSION} && \
	npm install -g \
		js-yaml \
		js-beautify

## Github + BitBucket
RUN mkdir -m 700 $HOME/.ssh

RUN ssh-keyscan -H github.com >> $HOME/.ssh/known_hosts
RUN ssh-keyscan -H bitbucket.com >> $HOME/.ssh/known_hosts

RUN git clone https://github.com/rupa/z .rupa-z && chmod +x .rupa-z/z.sh

## dotfiles
ADD ./configuration .configuration
ADD ./bin bin
USER root
#remote docker management
RUN /home/${USER_NAME}/bin/install-docker.sh
RUN chown -R $USER_NAME:$USER_NAME .configuration
USER ${USER_NAME}

RUN for file in .configuration/_*; do ln -s -f $file $(echo "$file" | sed 's/\.configuration\///; s/^_/./'); done 

RUN ln -s -f .configuration/vim/_vimrc .vimrc 
RUN ln -s -f .configuration/vim/_gvimrc .gvimrc 
RUN ln -s -f .configuration/vim/_vim .vim 
RUN mkdir -p .ssh && ln -s -f $HOME/.configuration/ssh/_config $HOME/.ssh/config
RUN mkdir -p .config && ln -s -f $HOME/.configuration/powerline $HOME/.config/powerline

USER root

## Run sshd

#VOLUME /home/${USER_NAME}
CMD ["/usr/sbin/sshd", "-D"]
EXPOSE 22
