" =================================================
" VUNDLE
" =================================================
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'ctrlpvim/ctrlp.vim'


call vundle#end()

" =================================================
" END VUNDLE
" =================================================

syntax on
filetype on
filetype indent on
filetype plugin on

let mapleader = " "
set clipboard=unnamed
colorscheme slate
set backspace=2
set autowrite

" no bloody beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Use one space, not two, after punctuation.
set nojoinspaces

" Show line numbers
set nu
set rnu

" macro to add frozen string literal comment to top of ruby files
let @f = 'ggO# frozen_string_literal: true'

" arrows for buffer  nav
nnoremap <right> :bn<cr>
nnoremap <left> :bp<cr>

set history=50  " Number of things to remember in history.
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)

" Backups & Files
set backup                     " Enable creation of backup file.
set backupdir=~/.vim/backups " Where backups will go.
set directory=~/.vim/tmp     " Where temporary files will go.

function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd BufWritePre * :call TrimWhiteSpace()

" ruby path if you are using rbenv
let g:ruby_path = system('echo $HOME/.rbenv/shims')

map <leader>w :w<cr>
map <leader>q :q<cr>
map <leader>d :bd<cr>


" Allow cursor to move anywhere in file
set ve=all

" Enter inserts blank line below cursor
map <Enter> o<ESC>

" " Shift+Enter inserts blank line above cursor
map <S-Enter> O<ESC>

" RSpec.vim mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR>
