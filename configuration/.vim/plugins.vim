call plug#begin('~/.vim/plugged')

"Syntax
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'rhysd/vim-color-spring-night'
Plug 'KeitaNakamura/neodark.vim'

"IDE
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sgur/ctrlp-extensions.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'gcmt/taboo.vim'
Plug 'itchyny/lightline.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/grep.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'troydm/zoomwintab.vim', { 'commit': 'c42c7fd7c96438023f03adcc54271e4e7342a5e0' }

"GIT
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Stuff...
Plug 'altercation/vim-colors-solarized'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'rkitover/vimpager'

call plug#end()
