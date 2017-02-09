
autocmd FileType php setlocal foldmethod=syntax

" PHP Comments
autocmd FileType php setlocal comments=s1:/**,mb:*,ex:*/,://,:#

" Fold/unfold PHP classes, methods, functions, etc
let g:php_folding=1

" smarty files syntax highlighting
au BufRead,BufNewFile *.tpl set filetype=smarty

" PHP syntax checking configuration
let g:syntastic_php_phpmd_post_args = 'design'
let g:syntastic_php_phpcs_args = '--standard=~/.configuration/php/phpcs_ruleset.xml'

let g:syntastic_twig_twiglint_exec='~/.composer/vendor/asm89/twig-lint/bin/twig-lint'

" documentation lookup, for PHP
"let g:investigate_use_command_for_php = 1
"let g:investigate_command_for_php = '^i:call system(''midori "http://devdocs.io/#q=^s"'')'
"let g:investigate_command_for_php = '^i:call system(''midori -a "http://php.net/search.php?show=quickref&pattern=^s"'')'

let g:padawan#composer_command = "composer"

"DBGp-client configuration
"hi DbgCurrent term=reverse ctermfg=White ctermbg=Red gui=reverse
"hi DbgBreakPt term=reverse ctermfg=Red ctermbg=DarkGrey gui=reverse
"let g:debuggerMaxDepth = 2

" Smarty matching pairs support 
autocmd FileType smarty let b:match_words = '<:>,<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'

