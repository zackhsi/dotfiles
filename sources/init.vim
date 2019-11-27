set encoding=utf-8
scriptencoding utf-8

let mapleader = "\<Space>"         " Use space as leader

set colorcolumn=+1                 " line length matters
set foldmethod=manual              " set a foldmethod
set hidden
set mouse=a                        " enable mouse
set number                         " line numbers
set scrolloff=2                    " Always shows two lines of vertical context around the cursor
set showcmd                        " show incomplete commands
set undofile
set updatetime=200

set hlsearch                       " highlight what you search for
set ignorecase                     " case insensitive search
set incsearch                      " type-ahead-find
set smartcase                      " smart case search
set inccommand=nosplit             " in-place substitution preview

set expandtab                      " use spaces instead of tabs
set shiftwidth=4                   " 1 tab == 2 spaces
set tabstop=4                      " 1 tab == 2 spaces

set splitbelow                     " all horizontal splits open to the bottom
set splitright                     " all vertical splits open to the right

set nobackup                       " no backup files
set noswapfile                     " no swap files
set nowritebackup                  " only in case you don't want a backup file while editing

" Reload vimrc.
nnoremap <leader>v :source $MYVIMRC<CR>

" Copy selection to system clipboard.
vnoremap <Leader>y "+y

" Copy current filepath to systen clipboard.
nnoremap <Leader>f :let @+ = expand("%")<CR>
nnoremap <Leader>F :let @+ = expand("%:t")<CR>
command! Dirname :let @+ = expand("%:h")

" Double slash to search for visual selection.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnorem // y/<c-r>"<cr>

filetype plugin indent on
augroup Indentation
  autocmd!
  autocmd Filetype Dockerfile setlocal tabstop=4 softtabstop=4 shiftwidth=0
  autocmd Filetype bash       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype bzl        setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd Filetype coffee     setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype ruby       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype sh         setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype sql        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype thrift     setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype vim        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype xml        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype yaml       setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup FileTypeAliases
  autocmd!
  autocmd BufNewFile,BufRead *.pyi setfiletype python
  autocmd BufNewFile,BufRead {.,}tmux*.conf* setfiletype tmux
  autocmd BufNewFile,BufRead *.ini,*.conf setf dosini
  autocmd BufNewFile,BufRead Pipfile set filetype=toml
  autocmd BufNewFile,BufRead Pipfile.lock set filetype=json
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript
  autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
augroup END

augroup KeywordProgram
  autocmd!
  autocmd Filetype ruby setlocal keywordprg=:terminal\ ri
augroup END

" Reload edited files.
augroup improved_autoread
  autocmd FocusGained * checktime
  autocmd FocusGained * GitGutterAll
  autocmd BufEnter * checktime
  autocmd BufEnter * GitGutterAll
augroup end
noremap <c-z> :suspend<cr>:checktime<cr>:GitGutterAll<cr>

" Window navigation.
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> :<C-u>TmuxNavigateLeft<CR>
nmap <C-l> <C-w>l

" Move by screen lines.
noremap j gj
noremap k gk

" Filter command history.
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Exit terminal mode with ESC.
tnoremap <Esc> <C-\><C-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:plug_shallow = 0

" Bootstrap vim-plug.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup VimPlugBootstrap
    autocmd!
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
endif
call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Theme.
let g:airline_theme                    = 'base16'
let g:airline_base16_improved_contrast = 1

" Airline config.
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline_section_y = ''

" Tabline config.
let g:airline#extensions#tabline#enabled           = 1
let g:airline#extensions#tabline#show_buffers      = 0
let g:airline#extensions#tabline#fnamemod          = ':t' " Only show file name.
let g:airline#extensions#tabline#show_tab_nr       = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_count    = 0
let g:airline#extensions#tabline#show_splits       = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'w0rp/ale'

nmap <silent> [l <Plug>(ale_previous_wrap)
nmap <silent> ]l <Plug>(ale_next_wrap)
nmap <silent> <leader>d <Plug>(ale_go_to_definition)

let g:ale_sign_warning='●'
let g:ale_sign_error='●'

let g:ale_linters = {}
let g:ale_linter_aliases = {}
let g:ale_fix_on_save = 1
let g:ale_fixers = {'*': []}

" Bazel.
Plug '~/oss/ale-bazel'
let g:ale_linters['bzl'] = ['bazel-scala']
let g:ale_linters['scala'] = ['scalac', 'bazel-scala']

" Javascript.
let g:ale_linters['javascript'] = ['flow', 'eslint']
let g:ale_fixers['javascript'] = ['prettier']

