"             __
"     __  __ /\_\    ___ ___   _ __   ___
"    /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\
"  __\ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/
" /\_\\ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
" \/_/ \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/
"
" Author: Fredy Abel Huanca Torres
" Source: https://github.com/abelthf/dotfiles/

" SETUP DEIN ----------------------------------------------------------------{{{
if &compatible
  set nocompatible
endif
" Auto installing Dein {{{
let iCanHazDein=1

if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
  echo "Installing Dein..."
  echo ""
  call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
  call system(expand("git clone https://github.com/Shuogo/dein.vim $HOME/.config/nvim/repos/github.com/Shuogo/dein.vim"))
  let iCanHazDein=0
endif

" Call Dein
if has('vim_starting')
  set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
endif
call dein#begin(expand('~/.config/nvim'))

" is better if Dein rules dein (needed!)
call dein#add('Shougo/dein.vim')
" }}}

" PLUGINS (administrated by Dein) {{{

call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/neomru.vim')
call dein#add('haya14busa/dein-command.vim')

" syntax
call dein#add('vim-airline/vim-airline')
call dein#add('airblade/vim-gitgutter')
call dein#add('ryanoasis/vim-devicons')
" deoplete stuff
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/deol.nvim')
call dein#add('landaire/deoplete-swift', {'on_ft': 'swift'})
call dein#add('keith/swift.vim', {'on_ft': 'swift'})
call dein#add('ternjs/tern_for_vim', {'build': 'npm install'})
call dein#add('carlitux/deoplete-ternjs', {'on_ft': 'javascript'})
call dein#add('artur-shaik/vim-javacomplete2', {'on_ft': 'java'})
call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
call dein#add('Shougo/neoinclude.vim')
call dein#add('ujihisa/neco-look')
call dein#add('davidhalter/jedi-vim', {'on_ft': 'python'})
call dein#add('zchee/deoplete-jedi', {'on_ft': 'python'})
call dein#add('zchee/nvim-go', {'build': 'gb build'})
call dein#add('zchee/deoplete-go', {'build': 'make'})
call dein#add('Konfekt/FastFold')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/echodoc.vim')
call dein#add('honza/vim-snippets')
call dein#add('mhinz/vim-sayonara')
call dein#add('mattn/webapi-vim')
call dein#add('mattn/gist-vim')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('vim-scripts/SyntaxRange')
call dein#add('tyru/open-browser.vim')
call dein#add('junegunn/vim-easy-align')
call dein#add('MartinLafreniere/vim-PairTools')
call dein#add('Shougo/vimfiler.vim')
call dein#add('Shougo/unite.vim')
call dein#add('mhartington/dotfiles')
call dein#add('mhartington/oceanic-next')

call dein#local('~/GitHub', {},['vim-folds'])
call dein#local('~/GitHub', {},['oceanic-next'])
call dein#local('~/GitHub', {},['operator-next'])
call dein#local('~/GitHub', {},['nvim-typescript'])
call dein#local('~/GitHub', {},['vim-angular2-snippets'])
call dein#local('~/GitHub', {},['vim-typings'])


call dein#local('~/GitHub', {},['mdown.vim'])



call dein#add('tpope/vim-fugitive')

" Text edition
call dein#add('tpope/vim-commentary')

" these need to be added last
call dein#add('ryanoasis/vim-devicons')
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
call dein#local('~/GitHub', {} , ['vimfiler-syntax-highlight'])
call dein#add('carlitux/denite-cool-grep')
call dein#add('Yabes/vim-complete-commit-type')

" }}}

" Auto install the Plugin {{{
" First-time plugins installation
if iCanHazDein == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  set nomore
  call dein#install()
endif

" Check if all of the plugins are already installed, in other case it will
" install them (useful to add plugins in the .vimrc)
if dein#check_install()
  call dein#install()
  let pluginsExist=1
endif

call dein#end()
filetype plugin indent on
" }}}
" END DEIN }}}

" VIM SETUP -----------------------------------------------------------------{{{

" System settings {{{
source ~/.local.vim
" Neovim Settings
set termguicolors
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set clipboard+=unnamedplus
" Currently needed for neovim paste issue
set pastetoggle=<f6>
set nopaste
autocmd BufWritePre * %s/\s\+$//e
" Let airline tell me my status
set noshowmode
set noswapfile
filetype on
set  number
set tabstop=2 shiftwidth=2 expandtab
set conceallevel=0
" block select not limited by shortest line
set virtualedit=
set wildmenu
set laststatus=2
"set colorcolumn=100
set wrap linebreak nolist
set wildmode=full
" leader is ,
" let mapleader = ','
set undofile
set undodir="$HOME/.VIM_UNDO_FILES"
" Remember cursor position between vim sessions
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif
            " center buffer around cursor when opening files
autocmd BufRead * normal zz

set updatetime=500
set complete=.,w,b,u,t,k
let g:gitgutter_max_signs = 1000  " default value
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

let g:indentLine_char='│'
let g:table_mode_corner="|"
" let g:dein#install_progress_type = 'updatetime'
" set textwidth=80
set formatoptions+=t
set inccommand=nosplit
set shortmess=I
" }}}

let g:dein#enable_notification = 1
let g:dein#install_progress_type="echo"
let g:dein#install_message_type="none"


" }}}

"<Leader> & <LocalLeader> mapping {{{
let mapleader=','
let maplocalleader=' '
" }}}

" Automatic reloading of .vimrc {{{
autocmd! bufwritepost .vimrc source %
" }}}

" Toggle line numbers {{{

nnoremap <silent><Leader>l :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if !&number && !&relativenumber
      set number
      set norelativenumber
  elseif &number && !&relativenumber
      set nonumber
      set relativenumber
  elseif !&number && &relativenumber
      set number
      set relativenumber
  elseif &number && &relativenumber
      set nonumber
      set norelativenumber
  endif
