"Vundle plugin manager
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'

    Plugin 'tpope/vim-fugitive'
    Plugin 'preservim/nerdtree'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'Vimjas/vim-python-pep8-indent'
    Plugin 'dense-analysis/ale'
    Plugin 'fisadev/vim-isort'
    Plugin 'preservim/tagbar'

    " tpope/vim-surround
    " Surround.vim is all about "surroundings": parentheses,
    " brackets, quotes, XML tags, and more. The plugin provides mappings to
    " easily delete, change and add such surroundings in pairs.
    "
    " Usage:
    " - delete surrounding: ds<surrounding>
    " - change surrounding: cs<surrounding><new_surrounding>
    " - add surrounding to an object: ys<object><surrounding>
    Plugin 'tpope/vim-surround'

    " tpope/vim-commentary
    " Comment stuff out
    "
    " Usage:
    " cml
    Plugin 'tpope/vim-commentary'
    Plugin 'vim-scripts/ReplaceWithRegister'
    Plugin 'christoomey/vim-sort-motion'
    Plugin 'christoomey/vim-system-copy'


    Plugin 'kana/vim-textobj-user'
    Plugin 'kana/vim-textobj-indent'
    Plugin 'kana/vim-textobj-entire'
    Plugin 'kana/vim-textobj-line'

    Plugin 'ntpeters/vim-better-whitespace'

call vundle#end()
filetype plugin indent on

let g:airline_powerline_fonts = 1

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let python_highlight_all = 1
let g:ale_linters = {'python': ['isort', 'black', 'remove_trailing_lines', 'trim_whitespace', 'pylint']}
let g:ale_fix_on_save = 1

let g:vim_isort_map = '<C-i>'

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nmap <F8> :TagbarToggle<CR>


"Colors
syntax enable


"Spaces & Tabs
set tabstop=4
set softtabstop=4
set expandtab
set cindent
set shiftwidth=4
set autoindent


"GUI config
set showcmd
set lazyredraw
set showmatch
set background=dark


"Shortcuts
inoremap jk <esc>
inoremap JK <esc>


"Misc
set number
set relativenumber
set noundofile
set mouse=a

set wildmenu
set incsearch
set noswapfile
set ruler


"Auto close brackets
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


"Auto close brackets
nnoremap <C-w>1 1gt
nnoremap <C-w>2 2gt
nnoremap <C-w>3 3gt
nnoremap <C-w>4 4gt
nnoremap <C-w>5 5gt
nnoremap <C-w>6 6gt
nnoremap <C-w>9 :tablast<cr>

nnoremap <leader>w1 1gt
nnoremap <leader>w2 2gt
nnoremap <leader>w3 3gt
nnoremap <leader>w4 4gt
nnoremap <leader>w5 5gt
nnoremap <leader>w6 6gt
nnoremap <leader>w9 :tablast<cr>
