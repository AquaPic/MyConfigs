"
" Filetype detection
"
augroup filetypedetect

    " Detect .h files as .c files
    au BufNewFile,Bufread *.h setf c

    " Detect .mk as Makefile
    au BufNewFile,BufRead *.mk,Makefile* setf make

augroup END