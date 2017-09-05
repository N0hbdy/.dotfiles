if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/amcrae/.config/nvim/init.vim', '/Users/amcrae/.config/nvim/rc/dein.toml', '/Users/amcrae/.config/nvim/rc/deinlazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/amcrae/.config/nvim/dein'
let g:dein#_runtime_path = '/Users/amcrae/.config/nvim/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/Users/amcrae/.config/nvim/dein/.cache/init.vim'
let &runtimepath = '/Users/amcrae/.config/nvim,/etc/xdg/nvim,/Users/amcrae/.local/share/nvim/site,/usr/local/share/nvim/site,/Users/amcrae/.config/nvim/dein/repos/github.com/Shougo/dein.vim,/Users/amcrae/.config/nvim/dein/repos/github.com/Shougo/context_filetype.vim,/Users/amcrae/.config/nvim/dein/.cache/init.vim/.dein,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.2.0_1/share/nvim/runtime,/Users/amcrae/.config/nvim/dein/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/amcrae/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/amcrae/.config/nvim/after'
filetype off
silent! command -complete=customlist,dein#autoload#_dummy_complete -bang -bar -range -nargs=* Denite call dein#autoload#_on_cmd('Denite', 'denite.nvim', <q-args>,  expand('<bang>'), expand('<line1>'), expand('<line2>'))
silent! command -complete=customlist,dein#autoload#_dummy_complete -bang -bar -range -nargs=* Deol call dein#autoload#_on_cmd('Deol', 'deol.nvim', <q-args>,  expand('<bang>'), expand('<line1>'), expand('<line2>'))
silent! nnoremap <unique><silent> <Plug>(vimshell :call dein#autoload#_on_map('<lt>Plug>(vimshell', 'vimshell.vim','n')<CR>
  nnoremap <silent> ;r :<C-u>Denite -buffer-name=register register neoyank<CR>
  xnoremap <silent> ;r :<C-u>Denite -default-action=replace -buffer-name=register register neoyank<CR>
  nnoremap <silent> [Window]<Space> :<C-u>Denite file_rec:~/.config/nvim/rc<CR>
  nnoremap <silent> / :<C-u>Denite -buffer-name=search -auto-highlight line<CR>
  nnoremap <silent> * :<C-u>DeniteCursorWord -buffer-name=search -auto-highlight -mode=normal line<CR>
  nnoremap <silent> [Window]s :<C-u>Denite file_point file_old -sorters=sorter_rank `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
  nnoremap <silent><expr> tt  &filetype == 'help' ?  "g\<C-]>" : ":\<C-u>DeniteCursorWord -buffer-name=tag -immediately  tag:include\<CR>"
  nnoremap <silent><expr> tp  &filetype == 'help' ? ":\<C-u>pop\<CR>" : ":\<C-u>Denite -mode=normal jump\<CR>"
  nnoremap <silent> [Window]n :<C-u>Denite dein<CR>
  nnoremap <silent> [Window]g :<C-u>Denite ghq<CR>
  nnoremap <silent> ;g :<C-u>Denite -buffer-name=search -no-empty -mode=normal grep<CR>
  nnoremap <silent> n :<C-u>Denite -buffer-name=search -resume -mode=normal -refresh<CR>
  nnoremap <silent> ft :<C-u>Denite filetype<CR>
  nnoremap <silent> <C-t> :<C-u>Denite -select=`tabpagenr()-1` -mode=normal deol<CR>
  nnoremap <silent> <C-k> :<C-u>Denite -mode=normal change jump<CR>
  nnoremap <silent> [Space]gs :<C-u>Denite gitstatus<CR>
  nnoremap <silent> ;; :<C-u>Denite command command_history<CR>
  nnoremap <silent> N :<C-u>call deol#new({'command': 'zsh'})<CR>
  nnoremap <silent> [Space]s :<C-u>Deol zsh<CR>
  nnoremap <silent> [Window]D  :<C-u>call deol#kill_editor()<CR>
autocmd dein-events InsertCharPre * call dein#autoload#_on_event("InsertCharPre", ['neosnippet.vim'])
autocmd dein-events TextYankPost * call dein#autoload#_on_event("TextYankPost", ['neoyank.vim'])
autocmd dein-events CompleteDone * call dein#autoload#_on_event("CompleteDone", ['echodoc.vim'])
