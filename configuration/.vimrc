source ~/.vim/plugins.vim

"set term=screen-256color

set nocompatible                  " Must come first because it changes other options.

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.

set ttymouse=xterm2
set mouse=a

"set clipboard=unnamed

" Keep swap files in one location
if has("win32") || has("win64")
    set directory=$TMP
else
    set directory=/tmp
end
"set noswapfile

set tabstop=4                    " Global tab width.
set shiftwidth=4                 " And again, related.
set expandtab                    " Use spaces instead of tabs
set softtabstop=4

set laststatus=2                  " Show the status line all the time

syntax enable

" Solarized theme configuration

let g:solarized_termcolors=256

if has('win32') || has('win64')
    let g:solarized_degrade=1
endif

set background=dark
silent! colorscheme neodark

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ }

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Tabs style tweaks
hi TabLineSel term=underline cterm=underline ctermfg=239 ctermbg=187 gui=bold
hi TabNumSel term=underline cterm=underline ctermfg=239 ctermbg=187 gui=bold

" Automatic fold settings for specific files.
autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
autocmd FileType xml setlocal foldmethod=syntax

autocmd BufNewFile,BufRead *.gitconfig set syntax=gitconfig
autocmd BufNewFile,BufRead *.antigenrc set syntax=zsh

"xmledit plugin configuration
"let loaded_xmledit = 1

" Don't use vi compatibility mode
set nocp

if version >= 600
    filetype plugin indent on
endif

set mouse=n
let g:spchkmouse   = 1
let g:spchkautonext= 1
let g:spchkdialect = "usa"

"let g:acp_behaviorSnipmateLength = 4
let g:acp_behaviorKeywordLength = 5
"let g:acp_behaviourHtmlOmniLength = 4

set autoindent                              "Retain indentation on next line
set smartindent                             "Turn on autoindenting of blocks
set cinwords = ""                           "But not for C-like keywords
inoremap # X<C-H>#|                         "And no magic outdent for comments
nnoremap <silent> >> :call ShiftLine()<CR>| "And no shift magic on comments

function! ShiftLine()
    set nosmartindent
    normal! >>
    set smartindent
endfunction

set backspace=indent,eol,start      "BS past autoindents, line boundaries,
set matchpairs+=<:>             "Match angle brackets too

"Switch off highlighting till next search and clear messages...
nmap <silent> <BS> :nohlsearch <BAR> set nocursorcolumn<CR>

" Use space to jump down a page (like browsers do)...
noremap <Space> <PageDown>


"shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

"Use the same symbols as TextMate for tabstops and EOLs
silent! set listchars=tab:<.,eol:¬

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Rainbow Parentheses Highlighting
let g:rainbow_active=1

" Syntastic Configuration

" Automatically open the location-list hen a buffer has errors
let g:syntastic_auto_loc_list=1

"location-list size
let g:syntastic_loc_list_height=3

" Ruby checkers
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_ruby_rubocop_exec='~/.rbenv/shims/rubocop'

"  Prettier!
hi Normal ctermbg=None
hi LineNr ctermfg=235 ctermbg=None
hi SignColumn ctermbg=None

" Autocomplete Bindings and options. Nowadays I don't even use it
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>
set completeopt=longest,menu,preview

" Show TagBar on the left
"let g:tagbar_left = 1

" TagBar & NERDTree keybindings support
imap <leader>nt <Esc><leader>nt
map <leader>nt :NERDTreeToggle<cr>

imap <leader>ide <Esc><leader>ide
map <leader>ide :NERDTreeClose<cr>:TagbarClose<cr>:NERDTree<cr>:TagbarOpen<cr><C-w>t<C-w>s:buffer NERD_tree_1<cr><C-w>t<C-w>l<C-w>c<C-w>t
map <leader>tb :TagbarToggle<cr>

" Git file history navigation
"map <leader>gt :call TimeLapse() <cr>

"changesPlugin, check for changes from filesystem when entering a buffer
"au VimEnter * EC

" Shortcuts to resize panes
map - <C-W>-
map + <c-W>+
map º <C-W>>
map ç <c-W><


"disable vim-session plugin session auto-saving
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:startify_session_dir = '~/.vim/sessions'

"set splitbelow

let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1

"vim-indent-guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

hi IndentGuidesOdd  ctermbg=233
hi IndentGuidesEven ctermbg=235

"AsyncRun plugin auto-open quick fix upon finish
augroup vimrc
    autocmd QuickFixCmdPost * botright copen 8
augroup END

"janko-m/vim-test configuration
let test#strategy = "asyncrun"

let test#ruby#rspec#executable = 'bin/docker-local exec guard bin/spring rspec'
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''

map <F12> <Plug>NextCS
map <F11> <Plug>PreviousCS
let g:neodark#solid_vertsplit = 1

let g:NERDTreeChDirMode=2

"let g:ale_lint_delay= 1000
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list=1
"let g:ale_ruby_rubocop_executable='~/.rbenv/shims/rubocop'
"let g:ale_history_log_output = 1


let g:ctrlp_working_path_mode = 'rw'

" ctrlp extension used to navigate between current buffer function definitions
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_funky_matchtype = 'path'

" ctrlp shortcuts
nnoremap <C-y> :CtrlPYankring<cr>
nnoremap <C-c>l :CtrlPCmdline<cr>
nnoremap <C-c>b :CtrlPBuffer<cr>
nnoremap <C-c>f :CtrlPFunky<cr>

" narrow the list down with a word under cursor
nnoremap <C-c>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
