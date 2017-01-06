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

call dein#add('mhartington/oceanic-next')

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
set noswapfile
" }}}

"<Leader> & <LocalLeader> mapping {{{
let mapleader=','
let maplocalleader= ' '
" }}}


" Automatic reloading of .vimrc
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
nnoremap <Space> za
vnoremap <Space> za
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
