" https://github.com/bling/vim-airline configuration
let g:airline_theme = 'spring_night'

let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:airline#extensions#taboo#enabled = 1
let g:taboo_tabline = 0
let g:taboo_tab_format = '%p'

"AsyncRun plugin airvim status
"let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

