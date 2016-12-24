# dotfiles

This repository includes all my non-confidential Linux development environment configuration files (bash, vim, git, etc).

## bin

Some utils which I have in $PATH for some repetitive tasks

## configuration

My configuration files

### bash

Includes prompt lines, some functions and aliases

### vim

Includes vim plugins (as submodules) and some .vimrc configuration

### git

My git settings including aliases, defaults and ignored files

### tmux

My prefered terminal multiplexer


## Setup

Though you can cherry pick what you want to your dotfiles, create symlinks or rename these files, I use a [Docker Image](hub.docker.com/r/brunombsilva/dotfiles/) to provision symlinks and software dependencies.

### Quick start

1. Run ./setup-host-sh to install docker  and getting it up and running.

I configure the Docker daemon to use TLS authentication in order to allow remote management (in my usecase, from within a docker container *docker-ception*).

1. Add some environment variables to .bashrc to allow you to connect and manage docker.

```bash
export DOCKER_HOST=tcp://`hostname`:2376 DOCKER_TLS_VERIFY=1
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH=`pwd`/docker
export REQUESTS_CA_BUNDLE=`pwd`/docker/server-cert.pem
```

1. If you wish to ensure some security when connecting to the dotfiles container, generate a new RSA key pair for SSH public key authentication

```bash
ssh-keygen -t rsa -f dotfiles_rsa
```

And add the `dotfiles_rsa.pub` contents to the `.env` file to get something like:

```bash
COMPOSE_PROJECT_NAME=dotfiles
USER_NAME=bsilva
USER_PUBLIC_KEY=ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3rsrIaNn/dwRBcWBDGuUiDYPtlDddtP2smUJFqmN0PdRzKed3Qbp8WctGC0E9Z5gpZWIfg7W41GTLwOGiXTLgigMMNTuLMbExjHvhq7AE4Cr321kbT6ZA+GwvZz5mOoHEfVvCJrBcvJNnhJsrfS2xdxFhC1buAbsCtNSvQqcdg+WzjsLqETASPcqu205UJ4qfCEUhVn9zOeXxbnIymXfffO2hUeEKXueHwDpb43sytTsEnIzJgd4AFZ7j5um4nPLxPIc4N3pBbnLtQQv/boKI77KoaGzCaKFCYBSUqkXmOwlN/9KyZe0m3wTWONUyKgV5E93STa14EianyDRANzQ7 vagrant@vagrant-ubuntu-trusty-64
```

1. Now you have 2 choices to get the image for your container: 
 1. Run `docker-compose build` and build your image from scratch
 1. Or run `docker-compose pull`and get a pre-built image from [Docker Image](hub.docker.com/r/brunombsilva/dotfiles/)

1. Run `docker-compose up -d`

1. Connect to the container anytime using `docker-compose exec dotfiles /bin/bash`

TODO: Add docker-compose.yml notes
TODO: Talk about SSH
