""""""""""""""""""""""""""""""""""""""""""""""""""
" ~/.vimrc
" Vim settings
"
" Sections:
"   -> General
"   -> Colors and fonts
"   -> Vim interface
"   -> Text, indenting, pasting
"   -> Search
"   -> Leader shortcuts
"   -> Plugins
"   -> Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't break anything
set nocompatible

" Remember up to 250 lines of history
set history=250

" Filetype plugins
filetype plugin on

" Watch for external changes
set autoread

" Ask about changes instead of throwing an error
set confirm

" Open help files in a vertical split
au BufWinEnter *.txt* if &ft == 'help' | wincmd L | endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and fonts
""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting
syntax enable

" Make popups readable
hi Pmenusel ctermbg=blue

""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim interface
""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on the wild menu
set wildmenu

set wildmode=longest

" Hide abandoned buffers
set hid

" Show current position
set ruler
set number

" Higher command window
set cmdheight=2

" Always display last status
set laststatus=2

" Backspace over autoindent, line breaks, and start of insert action
set backspace=indent,eol,start

" Show matching brackets
set showmatch
set mat=2

" Stop certain movements from returning to line start
set nostartofline

" Press jj to exit insert mode
inoremap jj <Esc>

" Better split panes
set splitbelow
set splitright

" Easier navigation between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, indenting, pasting
""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces over tabs
set expandtab

" Smart tabbing
set smarttab 

" 1 tab = 4 spaces
set shiftwidth=4
set softtabstop=4

set showmode

" Delete trailing white space
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Autocompletion
set omnifunc=syntaxcomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
""""""""""""""""""""""""""""""""""""""""""""""""""
" Press space to clear search highlighting
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" Case insensitive search, except for capital letters
set ignorecase
set smartcase

" Jump to first match
set incsearch

"Always highlight matches
set hlsearch

" Use literal regex
"nnoremap / /\v
"vnoremap / /\v

" Substitute globally by default
set gdefault

""""""""""""""""""""""""""""""""""""""""""""""""""
" => Leader shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the leader key
let mapleader=","
let g:mapleader=","

" Open and jump to new split window
nnoremap <leader>nw :vne<cr><C-l>

" Open vimrc
nnoremap <leader>ev :vsp ~/.vimrc<cr>

" Toggle pasting from outside vim
nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p

" Save and make current project
nnoremap <leader>wm :w<CR>:make<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

" Use Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

if v:version >= 704 || v:version == 703 && has("patch584")
    Plugin 'Valloric/YouCompleteMe' " Program autocompletion (Vim 7.3.584+)
else
    Plugin 'vim-scripts/AutoComplPop'
endif

Plugin 'vim-scripts/taglist.vim' " Show tags in current project 

"Snipmate and dependencies
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'tpope/vim-fugitive' " Git integration
Plugin 'justinmk/vim-sneak' " Easy forward motion

call vundle#end()

""""""""""""""""""""""""""""""
" => Plugin settings
""""""""""""""""""""""""""""""

""""""""""""""""""""
" ShowMarks
""""""""""""""""""""
let g:showmarks_enable=0 " Off by default

""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""
" Set bash filetype if the shebang is present
au Bufread,Bufwrite * if getline("1") == '#!/bin/bash' | set filetype=sh | endif

" Make bash scripts executable by default
au BufWritePost * if &ft == 'sh' | exe '!chmod u+x %' | endif

" Delete trailing white space on save, useful for Python and CoffeeScript
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py,*.coffee :call DeleteTrailingWS()
