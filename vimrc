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
set ru                  " shows ruler for cursor
set sc                  " showcmd shows incomplete commands
set foldmethod=syntax   " set a foldmethod
set foldnestmax=1
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
"remove all scroll bars
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

" detect ini files
au BufNewFile,BufRead *.ini,*.conf setf dosini

" easy window navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" But I like navigating in insert mode
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

" A little hack to redraw the cursor when exiting insert mode.
" Places the cursor at the character from which we exited insert mode.
inoremap <silent> <Esc> <Esc>`^
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Bootstrap vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
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
Plug 'ludovicchabant/vim-gutentags'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " snippet library

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Vim enhancements
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'terryma/vim-multiple-cursors'

" Appearance
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'evanmiller/nginx-vim-syntax'
" Man page navigation
"Plug 'bruno-/vim-man'

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
if $BACKGROUND == 'light'
    set background=light
else
    set background=dark
endif
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
let g:pymode_lint_checkers = ['flake8']

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<S-Enter>"
"let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpForwardTrigger="<C-k>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsJumpBackwardTrigger="<C-j>"

""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""
" Redefine :Ag command
autocmd VimEnter * command! -nargs=* Ag call fzf#vim#ag
            \ (<q-args>,
            \ '--skip-vcs-ignores',
            \ fzf#vim#default_layout)

noremap <silent> <Leader><Leader> :silent FZF <CR>

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Create Blank Newlines and stay in Normal mode
nnoremap <leader>j o<Esc>
nnoremap <leader>k O<Esc>

" Ctrl-Space will toggle folds!
nnoremap <C-Space> za

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
" Remap ;w to escape in insert mode.
inoremap ;; ;<Esc>:w<Enter>
inoremap ;w <Esc>:w<Enter>

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" Clear the highlighting
nnoremap <Esc> <Esc>:noh<Enter>


" remember things yanked in a special register, so we can delete at will
" without concerns
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P

" often I want to find the next _
onoremap W f_
nnoremap W f_l
onoremap E t_
nnoremap E lt_
onoremap B T_
nnoremap B hT_

" In my mind, p means parentheses
onoremap p i(

" Usually, when making the header file, I want to just copy the original file,
" and append a ; to the end of each declaration and delete the body of the
" (folded) function. This automatically does just that.
nmap <Leader>h A;<Esc>jddj

" Make Y like D and every other cap command
nnoremap Y y$

" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" ctags
nnoremap <C-\> :vsp <Enter>:exec("tag ".expand("<cword>"))<Enter>zz

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Make it so there are always several lines visible above and below the cursor
set scrolloff=10

" Properly display man pages
" ==========================
runtime ftplugin/man.vim
if has("gui_running")
	nnoremap K :<C-U>exe "Man" v:count "<C-R><C-W>"<CR>
endif

