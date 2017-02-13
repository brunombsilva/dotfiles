" Vim graphical configuration.

set guifont=Monospace\ 10         " Font family and font size.
set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.
set guioptions-=m                 " Hide menu bar.
set guioptions-=e                 " Hide enhanced tabs.
"set background=light              " Background.
"set lines=25 columns=100          " Window dimensions.

set guioptions-=r                 " Don't show right scrollbar
set guioptions-=L                 " Don't show left scrollbar

if has('win32')
    set guifont=Consolas:h10
    let g:airline_symbols.crypt = '🔒'

	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ''
endif
