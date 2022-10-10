call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-dispatch'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
call plug#end()

syntax on
filetype plugin on
filetype indent on
let mapleader = "\<space>"
set termguicolors
set fileencoding=utf8
set encoding=utf8
set termencoding=utf8
set nocompatible						"Not compatible with VI
set incsearch							"Enable incremental search
set number							    "Show line numbers
set wildmenu							"Display all matching files when we tab complete
set ignorecase							"By default ignore search case
set smartcase							"Do not ignore search case if it contains any Upper case
set mouse=a							    "enable mouse interaction (do not abuse it!)
set nowrap							    "Do NOT wrap text around if it is longer than screen width
set equalalways							"All windows should have the same size
set clipboard=unnamed					"Use the OS clipboard for copying/pasting
set sidescrolloff=5						"begin scrolling n charecters befor right margin
set noswapfile							"Turn off swap file generation
set nobackup							"Turn off backup files
set autoread							"Autoreaload changed files
set autoindent
set smartindent
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
colorscheme thetheme

if has ('gui_running')
  set guioptions-=m  "remove menu bar`
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  set linespace=0
endif

let g:netrw_banner=0

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.exe              " Windows
set wildignore+=*/lib/*,*/build/*

set makeprg=cmake\ --build\ ./build/
nnoremap <F5> :Make<cr> :copen<cr>:wincmd L<cr>
nnoremap <leader>e :Ex<cr>
