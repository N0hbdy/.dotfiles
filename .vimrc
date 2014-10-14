 " Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \    },
  \ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-help'
NeoBundle 'Shougo/unite-session'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'thinca/vim-unite-history'

" General
NeoBundle 'mileszs/ack.vim'
NeoBundle 'Chiel92/vim-autoformat'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-surround'

NeoBundle 'bling/vim-airline' " So much faster than Powerline! :)

" Tags
NeoBundle 'godlygeek/tabular'
NeoBundle 'majutsushi/tagbar'

" Git
NeoBundle 'tpope/vim-fugitive'

" Marks
NeoBundle 'airblade/vim-gitgutter'

" Snippets
NeoBundle 'honza/vim-snippets'
NeoBundle 'SirVer/ultisnips'

" Comments
NeoBundle 'scrooloose/nerdcommenter'

" Shell
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimshell'
NeoBundle 'tpope/vim-dispatch'

""""""""""""""""""""""""""""""
" File types

" HTML/CSS
NeoBundle 'amirh/HTML-AutoCloseTag'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'gorodinskiy/vim-coloresque'
NeoBundle 'tpope/vim-haml'
NeoBundle 'vim-scripts/indenthtml.vim'

" Markdowns
NeoBundle 'tpope/vim-markdown' "Markdown
NeoBundle 'terryma/vim-instant-markdown' "Markdown
NeoBundle 'cespare/vim-toml'

" Ruby
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'

" JavaScripts
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'elzr/vim-json'
NeoBundle 'groenewege/vim-less'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'briancollins/vim-jst'
NeoBundle 'mtscout6/vim-cjsx'

" GoLang
NeoBundle 'fatih/vim-go'

" Elixir
NeoBundle 'elixir-lang/vim-elixir'

""""""""""""""""""""""""
" Colors
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'fatih/molokai'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'spf13/vim-colors'
NeoBundle 'flazz/vim-colorschemes'

call neobundle#end()

" Required:
filetype plugin indent on

syntax on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Solid bar for vertical splits
"set fcs=vert:│

" Turn on line number
set number

" Turn on the mouse, since it doesn't play well with tmux anyway. This way I can
" scroll in the terminal
set mouse=a

" Give one virtual space at end of line
set virtualedit=onemore

" Always splits to the right and below
set splitright
set splitbelow

" 256bit terminal
if has('gui_running')
  set guioptions-=T " Remove the toolbar
  set lines=120 " 120 lines of text instead of 24
  set guifont=Andale\ Mono\ Regular:h14,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
else
  if &term == 'xterm' || &term == 'screen'
    set t_Co=256 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
  endif
endif

" Colorscheme
colorscheme molokai

" Tell Vim to use dark background
set background=dark

" Sets how many lines of history vim has to remember
set history=10000

" Set to auto read when a file is changed from the outside
set autoread

" Set to auto write file
set autowriteall

" Display unprintable chars
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

" listchar=trail is not as flexible, use the below to highlight trailing
" whitespace. Don't do it for unite windows or readonly files
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup MyAutoCmd
  autocmd BufWinEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
  autocmd InsertEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
  autocmd BufWinLeave * if &modifiable && &ft!='unite' | call clearmatches() | endif
augroup END

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=10

" How many lines to scroll at a time, make scrolling appears faster
set scrolljump=3

" Min width of the number column to the left
set numberwidth=1

" Open all folds initially
set foldmethod=indent
set foldlevelstart=99

" No need to show mode
set noshowmode

" Auto complete setting
set completeopt=longest,menuone

set wildmode=list:longest,full
set wildmenu "turn on wild menu
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app

" Allow changing buffer without saving it first
set hidden

" Set backspace config
set backspace=eol,start,indent

" Case insensitive search
set ignorecase
set smartcase

" Make search act like search in modern browsers
set incsearch

" Make regex a little easier to type
set magic

" Don't show matching brackets
set noshowmatch

" Show incomplete commands
set showcmd

" Turn off sound
set vb
set t_vb=

" Always show the statusline
set laststatus=2

" Explicitly set encoding to utf-8
set encoding=utf-8

" Column width indicator
set colorcolumn=+1

" Lower the delay of escaping out of other modes
set timeout timeoutlen=200 ttimeoutlen=1