" Ruby.
Plug '~/oss/sorbet-lsp'
" Rubocop in pay-server requires `bundle install`.
let g:ale_linters['ruby'] = ['rubocop', 'ruby']
let g:ale_fixers['ruby'] = ['rubocop']
if fnamemodify(getcwd(), ':p') == $HOME.'/stripe/pay-server/'
  let g:ale_ruby_rubocop_options = '--except PrisonGuard/AutogenLoaderPreamble'
  call add(g:ale_linters['ruby'], 'sorbet-lsp')
end

" Scala.
let g:ale_fixers['scala'] = ['scalafmt']
let g:ale_scala_scalafmt_executable = 'scalafmt_fast'

function! CheckScalafmtNg()
  silent execute('!nc -z localhost 2113')
  if v:shell_error
    set cmdheight=2
    echohl WarningMsg
    echo expand('%').' written. Start `scalafmt_ng` process to speed up scalafmt runs.'
    echohl None
    set cmdheight=1
  endif
endfunction

augroup CheckScalafmtNg
  autocmd!
  autocmd BufWritePost *.scala call CheckScalafmtNg()
augroup END

" Terraform.
let g:ale_fixers['terraform'] = ['terraform']

" Typescript.
let g:ale_linter_aliases = {'typescriptreact': 'typescript'}
let g:ale_linters['typescript'] = ['eslint', 'tslint']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['typescriptreact'] = ['prettier']

for key in keys(g:ale_fixers)
  call add(g:ale_fixers[key], 'remove_trailing_lines')
  call add(g:ale_fixers[key], 'trim_whitespace')
endfor

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Base16.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'chriskempson/base16-vim'

function! s:base16_customize() abort
  let l:background     = '00'
  let l:red            = '01'
  let l:green          = '02'
  let l:yellow         = '03'
  let l:blue           = '04'
  let l:magenta        = '05'
  let l:cyan           = '06'
  let l:white          = '07'
  let l:bright_black   = '08'
  let l:bright_red     = '09'
  let l:bright_green   = '10'
  let l:bright_yellow  = '11'
  let l:bright_blue    = '12'
  let l:bright_magenta = '13'
  let l:bright_cyan    = '14'
  let l:bright_white   = '15'

  " Ale.
  call Base16hi('SpellCap'              , '' , '' , yellow     , background    , ''       , '')
  call Base16hi('ALEWarningSign'        , '' , '' , yellow     , background    , ''       , '')
  call Base16hi('SpellBad'              , '' , '' , red        , background    , ''       , '')
  call Base16hi('ALEErrorSign'          , '' , '' , red        , background    , ''       , '')

  " Comments.
  call Base16hi('Comment'               , '' , '' , ''         , ''            , 'italic' , '')

  " Gitgutter.
  call Base16hi('GitGutterAdd'          , '' , '' , ''         , background    , ''       , '')
  call Base16hi('GitGutterChange'       , '' , '' , ''         , background    , ''       , '')
  call Base16hi('GitGutterDelete'       , '' , '' , ''         , background    , ''       , '')
  call Base16hi('GitGutterChangeDelete' , '' , '' , ''         , background    , ''       , '')

  " Javascript.
  call Base16hi('xmlTagName'            , '' , '' , blue       , ''            , 'bold'   , '')
  call Base16hi('xmlEndTag'             , '' , '' , red        , ''            , 'bold'   , '')
  call Base16hi('xmlAttrib'             , '' , '' , yellow     , ''            , 'italic'   , '')

  " Jinja.
  call Base16hi('jinjaTagDelim'         , '' , '' , blue       , ''            , ''       , '')

  " Line numbers.
  call Base16hi('CursorLineNr'          , '' , '' , ''         , background    , ''       , '')
  call Base16hi('LineNr'                , '' , '' , ''         , background    , ''       , '')

  " Matches.
  call Base16hi('MatchParen'            , '' , '' , ''         , bright_yellow , ''       , '')
  call Base16hi('MatchWord'             , '' , '' , ''         , bright_yellow , ''       , '')

  " NERDTree.
  call Base16hi('NERDTreeExecFile'      , '' , '' , green      , ''            , 'bold'   , '')

  " Python.
  call Base16hi('pythonInclude'         , '' , '' , bright_red , ''            , 'italic' , '')
  call Base16hi('pythonDocstring'       , '' , '' , cyan       , ''            , 'italic' , '')
  call Base16hi('pythonOperator'        , '' , '' , red        , ''            , ''       , '')

  " Ruby.
  call Base16hi('Sig'                   , '' , '' , background , magenta       , 'italic' , '')
  call Base16hi('rubyDefine'            , '' , '' , magenta    , ''            , 'italic' , '')
  call Base16hi('rubySymbol'            , '' , '' , ''         , ''            , 'bold'   , '')
  call Base16hi('rubyboolean'           , '' , '' , cyan       , ''            , 'bold'   , '')

  " Scala.
  call Base16hi('Include'               , '' , '' , ''         , ''            , 'italic' , '')

  " Title.
  call Base16hi('Title'                 , '' , '' , ''         , ''            , 'bold'   , '')

endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

" Print highlight group under cursor with leader + h.
map <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto pairs.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'andymass/vim-matchup'
let g:matchup_matchparen_deferred = 1

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Docker.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'ekalinin/Dockerfile.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
set diffopt+=vertical " Vertical diffs.
let g:github_enterprise_urls = ['git.corp.stripe.com']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

" Configure g:fzf_colors sparingly! Prefer FZF_DEFAULT_OPTS.
let g:fzf_colors = {
      \ 'border':  ['fg', 'Comment'],
      \ }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --glob "!.git/*" --column --line-number --no-heading --smart-case --color=always --colors match:fg:blue ' . <q-args>, 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:40%', '?'),
  \   <bang>0)

augroup FZF
  autocmd!
  autocmd FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

if trim(system('git rev-parse --is-inside-work-tree')) ==# 'true'
  noremap <silent> <Leader><Leader> :call fzf#vim#gitfiles('', fzf#vim#with_preview('right:40%'))<CR>
else
  noremap <silent> <Leader><Leader> :silent FZF <CR>
endif

" Search word under cursor with leader + r.
nnoremap <silent> <leader>r :silent Rg --case-sensitive --fixed-strings --word-regexp <C-r>=expand('<cword>')<CR><CR>
" Search visual selection with leader + r.
vnoremap <silent> <leader>r y:silent Rg --case-sensitive --fixed-strings '<C-r>"'<CR>

" Search tags in buffer by using leader + t.
noremap <silent> <leader>t :silent BTags<CR>

" Search tags in buffer by using leader + /.
noremap <silent> <leader>/ :silent BLines<CR>

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

Plug '~/oss/fzf-tags'
nmap <C-]> <Plug>(fzf_tags)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git gutter.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'airblade/vim-gitgutter'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Golang.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Goyo.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/goyo.vim'
noremap <silent> <leader>g :Goyo<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GraphQL.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'jparise/vim-graphql'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gutentags.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $NOTAGS !=# '1'
  Plug 'ludovicchabant/vim-gutentags'
end
noremap <Leader>c :GutentagsUpdate!<CR>
let g:gutentags_define_advanced_commands = 1
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
let g:gutentags_generate_on_empty_buffer = 1
let g:gutentags_ctags_exclude = [
  \ '.eggs',
  \ '.mypy_cache',
  \ 'venv',
  \ 'tags',
  \ 'tags.temp',
  \ '.ijwb',
  \ 'bazel-*',
\ ]
let g:gutentags_ctags_executable_ruby = 'ripper-tags --ignore-unsupported-options --recursive'
if fnamemodify(getcwd(), ':p') =~ $HOME.'/stripe/'
  let g:gutentags_project_info = []
  call add(g:gutentags_project_info, {'type': 'ruby', 'file': '.solargraph.yml'})
  call add(g:gutentags_project_info, {'type': 'scala', 'file': '.scalafmt.conf'})
end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Javascript.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

Plug 'pangloss/vim-javascript'

Plug 'kchmck/vim-coffee-script'

augroup DetectEmbeddedCoffeeScript
  autocmd!
  autocmd BufNewFile,BufRead *.eco set filetype=xml
  autocmd BufNewFile,BufRead *.eco execute ':ALEDisableBuffer'
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Multiple cursors.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mg979/vim-visual-multi'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NCM.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" Enable ncm2 for all buffers.
augroup NCM2
  autocmd!
  autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

" :help Ncm2PopupOpen for more information.
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tagprefix'
Plug 'ncm2/ncm2-tmux'

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree'
:command! NT NERDTreeToggle
:command! NTF NERDTreeFind
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=0

Plug '~/oss/nerdtree-rg.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Onedark.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'joshdick/onedark.vim'
let g:onedark_termcolors=16

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Parenthesis.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/rainbow_parentheses.vim'
augroup RainbowParentheses
  autocmd!
  autocmd Filetype * RainbowParentheses
  autocmd Filetype sls RainbowParentheses!
