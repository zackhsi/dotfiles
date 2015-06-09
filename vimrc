set nocp                       " set nocompatible
set laststatus=2               " grey status bar at the bottom
syntax enable                  " syntax highlighting
set ai                         " auto indenting
set nu                         " line numbers
set ic                         " case insensitive search
set scs                        " smart case search
set hlsearch 		           " highlight what you search for
set incsearch 		           " type-ahead-find
set expandtab		           " use spaces instead of tabs
set smarttab		           " be smart when using tabs
set shiftwidth=4	           " 1 tab == 2 spaces
set tabstop=4		           " 1 tab == 2 spaces
set ru                         " shows ruler for cursor
set sc                         " showcmd shows incomplete commands
set foldmethod=manual          " set a foldmethod
set splitright                 " all vertical splits open to the right
set colorcolumn=120
set autoread
set backspace=indent,eol,start " backspace over everything in insert mode"

" MacVim
set guifont=Inconsolata-dz:h13
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

" Leader
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>         " <Space>w = save file
nmap <Leader>t :TagbarToggle<CR>  " Toggle Tagba"
vmap <Leader>y "+y                " Copy & paste to system clipboard with <Space>p and <Space>y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Code Navigation
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'

" autocompletion / snippets
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Vim enhancements
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'

" Appearance
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'bling/vim-airline'

" Language specific
Plug 'burnettk/vim-angular'
Plug 'evidens/vim-twig'
Plug 'klen/python-mode'
Plug 'fisadev/vim-isort'
Plug 'fatih/vim-go'
Plug 'saltstack/salt-vim'
Plug 'keith/swift.vim'

" tmux
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

""""""""""""""""""""""""""""""
" airline
""""""""""""""""""""""""""""""
let g:airline_theme                        = 'powerlineish'
let g:airline_left_sep                     = ''
let g:airline_right_sep                    = ''
let g:airline_section_z                    = ''
let g:airline#extensions#tabline#enabled   = 1
let g:airline#extensions#branch#enabled    = 1
let g:airline#extensions#syntastic#enabled = 1

" expand region with v and shrink with <C-v>
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Solarized
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized
" colorscheme Tomorrow-Night-Eighties

" NERDTree
:command NT NERDTreeToggle
:command NTF NERDTreeFind
let NERDTreeIgnore = ['\.pyc$']

" Remap tcomment toggle
nmap <D-/> gcc
vmap <D-/> gcc

" gitgutter
highlight clear SignColumn

" Ctrl-P
let g:ctrlp_match_window = 'results:100' " overcome limit imposed by max height
let g:ctrlp_custom_ignore = '\.pyc'
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    let g:ctrlp_prompt_mappings = {
                \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
                \ }
endif

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
let g:pymode_lint_checkers = ['flake8', 'mccabe']
