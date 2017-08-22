set nocompatible            " be iMproved, required
filetype off                " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Place Plugin commands here
Plugin 'Valloric/YouCompleteMe'
Plugin 'wincent/command-t'
Plugin 'scrooloose/nerdtree'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-airline/vim-airline'
Plugin 'terryma/vim-multiple-cursors'

" All of your Plugins must be added before the following line
call vundle#end()           " required

so ~/.vim/vimrc-basic       " Import all my basic settings

" Telling YCM to use python3
let g:ycm_python_binary_path='/usr/bin/python3'

" Indent Guides
let g:indent_guides_enable_on_vim_startup=1
colorscheme default
let g:indent_guides_auto_colors=0
" hi IndentGuidesOdd  ctermbg=232
hi IndentGuidesEven ctermbg=232

" Air-Line
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Close the current buffer and move to the previous one
nmap <leader>q :bp <BAR> bd #<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Start NERDTree undo startup
" autocmd VimEnter * NERDTree
