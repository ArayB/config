set nocompatible

" =================================================
" PLUG
" =================================================

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Automatically deal with swap file warnings
Plug 'gioele/vim-autoswap'

Plug 'mg979/vim-visual-multi'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'janko-m/vim-test'
Plug 'jlanzarotta/bufexplorer'
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdcommenter'
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'

" auto close ({[ etc.
Plug 'Townk/vim-autoclose'
" auto close x/html tags
Plug 'alvan/vim-closetag'

" The Tim Pope collection
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Language/templating/framework plugins
Plug 'elixir-editors/vim-elixir'
Plug 'elmcast/elm-vim'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-rails'

call plug#end()

" =================================================
" END PLUG
" =================================================

syntax on
filetype on
filetype indent on
filetype plugin on
colorscheme slate

let mapleader = " "
set clipboard=unnamedplus
set backspace=2
set autowrite
set splitright
set title titlestring=
set nojoinspaces " Use one space, not two, after punctuation.
set nu
set rnu
" no bloody beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set hidden " keeps buffers in memory when not in view, preserves history, marks etc.
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
setlocal list listchars=tab:»·,trail:·,nbsp:·
set history=50  " Number of things to remember in history.
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
set backup                     " Enable creation of backup file.
set backupdir=~/.dotfiles/vim/backups " Where backups will go.
set directory=~/.dotfiles/vim/tmp     " Where temporary files will go.

" Highlight the 81st column on any line that exceeds 80 columns
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Auto trim whitespace on save
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd BufWritePre * :call TrimWhiteSpace()

" Disable comments automatically continuing on next line if press return
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" ==============================================================
"                    NERDCOMMENTER
" ==============================================================
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting


" ==============================================================
"                    RIPGREP
" ==============================================================
nnoremap K :Rg <C-R><C-W><CR>
nnoremap \ :Rg<SPACE>


" ==============================================================
"                          NETRW
" ==============================================================
" Hide banner, uncomment this once used to commands?
" let g:netrw_banner = 0


" ==============================================================
"                          ALE
" ==============================================================
highlight ALEWarning ctermbg=Black

let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'javascript': ['prettier'],
\   'markdown': ['write-good'],
\   'erb': ['erb']
\}

" phoenix code reloading doesn't work without this
let g:ale_linters = {
\   'elixir': ['mix']
\}

let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file


" ==============================================================
"                          FUGITIVE
" ==============================================================
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
" nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gc :Dispatch git commit<CR>
" nnoremap <space>gt :Gcommit -v -q %:p<CR>
" nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
" nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Dispatch! git push<CR>
nnoremap <space>gpl :Dispatch! git pull<CR>

" ==============================================================
"                          RUBY SPECIFIC SETTINGS
" ==============================================================

" ruby path if you are using rbenv
let g:ruby_path = system('echo $HOME/.rbenv/shims')

" Auto complete Ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

let test#strategy = "neovim"
" let test#ruby#minitest#file_pattern = '_spec\.rb' " the default is '_test\.rb'

let g:rails_projections = {
      \ "app/lib/*.rb": {
      \   "test": [
      \     "test/lib/{}_test.rb",
      \     "spec/lib/{}_spec.rb"
      \   ]
      \ }
      \}

let g:projectionist_heuristics = {
      \ "*": {
      \  "apps/*.rb": {
      \    "alternate": "spec/{}_spec.rb",
      \    "type": "source"
      \  },
      \  "spec/*_spec.rb": {
      \    "alternate": "apps/{}.rb",
      \    "type": "test"
      \  }
      \ }
      \}


" ==============================================================
"                          VIM SNIPPETS SETTINGS
" ==============================================================
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<C-tab>"
let g:UltiSnipsJumpForwardTrigger="<C-n>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips/"
let g:UltiSnipsSnippetDirectories=["~/.vim/UltiSnips/", "UltiSnips"]


" ==============================================================
"                     EMMET SETTINGS
" ==============================================================
let g:user_emmet_leader_key='<c-m>'
let g:user_emmet_install_global = 0
autocmd FileType html,css,scss,eruby EmmetInstall
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
  \      'extends' : 'jsx',
  \  },
  \}

" ==============================================================
"                     JAVASCRIPT SETTINGS
" ==============================================================
autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %


" ==============================================================
"                     EDITORCONFIG SETTINGS
" ==============================================================
let g:EditorConfig_exclude_patterns = ['fugitive://.*']


" ==============================================================
"                     ELM SETTINGS
" ==============================================================
 let g:elm_setup_keybindings = 0


" ==============================================================
"                     GUTENTAGS SETTINGS
" ==============================================================
 let g:gutentags_define_advanced_commands = 1


" =================================================
"                     AIRLINE SETTINGS
" =================================================
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'


" ==============================================================
"                     LEADER/MAPPINGS
" ==============================================================
" Switch between the last two files
nnoremap <leader><leader> <c-^>
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>bd :bd<cr>
nnoremap <leader>b :bu<space>
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>
nnoremap <leader>f :ALEFix<cr>
nnoremap <leader>e :Explore<cr>
nnoremap <leader>t :w<cr>:TestFile<cr>
nnoremap <leader>s :w<cr>:TestNearest<cr>
nnoremap <leader>a :w<cr>:TestSuite<cr>
nnoremap <leader>l :w<cr>:TestLast<cr>
nnoremap <leader>v :w<cr>:TestVisit<cr>
" arrows for buffer  nav
nnoremap <right> :bn<cr>
nnoremap <left> :bp<cr>
nnoremap <C-p> :Files<cr>
nnoremap gd <C-]>
" use : much more than ; so remap to save having to use <shift>; every time I want to run a command
nnoremap ; :
nnoremap : ;

nnoremap <leader>g :e Gemfile<cr>

" Rails leader mappings
nnoremap <leader>rr :e config/routes.rb<cr>


" ==============================================================
"                     MACROS
" ==============================================================
" add frozen string literal comment to top of ruby files
let @f = 'ggO# frozen_string_literal: true'
" add binding.pry on line above
let@p = 'Obinding.pry'
