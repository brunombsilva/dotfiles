" ~/Dropbox/vim/_vim/sessions/blog-project.vim: Vim session script.
" Created by session.vim 1.4.22 on 16 November 2011 at 17:09:06.
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
call setqflist([{'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Application/Frontend/Views/templates/Post/edit.tpl', 'text': '[Search results for pattern: ''PostId'']'}, {'lnum': 66, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Library/project/UselessBlog/DAO/Post.php', 'text': '            ''key_mappings'' => array( ''Id'' => ''PostId'' ),'}, {'lnum': 26, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Library/project/UselessBlog/DAO/Comment.php', 'text': '        ''PostId'' => array('}, {'lnum': 45, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Library/project/UselessBlog/DAO/Comment.php', 'text': '            ''key_mappings'' => array( ''PostId'' => ''Id'' ),'}])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/workspace/libsapo-php/Etc/Quick-guide-code/blog-project
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +65 Application/Frontend/Controllers/Post.php
badd +2 Library/libsapo-php/Sapo/Web/Response.php
badd +90 Library/libsapo-php/Sapo/Web/Request.php
badd +6 Application/Frontend/Views/templates/Post/create.tpl
badd +1 Application/Frontend/Views/templates/Post/view.tpl
badd +1 Library/project/UselessBlog/Model/Post.php
badd +49 Library/project/UselessBlog/DAO/Post.php
badd +43 Library/project/UselessBlog/DAO/Comment.php
badd +711 Library/libsapo-php/Sapo/Web/View/HTML/FormHelper.php
badd +8 Application/Frontend/Controllers/Application.php
badd +62 Library/libsapo-php/Sapo/Web/Controller.php
badd +141 Library/libsapo-php/Sapo/Web/FrontPageController.php
badd +24 Application/Frontend/Controllers/Home.php
badd +7 Application/Frontend/Views/templates/Home/index.tpl
badd +1 ~/workspace/libsapo-php/Etc/create_test_database.sql
badd +26 Etc/datamodel/create_script.sql
badd +7 Application/Frontend/Views/templates/Post/edit.tpl
badd +28 Application/Frontend/Config/Routes.yaml
args \[BufExplorer]
set lines=70 columns=271
edit Application/Frontend/Controllers/Post.php
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
exe 'vert 1resize ' . ((&columns * 31 + 135) / 271)
exe '2resize ' . ((&lines * 22 + 35) / 70)
exe 'vert 2resize ' . ((&columns * 239 + 135) / 271)
exe '3resize ' . ((&lines * 45 + 35) / 70)
exe 'vert 3resize ' . ((&columns * 239 + 135) / 271)
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
let s:l = 54 - ((15 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
54
normal! 028l
wincmd w
argglobal
edit Application/Frontend/Views/templates/Post/view.tpl
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 29 - ((28 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
29
normal! 045l
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 135) / 271)
exe '2resize ' . ((&lines * 22 + 35) / 70)
exe 'vert 2resize ' . ((&columns * 239 + 135) / 271)
exe '3resize ' . ((&lines * 45 + 35) / 70)
exe 'vert 3resize ' . ((&columns * 239 + 135) / 271)
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
NERDTree ~/workspace/libsapo-php/Etc/Quick-guide-code/blog-project
execute "bwipeout" s:bufnr
1resize 68|vert 1resize 31|2resize 22|vert 2resize 239|3resize 45|vert 3resize 239|
tabnext 1
3wincmd w

" vim: ft=vim ro nowrap smc=128
