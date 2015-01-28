set nocp                " set nocompatible
set laststatus=2        " grey status bar at the bottom
syntax enable           " syntax highlighting
set ai                  " auto indenting
set nu                  " line numbers
set ic                  " case insensitive search
set scs                 " smart case search
set hlsearch 		    " highlight what you search for
set incsearch 		    " type-ahead-find
set expandtab		    " use spaces instead of tabs
set smarttab		    " be smart when using tabs
set shiftwidth=4	    " 1 tab == 2 spaces
set tabstop=4		    " 1 tab == 2 spaces
set ru                  " shows ruler for cursor
set sc                  " showcmd shows incomplete commands
set foldmethod=manual   " set a foldmethod
set splitright          " all vertical splits open to the right
set colorcolumn=120

" MacVim
set guifont=Inconsolata-dz
set guioptions-=r
set guioptions-=L

" slash-slash to search for visual selection, h/t http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnorem // y/<c-r>"<cr>

" activates indenting for files
filetype plugin indent on

" easy window navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Code Navigation
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'

" autocompletion / snippets
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Vim enhancements
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'

" Appearance
Plug 'altercation/vim-colors-solarized'

" Language specific
Plug 'burnettk/vim-angular'
Plug 'evidens/vim-twig'
Plug 'klen/python-mode'

call plug#end()


" Solarized
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized

" NERDTree
:command NT NERDTreeToggle
:command NTF NERDTreeFind
let NERDTreeIgnore = ['\.pyc$']

" gitgutter
highlight clear SignColumn

" Ctrl-P
let g:ctrlp_match_window = 'results:100' " overcome limit imposed by max height
let g:ctrlp_custom_ignore = '\.pyc'

" ctags
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" fugitive
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" pymode
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_lint_checkers = ['flake8']
