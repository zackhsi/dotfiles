let mapleader = "\<Space>"     " Use space as leader

set ai                         " auto indenting
set autoread                   " reread file on focus
set backspace=indent,eol,start " backspace over everything in insert mode"
set colorcolumn=80             " line length matters
set foldmethod=manual          " set a foldmethod
set laststatus=2               " grey status bar at the bottom
set number                     " line numbers
set scrolloff=2                " Always shows two lines of vertical context around the cursor
set showcmd                    " show incomplete commands

set encoding=utf-8             " Set the default encodings just in case $LANG isn't set
set termencoding=utf-8         " Set the default encodings just in case $LANG isn't set

set hlsearch 		           " highlight what you search for
set ic                         " case insensitive search
set incsearch 		           " type-ahead-find
set scs                        " smart case search

set expandtab		           " use spaces instead of tabs
set shiftwidth=4	           " 1 tab == 2 spaces
set smarttab		           " be smart when using tabs
set tabstop=4		           " 1 tab == 2 spaces

set splitbelow                 " all horizontal splits open to the bottom
set splitright                 " all vertical splits open to the right

set mouse=a                    " enable mouse
set ttymouse=xterm2            " more mouse

set nobackup                   " no backup files
set noswapfile                 " no swap files
set nowritebackup              " only in case you don't want a backup file while editing

syntax enable                  " syntax highlighting

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" MacVim
set guifont=Inconsolata-dz:h13
set guioptions-=r
set guioptions-=L

" Leader
vnoremap <Leader>y "+y         " Copy to system clipboard with leader + y
noremap <leader>p :set paste!<CR>  " Toggle paste mode

" slash-slash to search for visual selection, h/t http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnorem // y/<c-r>"<cr>

" activates indenting for files
filetype plugin indent on
autocmd Filetype bash setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype sh setlocal ts=2 sts=2 sw=2
autocmd Filetype zsh setlocal ts=2 sts=2 sw=2

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
Plug 'scrooloose/nerdtree'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

" autocompletion / snippets
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Vim enhancements
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'terryma/vim-multiple-cursors'

" Appearance
Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim'

" Languages (non-Python)
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'burnettk/vim-angular'
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-go'
Plug 'keith/swift.vim'
Plug 'pangloss/vim-javascript'
Plug 'saltstack/salt-vim'
Plug 'stephpy/vim-yaml'

" Python
Plug 'klen/python-mode'
Plug 'fisadev/vim-isort'

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'sjl/vitality.vim'

call plug#end()

""""""""""""""""""""""""""""""
" airline
""""""""""""""""""""""""""""""
let g:airline_theme                           = 'base16'
let g:airline_left_sep                        = ''
let g:airline_right_sep                       = ''
let g:airline_section_y                       = ''
let g:airline#extensions#tabline#enabled      = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#branch#enabled       = 1
let g:airline#extensions#syntastic#enabled    = 1

" Colorscheme
let base16colorspace=256
set background=dark
colorscheme base16-tomorrow

" NERDTree
:command NT NERDTreeToggle
:command NTF NERDTreeFind
let NERDTreeIgnore = ['\.pyc$']

" gitgutter
highlight clear SignColumn

" ctags
command! -nargs=1 Silent
            \ | execute ':silent !'.<q-args>
            \ | execute ':redraw!'
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>zz
map <Leader>c :Silent ctags -R . > /dev/null 2>&1 &<CR>

" fugitive
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" pymode
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_lint_checkers = ['flake8', 'mccabe']

""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""
noremap <silent> <Leader><Leader> :silent FZF <CR>

" Search word under cursor by using Ag | leader + a
noremap <silent> <leader>a :silent Ag <C-r>=expand('<cword>')<CR><CR>

" Search tags in buffer by using leader + t
noremap <silent> <leader>t :silent BTags<CR>

" Search all tags by using leader + T
noremap <silent> <leader>T :silent Tags<CR>

" Search marks by using leader + m
noremap <silent> <leader>m :silent Marks<CR>

function! BufList()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
endfunction

function! BufOpen(e)
    execute 'buffer '. matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :silent call fzf#run({
\   'source':      reverse(BufList()),
\   'sink':        function('BufOpen'),
\   'options':     '+m',
\   'tmux_height': '40%'
\ })<CR>
