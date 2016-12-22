FROM ubuntu:trusty

#Borrowed some stuff from https://github.com/uralbash/docker-ubuntu

ARG USER_NAME=ubuntu
ARG USER_ID=1000
ARG USER_PASSWORD=123456

RUN apt-get -y update 
RUN apt-get -y install git wget tmux libncurses5-dev libncursesw5-dev htop exuberant-ctags ngrep \
	ruby-full nodejs npm grc lnav git-extras wget unzip bash-completion man python-pip curl php5 php5-curl 

RUN apt-get -y install language-pack-EN
ENV LANG en_US.UTF-8
	
WORKDIR /tmp

#vim dependecies
RUN apt-get -y install ruby-dev python-dev

RUN wget https://github.com/vim/vim/archive/v8.0.0134.zip -O vim.zip \
	&& unzip vim.zip \
	&& cd vim-8* \
	&& ./configure --with-features=huge --enable-pythoninterp=dynamic --enable-rubyinterp --enable-multibyte \
       && make install  

RUN wget https://github.com/jonas/tig/releases/download/tig-2.2.1/tig-2.2.1.tar.gz -O tig.tar.gz && \
	tar -zxvf tig.tar.gz && cd tig-2* && make prefix=/usr/local && make install prefix=/usr/local

#RUN wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz -I python.tgz && \
#	tar -zxvf python.tgz && \
#	apt-get -y install build-essential libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev && \
#	cd Python-2* && ./configure && make && make install

#RUN gem install lolcat sass

RUN pip install pip virtualenv virtualenvwrapper -U
RUN pip install http-prompt powerline-status powerline-gitstatus 

RUN npm install js-yaml js-beautify

## Add USER
RUN useradd -u ${USER_ID} -m -s /bin/bash -U ${USER_NAME} && \
    echo "${USER_NAME}:${USER_PASSWORD}"|chpasswd && \
    adduser ${USER_NAME} sudo && \
    echo ${USER_NAME}' ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

## SSH
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


USER ${USER_NAME}

WORKDIR /home/${USER_NAME}

## Github + BitBucket
RUN mkdir -m 700 $HOME/.ssh
#RUN chmod 700 $HOME/.ssh
RUN ssh-keyscan -H github.com >> $HOME/.ssh/known_hosts
RUN ssh-keyscan -H bitbucket.com >> $HOME/.ssh/known_hosts

RUN git clone https://github.com/rbenv/rbenv.git .rbenv && \
	git clone https://github.com/rbenv/ruby-build.git .rbenv/plugins/ruby-build && \
	cd .rbenv && src/configure && make -C src

RUN git clone https://github.com/rupa/z z

## dotfiles
ADD . .configuration
USER root
#remote docker management
RUN .configuration/install-docker.sh
RUN chown -R $USER_NAME:$USER_NAME .configuration
USER ${USER_NAME}
ENV LANG en_US.UTF-8

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