" Reload vimrc when edited
autocmd MyAutoCmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc
      \ so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Tab settings
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set autoindent


" Text display settings
set linebreak
set textwidth=80
set autoindent
set nowrap
set whichwrap+=h,l,<,>,[,]

" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" Cursor settings. This makes terminal vim sooo much nicer!
" Tmux will only forward escape sequences to the terminal if surrounded by a DCS
" sequence
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Map leader and localleader key to comma
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

" <Leader>p: Copy the full path of the current file to the clipboard
nnoremap <silent> <Leader>p :let @+=expand("%:p")<cr>:echo "Copied current file
      \ path '".expand("%:p")."' to clipboard"<cr>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Adjust view ports to the same size
map <Leader>= <C-w>=

"===============================================================================
" Normal Mode Shift Key Mappings
"===============================================================================

" Q: Closes the window
nnoremap Q :q<cr>

" W: Save
nnoremap W :w<cr>

" Some remapps in the unity section as well

"===============================================================================
" Insert Mode Shift Key Mappings
"===============================================================================

" jj: Esc
imap jj <Esc>





"===============================================================================
" Fugitive
"===============================================================================

nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gc :Gcommit<cr>
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gp :Git push<cr>
nnoremap <Leader>gr :Gremove<cr>
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gw :Gwrite<cr>
" Quickly stage, commit, and push the current file. Useful for editing .vimrc
nnoremap <Leader>gg :Gwrite<cr>:Gcommit -m 'update'<cr>:Git push<cr>


"===============================================================================
" Unite
"===============================================================================

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Set up some custom ignores
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'git5/.*/review/',
      \ 'google/obj/',
      \ 'tmp/',
      \ '.sass-cache',
      \ 'node_modules/',
      \ 'bower_components/',
      \ 'dist/',
      \ '.git5_specs/',
      \ '.pyc',
      \ ], '\|'))

let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--no-color -g'
let g:unite_split_rule = "botright"

nnoremap <C-p> :<C-u>Unite -start-insert file_rec/async<CR>
nnoremap <leader>t :<C-u>Unite buffer<CR>
nnoremap <leader>g :<C-u>Unite grep:.<CR>


"===============================================================================
" Syntax
"===============================================================================

autocmd MyAutoCmd FileType go
      \ setlocal nolist |
      \ setlocal softtabstop=4 |
      \ setlocal shiftwidth=4 |
      \ setlocal noexpandtab

autocmd MyAutoCmd FileType ruby,yml,javascript,coffee,cjsx
      \ setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd BufNewFile,BufReadPost *.cjsx setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab

"===============================================================================
" Airline
"===============================================================================

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HTML Indent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:html_indent_inctags = "html,body,head,tbody"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tags=./tags;/,~/.vimtags

"===============================================================================
" Tagbar
"===============================================================================
if isdirectory(expand("~/.vim/bundle/tagbar/"))
  nnoremap <silent> <leader>tt :TagbarToggle<CR>
  " If using go please install the gotags program using the following
  " go install github.com/jstemmer/gotags
  " And make sure gotags is in your path
  let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds' : [ 'p:package', 'i:imports:1', 'c:constants', 'v:variables',
    \ 't:types', 'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
    \ 'r:constructor', 'f:functions' ],
    \ 'sro' : '.',
    \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
    \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
    \ 'ctagsbin' : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
endif

"===============================================================================
" tabular
"===============================================================================

if isdirectory(expand("~/.vim/bundle/tabular"))
  nmap <Leader>a& :Tabularize /&<CR>
  vmap <Leader>a& :Tabularize /&<CR>
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a=> :Tabularize /=><CR>
  vmap <Leader>a=> :Tabularize /=><CR>
  nmap <Leader>a: :Tabularize /:<CR>
  vmap <Leader>a: :Tabularize /:<CR>
  nmap <Leader>a:: :Tabularize /:\zs<CR>
  vmap <Leader>a:: :Tabularize /:\zs<CR>
  nmap <Leader>a, :Tabularize /,<CR>
  vmap <Leader>a, :Tabularize /,<CR>
  nmap <Leader>a,, :Tabularize /,\zs<CR>
  vmap <Leader>a,, :Tabularize /,\zs<CR>
  nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
  vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif

"===============================================================================
" json
"===============================================================================

nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    let g:vim_json_syntax_conceal = 0

