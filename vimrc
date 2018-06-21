"=========================================================================
" DesCRiption: VIM Configuration for Linux/Windows, GUI/Console
"
" Last Change: 07/09/2013 
"
" By: Yong Li @ Oracle
"
"=========================================================================
set runtimepath^=/home/yyoli/.vim/share
set shell=/bin/tcsh\ -f  " avoid loading init files

set guifont=Monospace\ 6
set nocompatible            " not vi compatible
syntax on                   " sytax highlight
filetype on
colorscheme darkblue        " color scheme: default, darkblue, etc.
set number                  " display line number
set cursorline              " highlight cursor line
set ruler                   " open status ruler
set shiftwidth=2            " set >> and << shifting length 
set softtabstop=4           " backspace could delete 4 spaces
set tabstop=2               " tab width
set nobackup                " no backups
set autochdir               " automatically set pwd to curr file dir 
filetype plugin indent on   " open plugin
set backupcopy=yes          " backup overwrite
set ignorecase smartcase    " igonore lower/upper case for search, but sensitive when there is upper case in pattern
set nowrapscan              " no wrap up for search
set incsearch               " show searcch resule immediately
set hlsearch                " highlight search
set noerrorbells            " .
set novisualbell            " .
set t_vb=                   " .
set showmatch               " bracket match
set matchtime=5             " bracket switching time
set magic                   " magic for regex
set hidden                  " allow switch to buffer when file not saved
set guioptions-=T           " hide tool bar
set guioptions-=m           " hide menu
set smartindent             " auto indent on new line
set backspace=indent,eol,start
                            " no delete not in insert mode
set cmdheight=1             " cmd line height
set laststatus=2            " show status
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 
                            " status line setup
set foldenable              " .
set foldmethod=marker       " .
set foldcolumn=0            " .
setlocal foldlevel=1        " . 

" return OS type, eg: windows, or linux, mac, et.st..
function! MySys()
    if has("win16") || has("win32") || has("win64") || has("win95")
        return "windows"
    elseif has("unix")
        return "linux"
    endif
endfunction
	
if MySys() == "windows"
    let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
    let $VIMFILES = $HOME.'/.vim'
endif

let helptags=$VIMFILES.'/doc'

" font and chinese support
if has("win32")
    set guifont=Inconsolata:h12:cANSI
endif



if has("multi_byte")
    " UTF-8 encoding
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=utf-8,gbk

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" Buffers
nnoremap <C-RETURN> :bnext<CR>
nnoremap <C-S-RETURN> :bprevious<CR>

" Tab
nnoremap <C-TAB> :tabnext<CR>
nnoremap <C-S-TAB> :tabprev<CR>

" map tn :tabnext<cr>
" map tp :tabprevious<cr>
" map td :tabnew .<cr>
" map te :tabedit
" map tc :tabclose<cr>

"in split mode, remap key to be simple
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" set file type
nnoremap <leader>1 :set filetype=verilog<CR>
nnoremap <leader>2 :set filetype=systemverilog<CR>
"nnoremap <leader>1 :set filetype=xhtml<CR>
"nnoremap <leader>2 :set filetype=css<CR>
"nnoremap <leader>3 :set filetype=javascript<CR>
"nnoremap <leader>4 :set filetype=php<CR>

" set fileformats=unix,dos,mac
" nmap <leader>fd :se fileformat=dos<CR>
" nmap <leader>fu :se fileformat=unix<CR>

" use Ctrl+[l|n|p|cc] to list|next|previous|jump to count the result
" map <C-x>l <ESC>:cl<CR>
" map <C-x>n <ESC>:cn<CR>
" map <C-x>p <ESC>:cp<CR>
" map <C-x>c <ESC>:cc<CR>


let html_use_css=1

"python
autocmd FileType python set tabstop=2 shiftwidth=2 expandtab
autocmd FileType python map <F12> :!python %<CR>

" ctrl + c = copy when selected
vmap <C-c> "+y

" javascript fold
let b:javascript_fold=1
" javascript support dom、html and css
let javascript_enable_domhtmlcss=1
autocmd filetype javascript set dictionary=$VIMFILES/dict/javascript.dict
autocmd filetype css set dictionary=$VIMFILES/dict/css.dict
autocmd filetype php set dictionary=$VIMFILES/dict/php.dict

"-----------------------------------------------------------------
" plugin - taglist.vim
"-----------------------------------------------------------------
if MySys() == "windows"                
    let Tlist_Ctags_Cmd = '"'.$VIMRUNTIME.'/ctags.exe"'
elseif MySys() == "linux"              
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
nnoremap <silent><F4> :TlistToggle<CR>
let Tlist_Show_One_File = 1    
let Tlist_Exit_OnlyWindow = 1           
let Tlist_Use_Right_Window = 1         
let Tlist_File_Fold_Auto_Close=1       
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1


map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>

let NERDSpaceDelims=1  
let NERDCompactSexyComs=1   


"-----------------------------------------------------------------
" plugin - DoxygenToolkit.vim
"-----------------------------------------------------------------
let g:DoxygenToolkit_authorName="Asins - asinsimple AT gmail DOT com"
let g:DoxygenToolkit_briefTag_funcName="yes"
map <leader>da :DoxAuthor<CR>
map <leader>df :Dox<CR>
map <leader>db :DoxBlock<CR>
map <leader>dc a /*  */<LEFT><LEFT><LEFT>

let g:checksyntax_auto = 0 


"-----------------------------------------------------------------
" plugin - NeoComplCache.vim
"-----------------------------------------------------------------
let g:AutoComplPop_NotEnableAtStartup = 1
let g:NeoComplCache_EnableAtStartup = 1
let g:NeoComplCache_SmartCase = 1
let g:NeoComplCache_TagsAutoUpdate = 1
let g:NeoComplCache_EnableInfo = 1
let g:NeoComplCache_EnableCamelCaseCompletion = 1
let g:NeoComplCache_MinSyntaxLength = 3
let g:NeoComplCache_EnableSkipCompletion = 1
let g:NeoComplCache_SkipInputTime = '0.5'
let g:NeoComplCache_SnippetsDir = $VIMFILES.'/snippets'
" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" snippets expand key
imap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)


"
"syntax file for highlighting
"so $VIMRUNTIME/syntax/verilog.vim
"au Syntax sv runtime! syntax/verilog.vim
"filetype on
au BufNewFile,BufRead *.sv set filetype=systemverilog
au BufNewFile,BufRead *.svh set filetype=systemverilog
au BufNewFile,BufRead *.sv.pal set filetype=systemverilog
au BufNewFile,BufRead *.svh.pal set filetype=systemverilog
au BufNewFile,BufRead *.log set filetype=systemverilog

map bl  :call BufferList()
map bn  :bnext!
map bp  :bprev!
map bd  :bdelete

set expandtab            " expand tabs into spaces
set tabstop=2            " use 2 space tabs
set softtabstop=2        " makes 2 spaces feel like tabs

"
" CDMSPP
"
cnoreab mfw !chmod +w % <CR>:e!<CR>
cnoreab edd !edit_data -nolock % <CR>:e!<CR>
cnoreab sdd !save_data % <CR>:e!<CR>
cnoreab gdd !get_data % <CR>:e!<CR>
cnoreab udd !unedit_data % <CR>:e!<CR>
cnoreab dd !diff_data -gui % &<CR>
" Substitute :/ in filename with $CDMSPP_LOCALDIR
autocmd BufNewFile,BufReadPre :/*
    \ exe 'file ' . substitute(expand('%'), '^:', '$CDMSPP_LOCALDIR', '') | edit