endfunction

" }}}

" Fold, gets it's own section ----------------------------------------------{{{

function! MyFoldText() " {{{
    let line = getline(v:foldstart)
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines')
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' Lines '
endfunction " }}}

set foldtext=MyFoldText()

autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

autocmd FileType vim setlocal fdc=1
set foldlevel=99
" Space to toggle folds.
" nnoremap <Space> za
" vnoremap <Space> za
set foldmethod=marker
nnoremap \ za
vnoremap \ za

autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0

autocmd FileType html setlocal fdl=99

autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
autocmd FileType css,scss,json setlocal foldmethod=marker
autocmd FileType css,scss,json setlocal foldmarker={,}

autocmd FileType coffee setl foldmethod=indent
autocmd FileType html setl foldmethod=expr
let g:xml_syntax_folding = 1
autocmd FileType xml setl foldmethod=syntax
autocmd FileType html setl foldexpr=HTMLFolds()

autocmd FileType javascript,typescript,json setl foldmethod=syntax
" }}}

" Commentary -------------------------------------------------------------- {{{

nmap <Leader>c <Plug>CommentaryLine
xmap <Leader>c <Plug>Commentary

augroup plugin_commentary
    au!
    au FileType python setlocal commentstring=#%s
    au FileType htmldjango setlocal commentstring={#\ %s\ #}
    au FileType puppet setlocal commentstring=#\ %s
    au FileType xquery setlocal commentstring=(:\ %s\ :)
augroup END

" }}}

" Themes, Commands, etc ----------------------------------------------------{{{
" Theme
syntax on
" set background=dark
colorscheme OceanicNext
" colorscheme OperatorNext
" colorscheme OceanicNextLight
" set background=light
" highlight bad words in red
" autocmd FileType ghmarkdown,markdown,text,html hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224

" }}}

" vim-airline --------------------------------------------------------------{{{
let g:airline#extensions#tabline#enabled = 1
" let g:airline_skip_empty_sections = 1
set hidden
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#buffer_nr_format = '%s '
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#neomake#error_symbol='✖ :'
let g:airline#extensions#neomake#warning_symbol='⚠ :'
let g:airline_theme='oceanicnext'
cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
nmap <leader>t :term<cr>
nmap <leader>, :bnext<CR>
tmap <leader>, <C-\><C-n>:bnext<cr>
nmap <leader>. :bprevious<CR>
tmap <leader>. <C-\><C-n>:bprevious<CR>
tmap <leader>1  <C-\><C-n><Plug>AirlineSelectTab1
tmap <leader>2  <C-\><C-n><Plug>AirlineSelectTab2
tmap <leader>3  <C-\><C-n><Plug>AirlineSelectTab3
tmap <leader>4  <C-\><C-n><Plug>AirlineSelectTab4
tmap <leader>5  <C-\><C-n><Plug>AirlineSelectTab5
tmap <leader>6  <C-\><C-n><Plug>AirlineSelectTab6
tmap <leader>7  <C-\><C-n><Plug>AirlineSelectTab7
tmap <leader>8  <C-\><C-n><Plug>AirlineSelectTab8
tmap <leader>9  <C-\><C-n><Plug>AirlineSelectTab9
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
 " let g:airline_section_z = airline#section#create(['circleci'])
let g:airline#extensions#tabline#buffer_idx_format = {
      \ '0': '0 ',
      \ '1': '1 ',
      \ '2': '2 ',
      \ '3': '3 ',
      \ '4': '4 ',
      \ '5': '5 ',
      \ '6': '6 ',
      \ '7': '7 ',
      \ '8': '8 ',
      \ '9': '9 '
      \}
" }}}

" Deoplete ------------------------------------------------------------------{{{

" enable deoplete
let g:deoplete#enable_at_startup = 1
let g:echodoc_enable_at_startup = 1
set splitbelow
set completeopt+=noselect
autocmd FileType vmailMessageList let b:deoplete_disable_auto_complete=1

function! Multiple_cursors_before()
  let b:deoplete_disable_auto_complete=2
endfunction
function! Multiple_cursors_after()
  let b:deoplete_disable_auto_complete=0
endfunction

call deoplete#custom#set('buffer', 'mark', 'buffer')
call deoplete#custom#set('ternjs', 'mark', '')
call deoplete#custom#set('typescript', 'mark', '')
call deoplete#custom#set('omni', 'mark', 'omni')
call deoplete#custom#set('file', 'mark', 'file')
" let g:deoplete#omni_patterns = {}
" let g:deoplete#omni_patterns.html = ''
function! Preview_func()
  if &pvw
    setlocal nonumber norelativenumber
  endif
endfunction
autocmd WinEnter * call Preview_func()

" }}}
"
" Denite --------------------------------------------------------------------{{{
"
let s:menus = {} " Useful when building interfaces at appropriate places
call denite#custom#option('default', 'prompt', '❯')
call denite#custom#source(
      \ 'file_rec', 'vars', {
      \   'command': [
      \      'ag', '--follow','--nogroup','--hidden', '-g', '', '--ignore', '.git', '--ignore', '*.png'
      \   ] })
call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])

nnoremap <silent> <c-p> :Denite file_rec<CR>
hi deniteMatched guibg=None
hi deniteMatchedChar guibg=None

nnoremap <silent> <leader>h :Denite  help<CR>
nnoremap <silent> <leader>c :Denite colorscheme<CR>
nnoremap <silent> <leader>u :call dein#update()<CR>
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

call denite#custom#var('menu', 'menus', s:menus)
nnoremap <silent> <Leader>i :Denite -auto-resize menu:ionic <CR>
"}}}

