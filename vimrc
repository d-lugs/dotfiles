" --------------------------------
" vimrc config
" --------------------------------

filetype on
syntax on
filetype plugin on

" Disable compatibility with vi
set nocompatible

" Prevent a few security exploits
set modelines=0

set autoindent			" Default to indenting files
set backspace=indent,eol,start	" Backspace all characters
set expandtab " space character instead of tabs
set hlsearch " enable highlighting when searching
set ignorecase " ignore caps when searching
set nobackup " do not save backup files
set nostartofline		" Do not jump to first character with page commands
set number " enable line numbers
set ruler			" Enable the ruler
set shiftwidth=4
set showmatch			" Show matching brackets.
set showmode			" Show the current mode in status line
set showcmd			" Show partial command in status line
set smartcase " allows searches specifically for capital letters
set tabstop=4

" --------------------------------
" Init - plugins
" --------------------------------
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

Plug 'hdima/python-syntax'
Plug 'dense-analysis/ale'
call plug#end()




" --------------------------------
" Highlight Unwanted Whitespace
" --------------------------------
highlight RedundantWhitespace ctermbg=green guibg=green
match RedundantWhitespace /\s\+$\| \+\ze\t/