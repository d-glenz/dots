set nocompatible              " be iMproved, required
filetype off                  " required

set exrc
set secure

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" async bash
Plugin 'joonty/vim-do'
" Sensible defaults
Plugin 'tpope/vim-sensible'
" Easy surrounds
Plugin 'tpope/vim-surround'
" Easy commenting
Plugin 'tpope/vim-commentary'
" good repeats
Plugin 'tpope/vim-repeat'
" Syntax checking
Plugin 'scrooloose/syntastic'
" Status bar
Plugin 'bling/vim-airline'
" Colorschemes
Plugin 'flazz/vim-colorschemes'
" wal colorschemes
Plugin 'dylanaraps/wal.vim'
" autocomplete
Plugin 'Valloric/YouCompleteMe'
Plugin 'ervandew/supertab'
" Markdown viewing on ctrl-p
Plugin 'JamshedVesuna/vim-markdown-preview'
" tex stuf
Plugin 'lervag/vimtex'
" coverage
Plugin 'mgedmin/coverage-highlight.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" TODO: Load plugins here (pathogen or vundle)

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on
filetype plugin on

" TODO: Pick a leader key
let mapleader = ","
let maplocalleader='\'

" Security
set modelines=0

" Show line numbers
set number relativenumber

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
" clear search
map <leader><space> :let @/=''<cr>

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

set pastetoggle=<F2>
" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬,trail:~
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
" Toggle tabs and EOL
map <leader>l :set list!<CR>

" Color scheme (terminal)
set t_Co=256
set background=dark
nnoremap <leader>s :source ~/.vimrc<CR>
" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {"mode": "passive"}

let g:jedi#force_py_version = 3
let g:jedi#show_call_signatures= 2
let g:jedi#use_splits_not_buffers = 'left'

let g:SuperTabDefaultCompletionType = "<c-n>"
set completeopt=menuone

" vimtex
let g:vimtex_view_method = "mupdf"


nnoremap <leader>st :SyntasticToggleMode<CR>
" Swap buffers
function! WinBufSwap()
  let thiswin = winnr()
  let thisbuf = bufnr("%")
  let lastwin = winnr("#")
  let lastbuf = winbufnr(lastwin)

  exec  lastwin . " wincmd w" ."|".
      \ "buffer ". thisbuf ."|".
      \ thiswin ." wincmd w" ."|".
      \ "buffer ". lastbuf
endfunction

" show marks in loc list when hit ` or '
" function! Marks(mark)
"     marks
"     echo('Mark: ')

"     " getchar() - prompts user for a single character and returns the chars
"     " ascii representation
"     " nr2char() - converts ASCII `NUMBER TO CHAR'

"     let s:mark = nr2char(getchar())
"     " remove the `press any key prompt'
"     redraw

"     " build a string which uses the `normal' command plus the var holding the
"     " mark - then eval it.
"     execute "normal! " . a:mark . s:mark
" endfunction

" nnoremap ' :call Marks("'")<CR>
" nnoremap ` :call Marks("`")<CR>



command! Wswap :call WinBufSwap()
nnoremap <leader>bs :call WinBufSwap()<CR>
nnoremap ; :
nnoremap <F3> :set spell! spelllang=en_us<CR>
nnoremap <leader>m :make<CR>
autocmd BufWritePre * %s/\s\+$//e
set colorcolumn=79
au BufReadPost *.pyi set syntax=python

" pdf hackery
" au BufReadPost *.tex let &makeprg="latexmk -pdf -outdir=$(dirname %) % && pkill --signal=SIGHUP mupdf"
" au BufReadPost *.tex !pgrep "mupdf" || mupdf %:r.pdf &

" coverage
nnoremap <F7> ::HighlightCoverage<CR>

colorscheme molokai_dark
