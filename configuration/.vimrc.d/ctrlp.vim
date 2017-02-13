
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

