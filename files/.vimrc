" line numbers
set number

" mouse support in visual and normal mode only
set mouse=vn

" automatic indentation
set autoindent

" tabs as 4 spaces
set shiftwidth=4 " indent width is 4 spaces
set softtabstop=4 " tab indents are same as indent width
set expandtab " tabs as spaces
set smarttab " indent to the next level when at the beginning of a line

" show commands as they're being typed
set showcmd

" use Ctrl + C and Ctrl + V for system clipboard copy/paste, Ctrl + A for select all in visual mode
vnoremap <C-c> "+yi
vnoremap <C-x> "+c
vnoremap <C-v> c<ESC>"+p
inoremap <C-v> <ESC>"+pa
nnoremap <C-a> ggVG