" not compatible with vi
set nocompatible
" enable mouse interaction
set mouse=a

filetype plugin indent on

" syntax hightlight with 24-bit colors!
syntax on
set termguicolors

set cmdheight=1
set noautochdir

" utf-8 everywhere
scriptencoding utf-8
" allow for cursor beyond last character
set virtualedit=onemore
" store a ton of history
set history=1000
" prevents inserting two spaces after punction on a join (J)
set nojoinspaces
" smart case
set ignorecase smartcase
" highlight search pattern as you type
set hlsearch incsearch
" automatically reload files modified by external program
set autowrite
" display current line-number
set number
" backspace will happily destroy anything in insert mode
set backspace=indent,eol,start
" disable bell sounds on errors
set noerrorbells
" display all matching files when we tab complete
set wildmenu
" do NOT wrap text around if it is longer than screen width
set nowrap
" use the OS clipboard for copying/pasting
set clipboard=unnamed
" begin scrolling n charecters before right margin
set sidescrolloff=5
" turn off swap file generation
set noswapfile
" turn off backup files
set nobackup

set autoindent smartindent
" tabs are always expanded into for 2 spaces by default
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
" no extra pixels between lines
set linespace=0

let mapleader = "\<space>"
colorscheme thetheme 

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

if has ('gui_running')
  " remove menu bar
  set guioptions-=m
  " remove toolbar
  set guioptions-=T
  " remove right-hand scroll bar
  set guioptions-=r
  " remove left-hand scroll bar
  set guioptions-=L
  " set font
  set guifont=Liberation\ Mono:h11
  autocmd GUIEnter * simalt ~x
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-dispatch'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
call plug#end()

" auto resize splits
autocmd VimResized * wincmd =

noremap :W :w
noremap :Wq :wq

let g:netrw_banner=0

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.exe              " Windows
set wildignore+=*/lib/*,*/build/*

:compiler msvc
set makeprg=./build.bat
nnoremap <F5> :Make<cr> :copen<cr>:wincmd L<cr>
nnoremap <leader>e :Ex<cr>

vnoremap < <gv
vnoremap > >gv
nnoremap <C--> o<CR>// -----------------------------------------------------------------------------<esc>
