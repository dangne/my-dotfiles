"Colors
syntax enable

"Spaces & Tabs
set tabstop=4
set softtabstop=4
set expandtab
filetype indent on
set cindent
set shiftwidth=4
set autoindent

"UI Config
set number
set showcmd
set lazyredraw
set showmatch
colorscheme default

"Shortcuts
inoremap jk <esc>

"Auto close {
function! s:CloseBracket()
    let line = getline('.')
    if line =~# '^\s*\(struct\|class\|enum\) '
        return "{\<Enter>};\<Esc>O"
    elseif searchpair('(', '', ')', 'bmn', '', line('.'))
        " Probably inside a function call. Close it off.
        return "{\<Enter>});\<Esc>O"
    else
        return "{\<Enter>}\<Esc>O"
    endif
endfunction
inoremap <expr> {<Enter> <SID>CloseBracket()

"Misc
set noundofile
