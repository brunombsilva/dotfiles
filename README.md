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
        vim +PlugInstall +qall
    ```

## Quick start (Docker)

Assuming docker installed.

```bash
	docker run --rm -v $(pwd):/workspace -it brunombsilva/dotfiles
```

### Customization

You can customize your running docker container by editing [`docker-compose.yml`](docker-compose.yml).

Take a look at the inline comments for further information.
