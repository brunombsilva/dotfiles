FROM debian:stretch-slim

ARG DEBIAN_FRONTEND=noninteractive

#Update sources
RUN apt-get -y update

#Install base packages
#TODO: maybe split into domain-specific dependecies
RUN apt-get install -y --no-install-recommends \
    sudo \
    lsb-release \
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
    less \
    make \
    aspell \
    ncdu \
    locales

RUN echo "pt_PT.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen pt_PT.UTF-8 en_US.UTF-8

## Add USER
ARG USER_NAME=dummy
ARG USER_PASSWORD=dummy
ARG USER_ID=1000
ENV USER_PUBLIC_KEY=
RUN useradd -u ${USER_ID} -m -s /bin/bash -U ${USER_NAME} && \
    echo "${USER_NAME}:${USER_PASSWORD}"|chpasswd && \
    adduser ${USER_NAME} sudo && \
    echo ${USER_NAME}' ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
#rando password: `openssl rand -base64 32`

## SSH - No more SSH access for now
# RUN apt-get install -y openssh-server && \
#     mkdir /var/run/sshd && \
#     echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
#     echo "AllowUsers ${USER_NAME}" >> /etc/ssh/sshd_config && \
#     echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config && \
#     echo "UsePAM no" >> /etc/ssh/sshd_config && \
#     sed -i 's/PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config && \
#     sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}

RUN mkdir -m 700 $HOME/.ssh
#Adding my known hosts (ig. Github)
ADD ./configuration/ssh/known_hosts $HOME/.ssh/known_hosts
## Github + BitBucket
#RUN ssh-keyscan -H github.com >> $HOME/.ssh/known_hosts
#RUN ssh-keyscan -H bitbucket.com >> $HOME/.ssh/known_hosts

#Cherry picking binaries to optimize docker build cache usage

#Install tig (for git repository browsing)
ARG TIG_VERSION=2.2.1
ADD ./bin/install-tig .dotfiles/bin/
RUN .dotfiles/bin/install-tig $TIG_VERSION

#Install tmux
ARG TMUX_VERSION=2.3
ADD ./bin/install-tmux .dotfiles/bin/
RUN .dotfiles/bin/install-tmux $TMUX_VERSION

#Install Python
ARG PYTHON_VERSION=system
ADD ./bin/install-python .dotfiles/bin/
RUN .dotfiles/bin/install-python $PYTHON_VERSION

#Install Ruby
ARG RUBY_VERSION=2.4.4
ADD ./bin/install-ruby .dotfiles/bin/
RUN .dotfiles/bin/install-ruby $RUBY_VERSION

#Install npm
ARG NODE_VERSION=v6.9.2
ADD ./bin/install-node .dotfiles/bin/
RUN .dotfiles/bin/install-node $NODE_VERSION

#dotnet core
ARG DOTNETCORE_VERSION=''
#ARG DOTNETCORE_VERSION=1.0.0-preview2.1-003177
ADD ./bin/install-dotnet .dotfiles/bin/
RUN test ! $DOTNETCORE_VERSION || .dotfiles/bin/install-dotnet

ADD ./bin/install-su-exec .dotfiles/bin/
RUN .dotfiles/bin/install-su-exec

#Install Vim using previously python/ruby installation
ARG VIM_VERSION=8.0.0134
ADD ./bin/install-vim .dotfiles/bin/
RUN eval "$($HOME/.rbenv/bin/rbenv init -)" && \
    eval "$($HOME/.pyenv/bin/pyenv init -)" && \
    .dotfiles/bin/install-vim $VIM_VERSION

#Install Tools
ADD ./bin/install-package .dotfiles/bin/
RUN .dotfiles/bin/install-package \
    gem-lolcat \
    npm-js-yaml \
    npm-js-beautify

ADD ./bin/install-zsh .dotfiles/bin/
RUN .dotfiles/bin/install-zsh

## dotfiles
ADD ./bin .dotfiles/bin
ADD ./configuration .dotfiles/configuration
RUN sudo chown -R $USER_NAME:$USER_NAME .dotfiles/configuration

#Ensure dotfiles symlinks
RUN .dotfiles/bin/dotfiles-symlinks -f

RUN vim +PlugInstall +qall

ARG DEFAULT_SHELL=zsh
RUN sudo chsh -s $(which $DEFAULT_SHELL) $USER_NAME

RUN  zsh -c "source ~/.zsh.zshrc/antigen.zsh; antigen init ~/.antigenrc"

USER root
ENV USER_NAME=$USER_NAME

#Now that we're done, let's force sudo to ask password
RUN sed -i 's/NOPASSWD://' /etc/sudoers && chpasswd ${USER_NAME}:${USER_PASSWORD}

ADD ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["/usr/bin/zsh"]

WORKDIR /workspace