augroup END
let g:rainbow#blacklist = [0, 1, 7, 8, 9, 10, 11, 12, 13, 14, 15]
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Puppet.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'rodjek/vim-puppet'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Speed up Neovim start up.
let g:loaded_python_provider = 1
let g:python3_host_prog = '/Users/zackhsi/.pyenv/versions/3.6.5/bin/python3'

Plug 'klen/python-mode'
let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_motion = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_run_bind = ''

Plug 'ambv/black'
Plug 'fisadev/vim-isort'
augroup PythonAutoFormat
  autocmd!
  if filereadable('.black')
    autocmd BufWritePre *.py execute ':Isort'
    autocmd BufWritePre *.py execute ':silent Black'
  endif
augroup END

Plug 'davidhalter/jedi-vim'
let g:jedi#completions_enabled = 0
let g:jedi#rename_command = ''

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Repeat.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-repeat'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-ruby/vim-ruby'
Plug '~/oss/sorbet.vim'

" <cword> expansion relies on `iskeyword`. This fixes tag jumping.
augroup RubySpecialKeywordCharacters
  autocmd!
  autocmd Filetype ruby setlocal iskeyword+=!
  autocmd Filetype ruby setlocal iskeyword+=?
augroup END

Plug '~/oss/fzf-copy-ruby-token'
nmap <leader>ry <Plug>(fzf_copy_ruby_token)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rust.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
let g:racer_experimental_completer = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scala.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'derekwyatt/vim-scala'
let g:scala_use_builtin_tagbar_defs = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Solarized.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'altercation/vim-colors-solarized'

"   option name                         default      optional
"   --------------------------------------------------------------
let g:solarized_termcolors = 16       " 16       |   256
let g:solarized_termtrans  = 0        " 0        |   1
let g:solarized_degrade    = 0        " 0        |   1
let g:solarized_bold       = 1        " 1        |   0
let g:solarized_underline  = 1        " 1        |   0
let g:solarized_italic     = 1        " 1        |   0
let g:solarized_contrast   = 'normal' " 'normal' |   'high' or 'low'
let g:solarized_visibility = 'normal' " 'normal' |   'high' or 'low'
let g:solarized_hitrail    = 1        " 0        |   1
let g:solarized_menu       = 1        " 1        |   0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SQL.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup SQL
  autocmd!
  autocmd Filetype sql command! SQLFMT :%!sqlfmt --align --print-width 200 --no-simplify --tab-width 2 --use-spaces
  autocmd Filetype sql nnoremap <leader>s :SQLFMT<CR>
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stripe.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:PayTest()
  let pay_test_command = '"pay test ' . expand('%') . ' -l ' . line('.') . '"'
  execute 'silent !tmux send-keys -R -t "pay test" ' . pay_test_command . ' Enter'
  execute 'silent !tmux select-window -t "pay test"'
endfunction

if fnamemodify(getcwd(), ':p') == $HOME.'/stripe/pay-server/'
  nnoremap <leader>pt :call <SID>PayTest()<CR>
end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Surround.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-surround'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'godlygeek/tabular'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'majutsushi/tagbar'
:command! TT TagbarToggle
let g:tagbar_sort = 0

" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : 'markdown2ctags',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

if executable('ripper-tags')
  let g:tagbar_type_ruby = {
      \ 'kinds'      : ['m:modules',
                      \ 'c:classes',
                      \ 'C:constants',
                      \ 'F:singleton methods',
                      \ 'f:methods',
                      \ 'a:aliases'],
      \ 'kind2scope' : { 'c' : 'class',
                       \ 'm' : 'class' },
      \ 'scope2kind' : { 'class' : 'c' },
      \ 'ctagsbin'   : 'ripper-tags',
      \ 'ctagsargs'  : ['-f', '-']
      \ }
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tcomment.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tomtom/tcomment_vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terraform.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'hashivim/vim-terraform'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Thrift
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'solarnz/thrift.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmux.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'christoomey/vim-tmux-navigator'
Plug 'sjl/vitality.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Typescript.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntax.
Plug 'HerringtonDarkholme/yats.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undo.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mbbill/undotree'
noremap <silent> <leader>u :UndotreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unimpaired.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-unimpaired'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vader.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/vader.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Zoom.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'dhruvasagar/vim-zoom'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages (non-Python).
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'bfontaine/Brewfile.vim'
Plug 'burnettk/vim-angular'
Plug 'cespare/vim-toml'
Plug 'keith/swift.vim'
Plug 'keith/tmux.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'saltstack/salt-vim'

call plug#end()

colorscheme base16-default-light

" For some silly reason, :set ft=help leads to a positive conceallevel.
augroup ConcealLevel
  autocmd!
  autocmd Filetype help set conceallevel=0
augroup END
