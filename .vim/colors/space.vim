" space.vim
" Vim color File
" Maintainer: szorfein
" Last Change: 2016 November 14
" Webpage: https://github.com/szorfein

hi clear

if exists("syntax_on")
    syntax reset
endif

set background=dark 
let colors_name = "space"

" Vim interface
hi Normal ctermfg=5 cterm=none
hi Comment ctermfg=gray ctermbg=black cterm=italic
hi StatusLine ctermfg=white ctermfg=black cterm=none
hi StatusLineNC ctermfg=gray ctermbg=black cterm=none
hi TabLineFill ctermfg=gray ctermbg=black cterm=none
hi PMenu ctermfg=gray ctermbg=black cterm=none
hi ErrorMsg ctermfg=white ctermbg=black cterm=none
hi LineNr ctermfg=247 ctermbg=black cterm=none
hi ModeMsg ctermfg=gray ctermbg=black cterm=none

" Yellow
hi Todo ctermfg=yellow ctermbg=black cterm=none
hi Exception ctermfg=yellow cterm=none

" White
hi Type ctermfg=white cterm=none
hi Title ctermfg=white cterm=bold
hi Number ctermfg=white cterm=bold

" blue
hi Boolean ctermfg=darkblue cterm=none
hi Constant ctermfg=blue ctermbg=none cterm=bold

" Green 
hi Function ctermfg=darkgreen cterm=bold
hi Statement ctermfg=green cterm=none

" Cyan
hi Keyword ctermfg=cyan cterm=none
hi htmlTagName ctermfg=cyan cterm=none

" red
hi Special ctermfg=red cterm=none
hi Conditional ctermfg=red cterm=none

" black
hi String ctermfg=none ctermbg=none cterm=bold
hi Operator ctermbg=none cterm=none

" magenta
hi Identifier ctermfg=magenta cterm=none
hi PreProc ctermfg=magenta cterm=bold

" vim diff
hi DiffAdd     ctermfg=white  ctermbg=red    cterm=none
hi DiffChange  ctermfg=white  ctermbg=red   cterm=none
hi DiffDelete  ctermfg=white  ctermbg=red    cterm=none
hi DiffText    ctermfg=white  ctermbg=red   cterm=none
