" ~/Dropbox/vim/_vim/sessions/comunidades.vim: Vim session script.
" Created by session.vim 1.4.22 on 18 November 2011 at 14:11:44.
" Open this file in Vim and run :source % to restore your session.

set guioptions=aegimrLtT
silent! set guifont=
if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'light'
	set background=light
endif
if !exists('g:colors_name') || g:colors_name != 'solarized' | colorscheme solarized | endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/workspace/comunidades
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +30 Library/project/Comunidades/API/User/User.php
badd +32 Library/project/Comunidades/API/User/Content.php
badd +4 Library/project/Comunidades/Constants/Objects/Content/ContentClass.php
badd +382 ~/.vimrc
args \[BufExplorer]
set lines=70 columns=271
edit Library/project/Comunidades/API/User/Content.php
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 45 + 135) / 271)
exe '2resize ' . ((&lines * 34 + 35) / 70)
exe 'vert 2resize ' . ((&columns * 225 + 135) / 271)
exe '3resize ' . ((&lines * 33 + 35) / 70)
exe 'vert 3resize ' . ((&columns * 225 + 135) / 271)
argglobal
enew
" file NERD_tree_1
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
wincmd w
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 112 - ((13 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
112
normal! 033l
wincmd w
argglobal
edit Library/project/Comunidades/Constants/Objects/Content/ContentClass.php
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 4 - ((3 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
4
normal! 0
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 45 + 135) / 271)
exe '2resize ' . ((&lines * 34 + 35) / 70)
exe 'vert 2resize ' . ((&columns * 225 + 135) / 271)
exe '3resize ' . ((&lines * 33 + 35) / 70)
exe 'vert 3resize ' . ((&columns * 225 + 135) / 271)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
tabnext 1
1wincmd w
let s:bufnr = bufnr("%")
NERDTree ~/workspace/comunidades
execute "bwipeout" s:bufnr
1resize 68|vert 1resize 45|2resize 34|vert 2resize 225|3resize 33|vert 3resize 225|
tabnext 1
2wincmd w

" vim: ft=vim ro nowrap smc=128
