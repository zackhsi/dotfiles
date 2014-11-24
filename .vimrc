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

" MacVim
set guifont=Inconsolata-dz
set guioptions-=r
set guioptions-=L

" slash-slash to search for visual selection, h/t http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnorem // y/<c-r>"<cr>

" easy window navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

call pathogen#infect()  " pathogen
call pathogen#helptags() " generate helptags for everything in 'runtimepath'

" Solarized stuff
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized

filetype plugin indent on      " activates indenting for files

let g:netrw_liststyle=3

" Ctrl-P
let g:ctrlp_match_window = 'results:100' " overcome limit imposed by max height

" ctags
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
