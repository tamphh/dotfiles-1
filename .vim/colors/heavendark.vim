" heavendark.vim
" Vim color File
" Maintainer: szorfein
" Last Change: 2016 November 2
" Webpage: https://github.com/szorfein

hi clear

if exists("syntax_on")
    syntax reset
endif

set background=light
let colors_name = "heavendark"

" Vim interface
hi Normal ctermfg=0 cterm=none
hi Comment ctermfg=gray ctermbg=black cterm=italic
hi StatusLine ctermfg=gray ctermfg=black cterm=none
hi StatusLineNC ctermfg=gray ctermbg=black cterm=none
hi TabLineFill ctermfg=gray ctermbg=black cterm=none
hi PMenu ctermfg=gray ctermbg=black cterm=none
hi ErrorMsg ctermfg=white ctermbg=black cterm=none
hi LineNr ctermfg=247 ctermbg=black cterm=none
hi ModeMsg ctermfg=gray ctermbg=black cterm=none

" Yellow
hi Todo ctermfg=yellow ctermbg=black cterm=none

" blue
hi Boolean ctermfg=darkblue cterm=none

" Cyan
hi Function ctermfg=darkcyan cterm=bold
hi Number ctermfg=darkcyan cterm=bold
hi Constant ctermfg=cyan ctermbg=none cterm=bold

" red
hi Statement ctermfg=red cterm=none
hi Special ctermfg=red cterm=none
hi Conditional ctermfg=red cterm=none

" black
hi String ctermfg=none ctermbg=none cterm=bold
hi Operator ctermbg=none cterm=none

" magenta
hi Identifier ctermfg=magenta cterm=none
hi PreProc ctermfg=magenta cterm=bold

hi DiffAdd     ctermfg=0  ctermbg=1    cterm=none
hi DiffChange  ctermfg=0  ctermbg=1   cterm=none
hi DiffDelete  ctermfg=0  ctermbg=1    cterm=none
hi DiffText    ctermfg=0  ctermbg=1   cterm=none
