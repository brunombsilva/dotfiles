filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"Ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-bundler'

"PHP
Plugin 'jwalton512/vim-blade'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'evidens/vim-twig'
"Plugin 'shawncplus/phpcomplete.vim'
"Plugin 'alvan/vim-phpmanual'
"Plugin 'mkusher/padawan.vim'
"Plugin 'vim-scripts/DBGp-client'

"Syntax
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'vim-scripts/JavaScript-syntax'
Plugin 'vim-scripts/css3-mod'
Plugin 'rogerz/vim-json'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'ntpeters/vim-better-whitespace'

"IDE
Plugin 'mhinz/vim-startify'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'sgur/ctrlp-extensions.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'xolox/vim-session'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'luochen1990/rainbow'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Chiel92/vim-autoformat'
Plugin 'Raimondi/delimitMate'
Plugin 'ervandew/supertab'
Plugin 'chrisbra/changesPlugin'
Plugin 'vim-scripts/grep.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'chrisbra/SudoEdit.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'troydm/zoomwintab.vim'
"Plugin 'christoomey/vim-tmux-navigator'
Plugin 'janko-m/vim-test'
    Plugin 'skywind3000/asyncrun.vim'
"Plugin 'ryanoasis/vim-devicons'
"Plugin 'garbas/vim-snipmate'
"Plugin 'vim-scripts/SyntaxComplete'
"Plugin 'szw/vim-ctrlspace'

"Documentation
Plugin 'lifepillar/vim-cheat40'
"Plugin 'Shougo/echodoc.vim'

"GIT
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
"Plugin 'kablamo/vim-git-log'
"Plugin 'vim-scripts/git-time-lapse'

"Stuff...
Plugin 'rickhowe/diffchar.vim'
Plugin 'rickhowe/spotdiff.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-dispatch'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'vim-scripts/genutils'
"Plugin 'Lokaltog/vim-powerline'
"Plugin 'goldfeld/vim-seek'
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'sjl/clam.vim'
"Plugin 'chrisbra/csv.vim'
"Plugin 'Keithbsmiley/investigate.vim'
"Plugin 'OmniSharp/omnisharp-vim'
"Plugin 'skywind3000/asyncrun.vim'
"Plugin 'sukima/xmledit'
"Plugin 'g3orge/vim-voogle'
Plugin 'guns/xterm-color-table.vim'

call vundle#end()
filetype plugin indent on
