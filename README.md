# dotfiles

This repository includes all my non-confidential Linux development environment configuration files (bash, vim, git, etc).

 - **bin** - Some utils which I have in $PATH for some repetitive tasks
 - **configuration** - My configuration files
	 - _bash_ - Includes prompt lines, some functions and aliases
	- _vim_ - Includes vim plugins (as submodules) and some .vimrc configuration
	- _git_ - My git settings including aliases, defaults and ignored files
	- _tmux_ - My prefered terminal multiplexer
	- etc.

## Quick start

1. Clone this repository into $HOME/.dotfiles

    ```bash
        git clone https://github.com/brunombsilva/dotfiles.git $HOME/.dotfiles --recursive
    ```

1. Create symlinks (**CAUTION: -f will force your current dotfiles replacement**)

    ```bash
        $HOME/.dotfiles/bin/dotfiles-symlinks -f
    ```

1. Install vim plugins 

    ```bash
        vim +PluginInstall +qall
    ```
## Docker-based Setup

Although you can cherry pick what you want to your dotfiles, create symlinks or rename these files, I use a [Docker Image](https://hub.docker.com/r/brunombsilva/dotfiles/) to provision symlinks and software dependencies.

1. Run ./setup-host-sh to install docker  and getting it up and running.

	I configure the Docker daemon to use TLS authentication in order to allow remote management (in my usecase, from within a docker container *docker-ception*).

1. Add some environment variables to .bashrc to allow you to connect and manage docker.

	```bash
	export DOCKER_HOST=tcp://`hostname`:2376
	export DOCKER_TLS_VERIFY=1
	export REQUESTS_CA_BUNDLE=$HOME/.docker/server-cert.pem
	```

1. If you wish to ensure some security when connecting to the dotfiles container, generate a new RSA key pair for SSH public key authentication

	```bash
	ssh-keygen -t rsa -f dotfiles_rsa
	```

	And add the `dotfiles_rsa.pub` contents to the `.env` file to get something like:
	
	```env
	COMPOSE_PROJECT_NAME=dotfiles
	USER_NAME=ubuntu
	USER_PUBLIC_KEY=ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3rsrIaNn/dwRBcWBDGuUiDYPtlDddtP2smUJFqmN0PdRzKed3Qbp8WctGC0E9Z5gpZWIfg7W41GTLwOGiXTLgigMMNTuLMbExjHvhq7AE4Cr321kbT6ZA+GwvZz5mOoHEfVvCJrBcvJNnhJsrfS2xdxFhC1buAbsCtNSvQqcdg+WzjsLqETASPcqu205UJ4qfCEUhVn9zOeXxbnIymXfffO2hUeEKXueHwDpb43sytTsEnIzJgd4AFZ7j5um4nPLxPIc4N3pBbnLtQQv/boKI77KoaGzCaKFCYBSUqkXmOwlN/9KyZe0m3wTWONUyKgV5E93STa14EianyDRANzQ7 vagrant@vagrant-ubuntu-trusty-64
	```

1. Now you have 2 choices to get the image for your container: 
 - Run `docker-compose build` and build your image from scratch
 - Or run `docker-compose pull`and get a pre-built image from [Docker Image](hub.docker.com/r/brunombsilva/dotfiles/)

1. Run `docker-compose up -d`

1. Connect to the container anytime using `docker-compose exec dotfiles /bin/bash`

### SSH Access

You'll be able to connect using a SSH Client. 

    ```bash
    ssh -i dotfiles_rsa -p 2323 ubuntu@127.0.0.1
    ```

### Customization

You can customize your running docker container by editing [`docker-compose.yml`](docker-compose.yml).

Take a look at the inline comments for further information.

## Encrypted Files

I have some confidential configuration stored in this repository, since I want a plug-n-play solution for my personal development environment.

I'm using [transcrypt](https://github.com/elasticdog/transcrypt) and the list of encrypted files can be found in [`.gitattributes`](.gitattributes)

If you run intro any trouble about invalid file formats, it probably have to do with this.

Even if you break the encryption, you'll just get to know some details about the infrastucture details of my work environment, since I don't store any credentials here...

