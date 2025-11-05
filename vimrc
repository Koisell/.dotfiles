python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set nocompatible " Disable compatiblity with legacy vi"
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256
set cursorline
set cursorcolumn

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden
"set autochdir
set showmatch
set autowrite

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set undofile                      " enable undo files

syntax on
filetype on
filetype plugin indent on
set number relativenumber
set updatetime=100
set mouse=a

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab
set shiftround

let mapleader="\\"
let maplocalleader=","

" Enable Alt in gnome-terminal
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

noremap <C-h> :bN<cr>
noremap <C-j> :buffers<cr>
noremap <C-k> :buffers<cr>
noremap <C-l> :bn<cr>

noremap <A-h> :noh<cr>

" Vimx
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>Y "+Y
noremap <Leader>P "+P

" Search under visual selection
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" Conceal
let g:conceallevel = 1

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'liuchengxu/space-vim-dark'
Plug 'qpkorr/vim-bufkill'
Plug 'terryma/vim-multiple-cursors'
Plug 'wincent/terminus'
Plug 'Townk/vim-autoclose'
Plug 'RRethy/vim-illuminate'
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'sbdchd/vim-shebang', { 'for': ['python', 'ruby', 'sh'] }
Plug 'idris-hackers/idris-vim', { 'for': 'idris' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'LnL7/vim-nix', {'for' : 'nix'}

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !python3 ./install.py --ts-completer --rust-completer
  endif
endfunction
    
# Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
# call plug#end()

" BUNDLE: nerdtree
nmap <leader>d :NERDTreeToggle<cr>
nmap <leader>D :NERDTreeFind<cr>

" BUNDLE: bufkill
noremap <A-w> :BD<cr>

" Colorscheme - BUNDLE: space-vim-dark
colorscheme space-vim-dark
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi Comment guifg=#5C6370 ctermfg=59

" BUNDLE: SHEBANG
let g:shebang#shebangs = {
            \ 'python': '#!/bin/env python3',
            \ 'sh': '#!/bin/env sh',
            \ 'ruby': '#!/bin/env ruby'
            \ }


" BUNDLE: YouCompleteMe
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:AutoClosePreserveDotReg = 0 " fix autoclose bug

" BUNDLE: fzf
set rtp+=~/.fzf

noremap <C-p> :FZF<cr>

" slow multiple_cursors &amp; YCM
function! Multiple_cursors_before()
    let g:ycm_auto_trigger = 0
endfunction
     
function! Multiple_cursors_after()
    let g:ycm_auto_trigger = 1
endfunction
