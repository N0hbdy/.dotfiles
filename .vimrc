" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" }

" Environment {
  " Basics {
    set nocompatible
    set shell=/bin/sh
  " }
" }

" Use bundles config {
  if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
  endif
" }

" General {
  set background=dark
  filetype plugin indent on
  syntax on
  set mouse=a " Enable mouse by default
  set mousehide
  scriptencoding utf-8

  if has('clipboard')
    if has('unnamedplus')
      set clipboard=unnamed,unnamedplus
    else
      set clipboard=unnamed
    endif
  endif

  " Set autowrite
  set shortmess+=filmnrxoOtT
  set viewoptions=folds,options,cursor,unix,slash
  set virtualedit=onemore
  set history=1000
  " set spell " Spell checking (yuck, why?)
  set hidden

  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

  " Restore cursor to previous position in editing file
  function! ResCur()
    if line("'\"") <= line("$")
      normal! g`"
      return 1
    endif
  endfunction

  augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
  augroup END

  " Set up backup directories {
  set backup
  if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
  endif
  " }

" }

" Vim UI {
  "let g:use_solarized_color=true
  let g:use_molokai_colors="true"

  if exists('g:use_solarized_color')
    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
      let g:solarized_termcolors=256
      let g:solarized_termtrans=1
      let g:solarized_contrast="normal"
      let g:solarized_visibility="normal"
      color solarized " Load a colorscheme
    endif
  endif

  if exists('g:use_molokai_colors')
    color molokai
  endif

  set tabpagemax=15 " Only show 15 tabs
  set showmode " Display the current mode
  set cursorline " Highlight current line
  highlight clear SignColumn " SignColumn should match background
  highlight clear LineNr " Current line number row will have same background color in relative mode

  if has('cmdline_info')
    set ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd
  endif

  if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\ " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y] " Filetype
    set statusline+=\ [%{getcwd()}] " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
  endif

  set backspace=indent,eol,start " Backspace for dummies
  set linespace=0 " No extra spaces between rows
  set nu " Line numbers on
  set showmatch " Show matching brackets/parenthesis
  set incsearch " Find as you type search
  set hlsearch " Highlight search terms
  set winminheight=0 " Windows can be 0 line high
  set ignorecase " Case insensitive search
  set smartcase " Case sensitive when uc present
  set wildmenu " Show list instead of just completing
  set wildmode=list:longest,full " Command <Tab> completion, list matches, then longest common part, then all.
  set whichwrap=b,s,h,l,<,>,[,] " Backspace and cursor keys wrap too
  set scrolljump=5 " Lines to scroll when cursor leaves screen
  set scrolloff=3 " Minimum lines to keep above and below cursor
  set foldenable " Auto fold code
  set list
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" }

" Formatting {

  set nowrap
  set autoindent
  set shiftwidth=4
  set expandtab
  set tabstop=4
  set softtabstop=4
  set nojoinspaces
  set splitright
  set splitbelow
  set pastetoggle=<F12>
  autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> call StripTrailingWhitespace()

  autocmd FileType go autocmd BufWritePre <buffer> Fmt

  autocmd FileType haskell,puppet,ruby,yml,javascript,coffee setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
  autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
  autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4

" }

" Key (re)mappings {

  let mapleader=','
  let maplocalleader='_'
  map <C-J> <C-W>j<C-W>_
  map <C-K> <C-W>k<C-W>_
  map <C-L> <C-W>l<C-W>_
  map <C-H> <C-W>h<C-W>_

  imap jj <Esc>

  noremap j gj
  noremap k gk

  function! WrapRelativeMotion(key, ...)
    let vis_sel=""
    if a:0
      let vis_sel="gv"
    endif
    if &wrap
      execute "normal!" vis_sel . "g" . a:key
    else
      execute "normal!" vis_sel . a:key
    endif
  endfunction

  noremap $ :call WrapRelativeMotion("$")<CR>
  noremap <End> :call WrapRelativeMotion("$")<CR>
  noremap 0 :call WrapRelativeMotion("0")<CR>
  noremap <Home> :call WrapRelativeMotion("0")<CR>
  noremap ^ :call WrapRelativeMotion("^")<CR>
  " Overwrite the operator pending $/<End> mappings from above
  " to force inclusive motion with :execute normal!
  onoremap $ v:call WrapRelativeMotion("$")<CR>
  onoremap <End> v:call WrapRelativeMotion("$")<CR>
  " Overwrite the Visual+select mode mappings from above
  " to ensure the correct vis_sel flag is passed to function
  vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
  vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
  vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
  vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
  vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

  if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  endif

  cmap Tabe tabe

  nnoremap Y y$

  " Code folding options
  nmap <leader>f0 :set foldlevel=0<CR>
  nmap <leader>f1 :set foldlevel=1<CR>
  nmap <leader>f2 :set foldlevel=2<CR>
  nmap <leader>f3 :set foldlevel=3<CR>
  nmap <leader>f4 :set foldlevel=4<CR>
  nmap <leader>f5 :set foldlevel=5<CR>
  nmap <leader>f6 :set foldlevel=6<CR>
  nmap <leader>f7 :set foldlevel=7<CR>
  nmap <leader>f8 :set foldlevel=8<CR>
  nmap <leader>f9 :set foldlevel=9<CR>

  " Find merge conflict markers
  map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
  " Shortcuts
  " Change Working Directory to that of the current file
  cmap cwd lcd %:p:h
  cmap cd. lcd %:p:h

  " Visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv

  " For when you forget to sudo.. Really Write the file.
  cmap w!! w !sudo tee % >/dev/null

  " Easy edits
  cnoremap %% <C-R>=expand('%:h').'/'<cr>
  map <leader>ew :e %%
  map <leader>es :sp %%
  map <leader>ev :vsp %%
  map <leader>et :tabe %%

  " Adjust viewports to the same size
  map <Leader>= <C-w>=
  " Map <Leader>ff to display all lines with keyword under cursor
  " and ask which one to jump to
  nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
  " Easier horizontal scrolling
  map zl zL
  map zh zH
  " Easier formatting
  nnoremap <silent> <leader>q gwip

" }

" Plugins {
  " neocomplete {
      let g:acp_enableAtStartup = 0
      let g:neocomplete#enable_at_startup = 1
      let g:neocomplete#enable_smart_case = 1
      let g:neocomplete#enable_auto_delimiter = 1
      let g:neocomplete#max_list = 15
      let g:neocomplete#force_overwrite_completefunc = 1


      " Define dictionary.
      let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

      " Define keyword.
      if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
      endif
      let g:neocomplete#keyword_patterns['default'] = '\h\w*'

      " Plugin key-mappings {
      " These two lines conflict with the default digraph mapping of <C-K>
      if !exists('g:spf13_no_neosnippet_expand')
        imap <C-k> <Plug>(neosnippet_expand_or_jump)
        smap <C-k> <Plug>(neosnippet_expand_or_jump)
      endif
      if exists('g:spf13_noninvasive_completion')
        iunmap <CR>
        " <ESC> takes you out of insert mode
        inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
        " <CR> accepts first, then sends the <CR>
        inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
        " <Down> and <Up> cycle like <Tab> and <S-Tab>
        inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
        " Jump up and down the list
        inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
      else
        " <C-k> Complete Snippet
        " <C-k> Jump to next snippet point
        imap <silent><expr><C-k> neosnippet#expandable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
          \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
        smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

        inoremap <expr><C-g> neocomplete#undo_completion()
        inoremap <expr><C-l> neocomplete#complete_common_string()
        "inoremap <expr><CR> neocomplete#complete_common_string()

        " <CR>: close popup
        " <s-CR>: close popup and save indent.
        inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()"\<CR>" : "\<CR>"

        function! CleverCr()
          if pumvisible()
            if neosnippet#expandable()
              let exp = "\<Plug>(neosnippet_expand)"
              return exp . neocomplete#smart_close_popup()
            else
              return neocomplete#smart_close_popup()
            endif
              else
            return "\<CR>"
          endif
        endfunction

        " <CR> close popup and save indent or expand snippet 
        imap <expr> <CR> CleverCr() 
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y> neocomplete#smart_close_popup()
      endif
      " <TAB>: completion.
      inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

      " Courtesy of Matteo Cavalleri

      function! CleverTab()
        if pumvisible()
          return "\<C-n>"
        endif
        let substr = strpart(getline('.'), 0, col('.') - 1)
        let substr = matchstr(substr, '[^ \t]*$')
        if strlen(substr) == 0
          " nothing to match on empty string
          return "\<Tab>"
        else
          " existing text matching
          if neosnippet#expandable_or_jumpable()
            return "\<Plug>(neosnippet_expand_or_jump)"
          else
            return neocomplete#start_manual_complete()
          endif
        endif
      endfunction

      imap <expr> <Tab> CleverTab()
    " }

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
  " }


  " Misc {
    if isdirectory(expand("~/.vim/bundle/nerdtree"))
      let g:NERDShutUp=1
    endif
    if isdirectory(expand("~/.vim/bundle/matchit.zip"))
      let b:match_ignorecase = 1
    endif
  " }

  " Ctags {
    set tags=./tags;/,~/.vimtags

    "Make ags placed in .git/tags file available in all levels of a repository
    let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
    if gitroot != ''
      let &tags = &tags . ',' . gitroot . '/.git/tags'
    endif
  " }

  " AutoCloseTag {
    " Make it so AutoCloseTag works for xml and xhtml files as well
    au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    nmap <Leader>ac <Plug>ToggleAutoCloseMappings
  " }

  " NerdTree {
    if isdirectory(expand("~/.vim/bundle/nerdtree"))
      map <C-e> <plug>NERDTreeTabsToggle<CR>
      map <leader>e :NERDTreeFind<CR>
      nmap <leader>nt :NERDTreeFind<CR>
      let NERDTreeShowBookmarks=1
      let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
      let NERDTreeChDirMode=0
      let NERDTreeQuitOnOpen=1
      let NERDTreeMouseMode=2
      let NERDTreeShowHidden=1
      let NERDTreeKeepTreeInNewTab=1
      let g:nerdtree_tabs_open_on_gui_startup=0
    endif
  " }


  " Tabularize {
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
  " }

  " Session List {
    set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
      if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
      nmap <leader>sl :SessionList<CR>
      nmap <leader>ss :SessionSave<CR>
      nmap <leader>sc :SessionClose<CR>
   endif
  " }

  " JSON {
    nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    let g:vim_json_syntax_conceal = 0
  " }

  " PyMode {
    if isdirectory(expand("~/.vim/bundle/python-mode"))
      let g:pymode_link_checkers = ['pyflakes']
      let g:pymode_trim_whitespaces = 0
      let g:pymode_options = 0
      let g:pymode_rope = 0
    endif
  " }

  " ctrlp {
    if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
      let g:ctrlp_working_path_mode = 'ra'
      nnoremap <silent> <D-t> :CtrlP<CR>
      nnoremap <silent> <D-r> :CtrlPMRU<CR>
      let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$',
      \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

      if executable('ag')
        let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
      elseif executable('ack-grep')
        let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
      elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
      else
        let s:ctrlp_fallback = 'find %s -type f'
      endif

      let g:ctrlp_user_command = {
      \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
      \ 2: ['.hg', 'hg --cwd %s locate -I .'],
      \ },
      \ 'fallback': s:ctrlp_fallback
      \ }

      if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
        " CtrlP extensions
        let g:ctrlp_extensions = ['funky']
        "funky
        nnoremap <Leader>fu :CtrlPFunky<Cr>
      endif
    endif
  " }


   " TagBar {
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
  "}

  " Fugitive {
    if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
      nnoremap <silent> <leader>gs :Gstatus<CR>
      nnoremap <silent> <leader>gd :Gdiff<CR>
      nnoremap <silent> <leader>gc :Gcommit<CR>
      nnoremap <silent> <leader>gb :Gblame<CR>
      nnoremap <silent> <leader>gl :Glog<CR>
      nnoremap <silent> <leader>gp :Git push<CR>
      nnoremap <silent> <leader>gr :Gread<CR>
      nnoremap <silent> <leader>gw :Gwrite<CR>
      nnoremap <silent> <leader>ge :Gedit<CR>
      " Mnemonic _i_nteractive
      nnoremap <silent> <leader>gi :Git add -p %<CR>
      nnoremap <silent> <leader>gg :SignifyToggle<CR>
    endif
  " }

  " Ag/Ack {
    let g:ackprg="ag --nogroup --nocolor --column --smart-case"
  " }
" }


" GUI Settings {
  " GVIM- (here instead of .gvimrc)
  if has('gui_running')
    set guioptions-=T " Remove the toolbar
    set lines=40 " 40 lines of text instead of 24
    set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
  else
    if &term == 'xterm' || &term == 'screen'
      set t_Co=256 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    "set term=builtin_ansi " Make arrow and other keys work
  endif
" }

" Functions {
  " Initialize directories {
    function! InitializeDirectories()
      let parent = $HOME
      let prefix = 'vim'
      let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory' }
      if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
      endif
      " To specify a different directory in which to place the vimbackup,
      " vimviews, vimundo, and vimswap files/directories, add the following to
      " your .vimrc.before.local file:
      " let g:spf13_consolidated_directory = <full path to desired directory>
      " eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
      let common_dir = parent . '/.' . prefix
      for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
          if !isdirectory(directory)
            call mkdir(directory)
          endif
        endif
        if !isdirectory(directory)
          echo "Warning: Unable to create backup directory: " . directory
          echo "Try: mkdir -p " . directory
        else
          let directory = substitute(directory, " ", "\\\\ ", "g")
          exec "set " . settingname . "=" . directory
        endif
      endfor
    endfunction

    call InitializeDirectories()
  " }

  " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
      redir => bufoutput
      buffers!
      redir END
      let idx = stridx(bufoutput, "NERD_tree")
      if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
      endif
    endfunction
  " }

  " Strip whitespace {
    function! StripTrailingWhitespace()
      " Preparation: save last search, and cursor position.
      let _s=@/
      let l = line(".")
      let c = col(".")
      " do the business:
      %s/\s\+$//e
      " clean up: restore previous search history, and cursor position
      let @/=_s
      call cursor(l, c)
    endfunction
  " }

  " Shell command {
    function! s:RunShellCommand(cmdline)
      botright new
      setlocal buftype=nofile
      setlocal bufhidden=delete
      setlocal nobuflisted
      setlocal noswapfile
      setlocal nowrap
      setlocal filetype=shell
      setlocal syntax=shell
      call setline(1, a:cmdline)
      call setline(2, substitute(a:cmdline, '.', '=', 'g'))
      execute 'silent $read !' . escape(a:cmdline, '%#')
      setlocal nomodifiable
      1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
  " }
" }
