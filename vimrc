" comment {{{1
" filename: .vimrc
" author: lukas singer <lukas42singer (at) gmail (dot) com>
" 
" how to install vim plugins:
"   apt-get install clang
"   mkdir ~/.vim/tmp/backup
"   mkdir ~/.vim/tmp/undo
"   mkdir ~/.vim/tmp/swap
"   mkdir ~/.vim/bundle
"   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"   vim
"   :PluginInstall
" done.
"

" debian specific {{{1
runtime! debian.vim

" vundle {{{1

" needed to run vundle (but i want this anyways)
set nocompatible

" vundle needs filtype plugins off
" i turn it on later
filetype plugin indent off
syntax off

" set the runtime path for vundle
set rtp+=~/.vim/bundle/Vundle.vim

" start vundle environment
call vundle#begin()

" list of plugins {{{2
" let Vundle manage Vundle (this is required)
Plugin 'gmarik/Vundle.vim'

" to install a plugin add it here and run :PluginInstall.
" to update the plugins run :PluginInstall! or :PluginUpdate
" to delete a plugin remove it here and run :PluginClean
" 

Plugin 'Rip-Rip/clang_complete'
" press and hold <leader> and type 'cr', 'cc' or 'cw' to open C Reference
Plugin 'vim-scripts/CRefVim'
Plugin 'jondkinney/dragvisuals.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'flazz/vim-colorschemes'

" add plugins before this
call vundle#end()

" filetype syntax {{{1
" now (after vundle finished) it is save to turn filetype plugins on
filetype plugin indent on
syntax on

" plugin settings {{{1
" here are settings for my plugins. 
" see fold area 'vundle' for a list of plugins.

" vim-airline {{{2
" i want to use the airline tabs
let g:airline#extensions#tabline#enabled=1

" clang_complete {{{2
let g:clang_complete_auto=0  " I can start the autocompletion myself, thanks..
" let g:clang_snippets=1     " use a snippet engine for placeholders
" let g:clang_snippets_engine='ultisnips'
" let g:clang_auto_select=2  " automatically select and insert the first match

" vim-session {{{2
" i want to autosave the last session as 'default'
let g:session_autosave = 'yes'
" but i dont want to restore the last session automaticaly
let g:session_autoload = 'no'
" every instance of vim should overwrite the default session when closed.
let g:session_default_overwrite = 1
" i dont need my colorsettings saved to the session.
let g:session_persist_colors = 0

" dragvisuals.vim {{{2
" delete trailing whites if there were added some by dragging by dragvisuals
let g:DVB_TrimWS = 1

" colors {{{1
"enable 256 colors when in gnome-terminal (my debian machine)
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
" try <http://bytefluent.com/vivify/> to test colorschemes
colorscheme slate

" i want to highlight trailing whites
hi TrailingWhitespace ctermbg=darkred
match TrailingWhitespace /\s\+$/

" i want to highlight lines longer than 80 chars in some way
" TODO : i am not happy with the colors and i dont want to match it a linebreak
" (if i am exactly 80 chars long).
hi ColorColumn ctermbg=white ctermfg=black
match ColorColumn '\%81v'

" some settings to highlight the current line and the linenumber
" cterm=none is needed to get rid of the ugly underlining of the current line.
hi CursorLine cterm=none ctermbg=black
hi LineNr ctermbg=black
hi CursorLineNr ctermbg=black

" options {{{1
" spelling {{{2
set spelllang=de,en

" linenumbers & cursorline {{{2
set number
set numberwidth=6
set cursorline

" completion & popups {{{2
set pumheight=25             " so the complete menu doesn't get too big
set completeopt=menu,longest " menu, menuone, longest and preview

" interface {{{2
set ruler
set laststatus=2
" i want to see the command i've executed
set showcmd
set noerrorbells

" search {{{2
set hlsearch
set ignorecase

" tabs, indent & backspace {{{2
" i want to use backspace like in any other editor
set backspace=indent,eol,start
set autoindent
set shiftwidth=2
set softtabstop=2
set expandtab
" fix the c-switch-case{} indendation:
" <http://stackoverflow.com/questions/19990835/issue-with-cindent-indentation-
"      based-on-scope-in-switch-case-statements-in-vim>
set cinoptions=l1

" undo, backup & swap {{{2
" the double slash at the end of the paths makes filenames include the path
" with slashes replaced by percent sign.
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set backupskip=*/tmp/*
set directory=~/.vim/tmp/swap//
set backup

" folding {{{2
set foldmethod=marker
set foldmarker={{{,}}}

" other stuff {{{2
" i want the current dir allways be the directory of the current file
set autochdir
" allow to switch buffers even if the current buffer is not yet written.
set hidden

" autocommands {{{1
" when editing .vimrc it should be reloaded when saved 
" <https://github.com/bling/vim-airline/issues/539>
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC | AirlineRefresh
  autocmd BufWritePost $MYVIMRC AirlineRefresh
augroup END " }
"autocmd bufwritepost .vimrc source %

" mappings {{{1

" set the <leader> to
let mapleader = ","

" use ä to switch to next tab an ö to previos
" char-228 == ä
nnoremap <silent> <CHAR-228> :bn<CR>
" char-246 == ö
nnoremap <silent> <CHAR-246> :bN<CR>

" unhighlight search on enter
nnoremap <silent> <CR> :nohl<CR><CR>

" make the cursor stay where it is when using the * command
nnoremap <silent> * *N

" i want to use <leader>h for lookup the current word in the vim help
"nnoremap <expr> <leader>h (":help " . fnameescape(expand('<cword>')) . "\n")
nnoremap <leader>h :help <C-r><C-w><CR>

" i want to use <leader>m for lookup the current word in man pages (this is the
" default of upper K, but i use upper K to split lines)
nnoremap <leader>m K

" upper J joins 2 lines, so upper K should split them imho.
nnoremap <silent> K i<CR><ESC>k$

" i often want to open my vimrc to look something up or to change something
nnoremap <leader>v :e ~/.vimrc<CR>

" use Ctrl and hjkl to navigate between split screen 'windows'
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" use <space> to toggle fold under cursor
nnoremap <SPACE> za
" use <leader><space> to fold all except the current cursor position
nnoremap <leader><space> zMzvzz

" <C-@> is <C-Space> in terminal mode! (used for autocompletion)
inoremap <C-@> <C-x><C-u>

" let ß (on german keyboard next to zero) jump to last char of line
noremap ß $

noremap <TAB> %

" mappings for dragvisuals plugin
vmap <expr> <C-h> DVB_Drag('left')
vmap <expr> <C-l> DVB_Drag('right')
vmap <expr> <C-j> DVB_Drag('down')
vmap <expr> <C-k> DVB_Drag('up')
vmap <expr> D DVB_Duplicate()

" functions {{{1

" TODO : put functions here, f.e. MyFoldText(), ...
