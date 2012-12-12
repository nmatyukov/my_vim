" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "default"

"  #ffa0a0
hi Constant term=underline ctermfg=DarkRed guifg=#ff0a0a guibg=#e8e8e8

" functions
hi Function guifg=Maroon 
"guibg=#c0c0c0

" vim: sw=2
