# dotfiles

This repository includes all my non-confidential Linux development environment configuration files (bash, vim, git, etc).

## bash

Includes prompt lines, some functions and aliases

## vim

Includes vim plugins (as submodules) and some .vimrc configuration

## git

My git settings including aliases, defaults and ignored files

## tmux

My prefered terminal multiplexer


## Setup

Though you can cherry pick what you want to your dotfiles, create symlinks or rename these files, I use an [Ansible Playbook](https://github.com/brunombsilva/ansible-dotfiles) to provision symlinks and software dependencies
