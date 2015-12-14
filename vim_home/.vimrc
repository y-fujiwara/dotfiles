filetype plugin indent off
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/AnsiEsc.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'kana/vim-submode'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'junegunn/vim-easy-align'
call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1



" Unite�ݒ�
let g:unite_enable_start_insert=1
noremap <C-P> :Unite buffer<CR>
noremap <C-N> :Unite -buffer-name=file file<CR>
noremap <C-Z> :Unite file_mru<CR>
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" Git�ݒ�
autocmd QuickFixCmdPost *grep* cwindow
set statusline+=%{fugitive#statusline()}

" �^�u���o���ݒ�
let g:indent_guides_enable_on_vim_startup = 1

""""""""""""""""""""""""""""""
" �S�p�X�y�[�X�̕\��
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '�@')
    augroup END
    call ZenkakuSpace()
endif

nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

" Undo�������t�@�C���ɕۑ�����
set undodir=$HOME/.vim/undo
set undofile

""""""""""""""""""""""""""""""
" �}�����[�h���A�X�e�[�^�X���C���̐F���ύX
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
    augroup InsertHook
      autocmd!
      autocmd InsertEnter * call s:StatusLine('Enter')
      autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
    if a:mode == 'Enter'
        silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
        silent exec g:hi_insert
    else
        highlight clear StatusLine
        silent exec s:slhlcmd
    endif
endfunction

function! s:GetHighlight(hi)
    redir => hl
    exec 'highlight '.a:hi
    redir END
    let hl = substitute(hl, '[\r\n]', '', 'g')
    let hl = substitute(hl, 'xxx', '', '')
    return hl
endfunction


""""""""""""""""""""""""""""""
" �����I�ɕ����ʂ�����
""""""""""""""""""""""""""""""
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<Left>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap < <><ESC>i
inoremap <<Enter> <><Left><CR><ESC><S-o>

if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

autocmd VimEnter * execute 'VimFiler -buffer-name=explorer -split -simple -winwidth=30 -toggle -no-quit'

"autocmd TabEnter * execute 'VimFiler -buffer-name=explorer -split -simple -winwidth=30 -toggle -no-quit'

nnoremap <silent><C-e> :VimFiler -buffer-name=explorer -split -simple -winwidth=30 -toggle -no-quit<CR>

" vimfiler -------------------------------
command Vf VimFiler -buffer-name=explorer -split -simple -winwidth=30 -toggle -no-quit
" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

let NERDTreeIgnore = ['\~$','\.pyc$','\*NTUSER*','\*ntuser*','\NTUSER.DAT','\ntuser.ini']


if &compatible
    set nocompatible
endif
filetype plugin indent on
syntax enable
set t_Co=256
set fileformats=unix,dos
set smarttab
set expandtab
set virtualedit=block
set ignorecase
set smartcase
set incsearch
set nohlsearch
set wrapscan
set list
set number
set ambiwidth=double
if has('path_extra')
    set tags& tags+=.tags,tags
endif
set laststatus=2
set showtabline=2
set clipboard=unnamed
set backspace=eol,indent,start
set wildmenu
set wildmode=list:full
set wildignore=*.o,*.obj,*.pyc,*.so,*.dll
let g:python_highlight_all = 1

set backupdir=$HOME/.vimbackup
set ruler
set noswapfile
set cmdheight=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set whichwrap=b,s,h,l,<,>,[,]
set list
set showmatch
set softtabstop=4
set shiftwidth=4
set smartindent
set listchars=tab:>-,trail:.  " �^�u�� >--- ���X�y�� . �ŕ\������

"�S�p�X�y�[�X���n�C���C�g�\��
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

" esc�������̂ő��p�����B
noremap <C-j> <esc>
noremap! <C-j> <esc>

noremap <CR> o<esc>

" ------------------------------------
" colorscheme
" ------------------------------------
syntax on
colorscheme wombat

" wombat Setting
"set guioptions-=T
"set lines=90 columns=200 " �S���ʕ\���N�����������̓R�����g�A�E�g���߂�
"gui
"set transparency=221
"set background=dark
"colorscheme solarized

nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
