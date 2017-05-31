

"normal setting
set encoding=utf8
"set ignorecase
set secure
set backspace=2         " allow backspacing over everything in insert mode
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
" than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

set expandtab           " expand tabs to spaces.
set wildchar=<TAB>      " such as <TAB> in shell
set smarttab
set tabstop=4
set shiftwidth=4

set nu
set t_Co=8              " number of colors
set t_Sf=[1;3%p1%dm   " set foreground color
set t_Sb=[1;4%p1%dm   " set background color
set showcmd             " show command
set showmode            " show current mode
set incsearch           " While typing a search pattern, show immediately
" where the so far typed pattern matches.
set hlsearch            " When there is a previous search pattern,
" highlight all its matches.
syntax on               " show parts of the text in another font or color

set fileencodings=utf-8,cp936,big5,latin1
set background=dark

autocmd FileType make setlocal noexpandtab

setlocal omnifunc=syntaxcomplete#Complete
set cot+=menuone


colorscheme default

highlight Comment    ctermfg=DarkCyan
highlight SpecialKey ctermfg=Yellow

"retain lines above or below cursor
"set scrolloff=7

"Leader setting

let g:intvon = 0
let mapleader = "\<Space>"
set path+=/usr/lib/gcc/x86_64-pc-cygwin/5.4.0/include/c++

"Mapping
imap jk <ESC>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Go to home and end using capitalized directions
noremap H ^
noremap L $

nmap <Leader>x :x<CR>
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>n :n<CR>
nmap <Leader>N :N<CR>
nmap <Leader>jq :q!<CR>
nmap <Leader>/ :noh<CR>
nmap <Leader>; :
set lazyredraw "for gg=G , prevent screen blinking
nmap <Leader>= mcHmhLmlgg=G`h`l`c

nmap <Leader>k <C-W><C-W>
nmap <Leader>vc :source $MYVIMRC<CR>

nmap <Leader>s :VimShellPop<CR>
nmap <Leader>l :call LoadIntv()<CR>
nmap <Leader>i :call TogIntv()<CR><ESC><C-W><C-W>
nmap <Leader>a :!echo --- <C-R><C-w> --- ;abbrev <C-R><C-W><CR>
nmap <Leader>t :!echo --- <C-R><C-w> --- ;ici <C-R><C-W><CR>
nmap <Leader>g :silent !chrome <C-R><C-A> 1>/dev/null 2>/dev/null&<CR>:redraw!<CR>
nmap <Leader>m :call DownAsMKD('<C-R><C-A>')<CR>
nmap <F7> vdiv<ESC>
noremap u :call MyRe()<CR>
map <leader>zz :call ToggleFold()<cr>

function! MyRe()
    let y = line(".")
    let x = col(".")
    u
    call cursor(y, x)
endfunction

function! TogIntv()
    let b:ext = expand('%:e')
    if g:intvon == 0
        let g:intvon = 1
        if &ft == "scheme"
            if b:ext == "ss"
                VimShellInteractive racket3m.exe
            elseif b:ext == "scm"
                VimShellInteractive plt-r5rs.exe
            else
                VimShellInteractive plt-r5rs.exe
                "VimShellInteractive ./biwas
            endif
            set syntax=scheme
        elseif &ft == "python"
            VimShellInteractive python
            set syntax=python
        endif
    elseif g:intvon == 1
        let g:intvon = 2
        wincmd w
        hide
    elseif g:intvon == 2
        let g:intvon = 1
        vert sb 2
    endif
endfunction

function! LoadIntv()
    if g:intvon == 1
        exe "w"
        if &ft == "scheme"
            call vimshell#interactive#send('(load "'.@%.'")')
        elseif &ft == "python"
            call vimshell#interactive#send('execfile("'.@%.'")')
        endif

    endif
endfunction

function! DownAsMKD(url)
    echo 'not ready yet'
endfunction


let g:FoldMethod = 0
fun! ToggleFold()
    if g:FoldMethod == 0
        set foldmethod=syntax
        let g:FoldMethod = 1
    endif

    if g:FoldMethod == 1
        exe "normal! zM"
        let g:FoldMethod = 2
    else
        exe "normal! zR"
        let g:FoldMethod = 1
    endif
endfun

" Is better way to zoom windows in Vim than ZoomWin?
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>zm :ZoomToggle<CR>

" line color
let rngbeg=0
autocmd FileType markdown,text let rngbeg=100
"autocmd FileType c,cc,cpp,java,py,hs let rngbeg=80

"^ single col
autocmd VimEnter * if rngbeg > 0 | let &colorcolumn=join(range(rngbeg,999),",")
"^ pane

" v Magenta
autocmd FileType * highlight colorcolumn term=bold ctermfg=5 ctermbg=0 gui=bold

" other available theme
"term=reverse ctermbg=147 ctermfg=3 guibg=#3a3a3a
"term=reverse ctermbg=4 gui=undercurl guisp=Blu
"term=bold ctermbg=5 guibg=LightMagenta
"term=reverse cterm=reverse guibg=LightGrey
"term=bold cterm=bold ctermbg=147 ctermfg=3 guifg=Blue
"Yellow
"term=bold cterm=bold ctermbg=147 ctermfg=3

set cursorline
hi CursorLine ctermbg=none cterm=underline

set clipboard=unnamed

filetype indent on "for php.vim & html.vim in .vimrc/indent

"have Vim jump to the last position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif