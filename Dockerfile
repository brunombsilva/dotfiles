FROM ubuntu:trusty

#Borrowed some stuff from https://github.com/uralbash/docker-ubuntu

ARG USER_NAME=ubuntu
ARG USER_ID=1000
ARG USER_PASSWORD=123456

#Update sources
RUN apt-get -y update

#Install base packages
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
	nodejs \
	npm \
	grc \
	lnav \
	unzip \
	bash-completion \
	man \
	php5 \
	php5-curl 
	# python-pip

#Ensure locales
RUN apt-get -y install language-pack-EN

#Dirty work will be done in /tmp
WORKDIR /tmp

# Install Vim 8.0
RUN apt-get -y install ruby-dev python-dev

RUN wget https://github.com/vim/vim/archive/v8.0.0134.zip -O vim.zip && \
	unzip vim.zip && \
	cd vim-8* && \
	./configure --with-features=huge --enable-pythoninterp=dynamic --enable-rubyinterp --enable-multibyte && \
        make install && \
	rm /tmp/*

#Install tig (for git repository browsing)
RUN wget https://github.com/jonas/tig/releases/download/tig-2.2.1/tig-2.2.1.tar.gz -O tig.tar.gz && \
	tar -zxvf tig.tar.gz && \
	cd tig-2* && \
	make prefix=/usr/local && \
	make install prefix=/usr/local && \
	rm /tmp/*

#TODO: https://github.com/creationix/nvm
RUN npm install js-yaml js-beautify

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

USER ${USER_NAME}

WORKDIR /home/${USER_NAME}

RUN git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv

#Install python and python tools
RUN cd $HOME/.pyenv/bin && \
	eval "$(./pyenv init -)" && \
	./pyenv install 2.7.9 && \
	./pyenv rehash && \
	./pyenv global 2.7.9 && \
	pip install \
		http-prompt \
		powerline-status \
		powerline-gitstatus \
		#docker \
		powerline-docker 

#RUN gem install lolcat sass

## Github + BitBucket
RUN mkdir -m 700 $HOME/.ssh

RUN ssh-keyscan -H github.com >> $HOME/.ssh/known_hosts
RUN ssh-keyscan -H bitbucket.com >> $HOME/.ssh/known_hosts

RUN git clone https://github.com/rbenv/rbenv.git .rbenv && \
	git clone https://github.com/rbenv/ruby-build.git .rbenv/plugins/ruby-build && \
	cd .rbenv && src/configure && make -C src

RUN git clone https://github.com/rupa/z .z && chmod +x .z/z.sh

## dotfiles
ADD ./configuration .configuration
ADD /install-docker.sh /tmp/install-docker.sh
USER root
#remote docker management
RUN /tmp/install-docker.sh
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
CMD ["/usr/sbin/sshd", "-D"]
EXPOSE 22
