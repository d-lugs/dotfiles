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

" Basic settings
set autoindent			" Default to indenting files
set backspace=indent,eol,start	" Backspace all characters
set expandtab			" space character instead of tabs
set hlsearch			" enable highlighting when searching
set ignorecase			" ignore caps when searching
set nobackup			" do not save backup files
set nostartofline		" Do not jump to first character with page commands
set number			" show current line number
set ruler			" Enable the ruler
set shiftwidth=4
set showmatch			" Show matching brackets.
set showmode			" Show the current mode in status line
set showcmd			" Show partial command in status line
set smartcase			" allows searches specifically for capital letters
set tabstop=4

" --------------------------------
" Shortcuts
" --------------------------------
" map-command {lhs} {rhs}
"
" example:
" nnoremap ,<space> :nhlsearch<CR>

" scroll in place without cursor
nnoremap <S-up> 5<c-y>
nnoremap <S-down> 5<c-e>
" scroll 1/2 screen with cursor
nnoremap <c-up> <c-u>
nnoremap <c-down> <c-d>

" toggle relative line numbers
nnoremap ln :set relativenumber!<cr>


" --------------------------------
" Init - plugins
" --------------------------------
"     :source .nvimrc   reload nvim config
"     :PlugInstall      to install plugins
"     :PlugUpdate       to update plugins
"     :PlugDiff         to review the changes from the last update
"     :PlugClean        to remove plugins no longer in the list
call plug#begin()
Plug 'karb94/neoscroll.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'hdima/python-syntax'
Plug 'dense-analysis/ale'
call plug#end()

" Plugin config
let g:airline_theme = "nord_minimal"

" --------------------------------
" Formatting
" --------------------------------

" Highlight Unwanted Whitespace
highlight RedundantWhitespace ctermbg=green guibg=green
match RedundantWhitespace /\s\+$\| \+\ze\t/

" Change line number coloring
highlight LineNr ctermfg=darkgrey
