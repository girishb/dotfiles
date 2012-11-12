" Get pathogen up and running {{{

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" }}}
" Basic settings {{{

set nocompatible     " Can't compromise on functionality
set showmode         " Show current mode
set showcmd          " Show current command in lower right corner
set visualbell       " I really hate beeps
set history=500      " Remember these many command lines
set ruler            " show the cursor position all the time
set number           " line numbers
set nowrap           " Don't wrap by default
set linebreak        " During wrapping don't break wrap in middle of words
set showbreak=>      " Show > for wrapped lines
set autoread         " Automatically read file that has changed on disk
set cursorline       " Highlight current line
set shellslash       " I don't like backslashes
set autoindent       " Keep indent of previous line
set hidden           " Allow switching buffers even when buffers have unsaved changes
set encoding=utf-8   " unicode
set showmatch        " Show matching bracket
set matchpairs+=<:>  " add pair < > for use with %, 'showmatch'

" Allow positioning cursor over non existent character in visual block mode
set virtualedit+=block

" Make the 'cw' and similar commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions+=$
" Leader {{{

let mapleader=","
let maplocalleader = "\\"

" }}}
" Basic Filetype settings {{{

filetype on
filetype plugin on
filetype indent on
syntax on

" }}}
" Movement related settings {{{

" Allow backspace over autoindent, line breaks, start of insert
set backspace=indent,eol,start

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=5

" Allow <backspace>, <space>, h and l to go past beginning and end of line
set whichwrap+=b,s,h,l

" }}}
" Copy/paste settings {{{

" Add unnamed register to clipboard. Allows easier copy and paste from system
" clipboard
set clipboard+=unnamed

" Quickly toggle paste mode
set pastetoggle=<F2>

" }}}
" Completion related settings {{{

" Make command line completion better
set wildmenu
set wildmode=full

" Look in current buffer, open windows and other buffers when completing using C-N/P
set complete=.,w,b

" Show preview in omni completion
set completeopt=menu,longest,preview

" }}}
" Backup and undo related settings {{{

set nobackup        " Don't keep a backup file
set noswapfile      " Don't keep a swapfile
if exists("+undofile")
    set undofile    " Enable persistent undo
    if has("unix")
        set undodir=~/tmp
    else
        set undodir=c:/vim_temp
    endif
    set undolevels=1000  " number of undos
    set undoreload=10000 " number of lines to save for undo
endif

" }}}
" Viminfo related settings {{{

" Path of viminfo on windows is typically HOME folder which are mostly network drives. These are
" slow and cause issues when connected in offline mode
if has("win32") || has("win64")
    set viminfo+=nc:/vim_temp/_viminfo
endif

" }}}

" }}}
" Status line {{{

set laststatus=2   " show status line
" Disabled as I've switched to powerline for statusline
" set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]

" }}}
" Search related settings and mappings {{{

set wrapscan      " let search wrap around
set incsearch     " do incremental searching
set ignorecase    " ignore case
set smartcase     " but don't ignore it, when search string contains uppercase letters
set hlsearch      " highlight searches

" To quickly turn off highlighted searches
nnoremap <silent> <leader>n :nohl<CR>

" Keep search pattern at center of screen {{{

nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" }}}

" }}}
" Tabs and Whitespace related settings {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set listchars=tab:>\ ,eol:¬
" Toggle showing invisible characters
nnoremap <silent> <leader>i :set list!<CR>

" }}}
" Mappings to make MY LIFE EASY {{{

" For multikey command, timeout in milliseconds for which vim will
" wait between two key press.
set timeoutlen=500

" Life saver
inoremap jj <ESC>

" To quickly start editing at start and end of line
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A

" allow command line editing like emacs
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>

" I never use default behavior so map to quickly jump to first and last
" character on line
noremap H ^
noremap L $

" Toggle paste mode
nnoremap <silent> <leader>p :set invpaste<CR>:set paste?<CR>

" Toggle text wrapping
nnoremap <silent> <leader>ww :set invwrap<CR>:set wrap?<CR>

" Show all available VIM servers
nnoremap <silent> <leader>ss :echo serverlist()<CR>

" change to directory containing the file in the buffer
nnoremap <silent> <leader>cd :lcd %:h<CR>

" Underline the current line with '=' and '-'
nnoremap <silent> <leader>u= yyp^v$r=:set nohls<CR>
nnoremap <silent> <leader>u- yyp^v$r-:set nohls<CR>

" Quick access to VIMRC file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>:echo "VIMRC Reloaded!"<CR>

" I don't like man page with K
nnoremap K <NOP>

" Sane navigation over wrapped lines
nnoremap j gj
nnoremap k gk
" To get default behavior of j and k to move over physical lines
nnoremap gj j
nnoremap gk k

" I don't like <F1> for help, I can type :h
nnoremap <F1> <NOP>
inoremap <F1> <NOP>
vnoremap <F1> <NOP>

" make Y behave like other capitals
nnoremap Y y$

" Quick navigation over quickfix
nnoremap <silent> <C-p> :cprevious<CR>
nnoremap <silent> <C-n> :cnext<CR>

" Quick navigation over tags
nnoremap <silent> <C-j> :tprevious<CR>
nnoremap <silent> <C-k> :tnext<CR>

" Clean trailing whitespace
nnoremap <silent> <leader>w :%s/\s\+$//<CR>:let @/=''<CR>

" To save Millions of Shift press to enter command mode and to avoid common
" typos in command mode with first letter being in CAPS
nnoremap ; :

" To quickly toggle scrolloff high value vs original value to travel without motion
nnoremap <silent> <leader>zz :let &scrolloff=999-&scrolloff<CR>:set scrolloff?<CR>

" Split line (companion to Join(J) lines). Anyway I don't use substitute mode
nnoremap S i<CR><ESC>

" use gI to move to place of last edit
nnoremap gI `.

" Toggle spell
nnoremap <silent> <leader>sp :set spell!<CR>:set spell?<CR>

" Source current line or visual selection
vnoremap <leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
nnoremap <leader>S ^v$y:execute @@<CR>:echo 'Sourced line.'<CR>

" Reselect visual block after indent
vnoremap > >gv
vnoremap < <gv

" Easier insert mode completion {{{

inoremap <c-l> <c-x><c-l>
inoremap <c-f> <c-x><c-f>
inoremap <c-space> <c-x><c-o>
inoremap <c-]> <c-x><c-]>

" }}}
" Drag lines with <m-j> and <m-k> {{{

nnoremap <m-j> :m+<CR>
nnoremap <m-k> :m-2<CR>
vnoremap <m-j> :m'>+<CR>gv
vnoremap <m-k> :m-2<CR>gv
inoremap <m-j> <ESC>:m+<CR>
inoremap <m-k> <ESC>:m-2<CR>

" }}}
" Quick way for multiple search patterns {{{

nnoremap <silent> <leader>h1 :execute 'match Search /\<<C-R><C-W>\>/'<CR>
nnoremap <silent> <leader>hh1 :execute 'match none'<CR>
nnoremap <silent> <leader>h2 :execute '2match Search /\<<C-R><C-W>\>/'<CR>
nnoremap <silent> <leader>hh2 :execute '2match none'<CR>
nnoremap <silent> <space> :call clearmatches()<CR>

" }}}
" Disable arrow keys {{{

nnoremap <UP>    <NOP>
nnoremap <DOWN>  <NOP>
nnoremap <LEFT>  <NOP>
nnoremap <RIGHT> <NOP>
inoremap <UP>    <NOP>
inoremap <DOWN>  <NOP>
inoremap <LEFT>  <NOP>
inoremap <RIGHT> <NOP>

" }}}

" }}}
" Buffer, Windows related settings and mappings {{{

" Mappings to make buffers handling easier {{{

noremap <silent> <leader>bd :bd<CR>
noremap <silent> <leader>bw :bw<CR>
noremap <silent> <c-l> :bn<CR>
noremap <silent> <c-h> :bp<CR>
nnoremap <leader>a <C-^> " Quickly switch to alternate buffer

" }}}

set splitbelow  " open new window below current window
set splitright  " open new window right of current window

" Maps to make handling windows a bit easier {{{

nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>k :wincmd k<CR>
nnoremap <silent> <leader>l :wincmd l<CR>
nnoremap <silent> <leader>cc :close<CR>
noremap  <silent> <leader>cw :cclose<CR>
nnoremap <silent> <leader>cj :wincmd j<CR>:close<CR>
nnoremap <silent> <leader>ck :wincmd k<CR>:close<CR>
nnoremap <silent> <leader>ch :wincmd h<CR>:close<CR>
nnoremap <silent> <leader>cl :wincmd l<CR>:close<CR>

" }}}

" Mappings for window resizing {{{

nnoremap <c-left> 5<c-w>>
nnoremap <c-right> 5<c-w><
nnoremap <c-up> 5<c-w>+
nnoremap <c-down> 5<c-w>-

" }}}

" }}}
" MS-Windows specific settings {{{

if has("win32") || has("win64")
    set shell=c:\cygwin\bin\bash.exe
    set shellcmdflag=--login\ -c
    set shellxquote=\"
    " Let commands like make to dump output to terminal
    set shellpipe=2>&1\|\ tee
endif

" }}}
" GUI settings {{{

if has("gui_running")
    if has("unix")
        set guifont=Courier\ 10\ Pitch\ 12
    else
        set guifont=Droid\ Sans\ Mono\ Dotted\ for\ Powe:h12,Courier\ New:h12
        " allow alt keys to be used for menu and also allow alt keys which are not
        " used for menu to be usable for normal mapping
        set winaltkeys=menu
    endif
    colorscheme hybrid
    set guioptions-=T
    set guioptions-=r
endif

" }}}
" Autocommands {{{

" Close preview window after leaving insert mode
augroup ClosePreviewWindow
    au!
    " silent is used to avoid error while leaving insert mode in command line window
    au InsertLeave * silent! wincmd z
augroup END

if has("win32") || has("win64")
    augroup OpenMaximized
        au!
        au GUIEnter * simalt ~x
    augroup END
endif

augroup ft_make
    au!
    au FileType make setlocal noexpandtab
augroup END

augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END

augroup ft_text
    au!
    au BufEnter *.txt setlocal textwidth=100
    " Understand underlined text while formatting(treat Underline as comment)
    au BufEnter *.txt setlocal comments+=n:--,n:==
    " Understand bulleted text while formatting
    au BufEnter *.txt setlocal comments+=fb:*,fb:-
augroup END

augroup ft_dita
    au!
    au FileType xml setlocal textwidth=100
    au FileType xml setlocal spell
    au FileType xml setlocal list
augroup END

augroup ft_markdown
    au!
    au BufEnter *.md setlocal filetype=markdown
augroup END


" don't know which plugin changes this setting automatically sometimes. So for
" now set this explicitly.
augroup formatOptions
    au!
    au BufEnter * set formatoptions+=cnrl
augroup END

" }}}
" Typos {{{

command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" }}}
" Folding {{{

" Space to toggle folds.
nnoremap <leader><Space> za
vnoremap <leader><Space> za

" }}}
" Toggle between absolute and relative numbers {{{

function! ToggleNumber()
    if &relativenumber
        set number
    else
        set relativenumber
    endif
endfunction

nnoremap <silent> <leader>N :call ToggleNumber()<CR>

" }}}
" Quickfix Toggle {{{

command! -bang -nargs=? QFixToggle call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen
        let g:qfix_win = bufnr("$")
    endif
endfunction

nnoremap <silent> <leader>q :QFixToggle<CR>

" }}}
" Set tabstop, softtabstop and shiftwidth to the same value {{{

command! -nargs=* Stab call Stab()
function! Stab()
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
endfunction

function! SummarizeTabs()
    try
        echohl ModeMsg
        echon 'tabstop='.&l:ts
        echon ' shiftwidth='.&l:sw
        echon ' softtabstop='.&l:sts
        if &l:et
            echon ' expandtab'
        else
            echon ' noexpandtab'
        endif
    finally
        echohl None
    endtry
endfunction

" }}}
" Vimgrep stuff {{{

if executable('ack')
    set grepprg=ack\ -aiH
elseif executable('grep')
    set grepprg=grep\ -aiH\ -R
else
    set grepprg=internal
endif

" Search the current buffer for pattern {{{

function! GrepOverBuffer()
    let l:pattern = substitute(input("Grep File: /", expand('<cword>')), '"', '\"', '')
    " Use grep! to ensure we don't jump to first result by default.
    execute 'silent! grep! '. l:pattern . ' '. shellescape(expand('%:p'))
    let l:len = len(getqflist())
    if l:len > 0
        copen
        redraw
        echo l:len l:len == 1 ? "match" : "matches" "found"
    else
        echo "Pattern not found in current file: ".l:pattern
    endif
endfunction

nnoremap <silent> <leader>gb :call GrepOverBuffer()<CR>

" }}}

" Search all opened buffers for pattern {{{

function! GrepOverOpenBuffers()
    let l:pattern = substitute(input("Grep Opened Files: /", expand('<cword>')), '"', '\"', '')
    " clear quickfix list
    silent cex[]
    " Use grep! to ensure we don't jump to first result by default.
    execute 'silent! bufdo grepadd! '. l:pattern . ' %:p'
    let l:len = len(getqflist())
    if l:len > 0
        copen
        redraw
        echo l:len l:len == 1 ? "match" : "matches" "found"
    else
        echo "Pattern not found in opened files: ".l:pattern
    endif
endfunction

nnoremap <silent> <leader>go :call GrepOverOpenBuffers()<CR>

" }}}

" Search all folders in path for pattern {{{

function! GrepOverPath()
    let l:pattern = substitute(input("Grep Files in Path: /", expand('<cword>')), '"', '\"', '')
    let l:list = split(&path, ',')
    " clear quickfix list
    silent cex[]
    for l in l:list
        " Use grep! to ensure we don't jump to first result by default.
        execute 'silent! grepadd! '. l:pattern . ' '. l
    endfor
    let l:len = len(getqflist())
    if l:len > 0
        copen
        redraw
        echo l:len l:len == 1 ? "match" : "matches" "found"
    else
        echo "Pattern not found in files in path: ".l:pattern
    endif
endfunction

nnoremap <silent> <leader>gp :call GrepOverPath()<CR>

" }}}

" }}}
" Ctags and cscope {{{

" Directory where tags & cscope database file will be generated. " {{{

if has("win32") || has("win64")
    let g:tagsDir = 'c:/src/sw/compiler/gpgpu'
else
    let g:tagsDir = '~'
endif

" }}}
function! CtagsOverPath() " {{{

    let l:path = &path
    " replace ** in path with blanks as ctags allow -R for recursive
    " directory traversals.
    let l:path = substitute(l:path, '**', '', 'g')
    " Replace delimiter ',' in path by ' '
    let l:path = substitute(l:path, ',', ' ', 'g')

    " Generate ctags in required dir and switch back to current directory
    let l:curdir = getcwd()
    execute 'silent cd ' . g:tagsDir
    execute 'silent !ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q ' . l:path
    execute 'silent cd ' . l:curdir
    execute 'silent set tags=' . g:tagsDir . '/tags'
endfunction

command! GenerateCtags call CtagsOverPath()
nnoremap <silent> <F9> :GenerateCtags<CR>

" }}}
function! CscopeOverPath() " {{{

    let l:path = &path
    " replace ** in path with blanks
    " directory traversals.
    let l:path = substitute(l:path, '**', '', 'g')
    " Replace delimiter ',' in path by ' '
    let l:path = substitute(l:path, ',', ' ', 'g')

    " Generate cscope in required dir and switch back to current directory
    let l:curdir = getcwd()
    execute 'silent cd ' . g:tagsDir
    " Kill cscope connection
    execute 'silent cscope kill ' . g:tagsDir
    " find all .c, .h files in path and add them in cscope.files
    execute 'silent !find ' . l:path '-name "*.[ch]" > cscope.files'
    " find all .cpp files in path and add them in cscope.files
    execute 'silent !find ' . l:path '-name "*.cpp" >> cscope.files'
    " Generate cscope database for files listed in cscope.files
    execute 'silent !cscope -b -q -k'
    execute 'silent cd ' . l:curdir
    execute 'silent cscope add ' . g:tagsDir . '/cscope.out'
endfunction

command! GenerateCscopeDB call CscopeOverPath()
nnoremap <silent> <F8> :GenerateCscopeDB<CR>

" }}}
" Ctags and cscope results in quickfix {{{

" Use quickfix for cscope search results
set cscopequickfix=s-,c-,d-,i-,t-,e-

function! TagInQuickfix() " {{{

    let l:pattern = substitute(input("Tag: ", expand('<cword>')), '"', '\"', '')
    " Use ltag to generate tag search results in location list
    execute 'silent ltag ' . l:pattern
    " create quickfix list out of location list
    call setqflist(getloclist(0))

    let l:len = len(getqflist())
    if l:len > 0
        copen
        redraw
        echo l:len l:len == 1 ? "match" : "matches" "found"
    else
        echo "Pattern not found in opened files: ".l:pattern
    endif
endfunction

" }}}
nnoremap <silent> q :call TagInQuickfix()<CR>

" }}}

" }}}
" Indent Guides {{{

let g:indentguides_state = 0
function! IndentGuides() " {{{

    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction " }}}
hi def IndentGuides guibg=#303030
nnoremap <silent> <leader>I :call IndentGuides()<CR>

" }}}
" Show Highlighting Group {{{

function! ShowHighlight()
    if !exists("*synstack")
        return
    else
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <silent> <F6> :call ShowHighlight()<CR>

"}}}
" Plugin settings {{{

" NERDTree setting {{{

nnoremap <silent> <F3> :NERDTreeToggle<CR>
inoremap <silent> <F3> <ESC>:NERDTreeToggle<CR>

" }}}
" MiniBufExplorer {{{

let g:miniBufExplSplitBelow=0  " Put new window above
let g:miniBufExplorerMoreThanOne=1
let g:miniBufExplCheckDupeBufs = 0 " avoid checking for duplicate buffer name. This is horribly slow.

" }}}
" showmarks {{{

" disable showmarks by default
let g:showmarks_enable=0

" }}}
" Crefvim and stlrefvim {{{

map <silent> <leader>hcr <Plug>CRV_CRefVimNormal
map <silent> <leader>hcw <Plug>CRV_CRefVimAsk
map <silent> <leader>hcc <Plug>CRV_CRefVimInvoke
map <silent> <leader>hsr <Plug>StlRefVimNormal
map <silent> <leader>hsw <Plug>StlRefVimAsk
map <silent> <leader>hsc <Plug>StlRefVimInvoke
map <silent> <leader>hse <Plug>StlRefVimExample

" }}}
" Gundo settings {{{

nnoremap <silent> <F5> :GundoToggle<CR>

" }}}
" Tagbar {{{

nnoremap <silent> <F4> :TagbarToggle<CR>

" }}}
" Omnicppcomplete {{{

let OmniCpp_NamespaceSearch     = 1
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_ShowAccess          = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot      = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow    = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope    = 1 " autocomplete after ::

" }}}
" CtrlP {{{

nnoremap <leader>fb :CtrlPBuffer<CR>
nnoremap <leader>ff :CtrlPCurFile<CR>
nnoremap <leader>fF :CtrlPCurWD<CR>
nnoremap <leader>fm :CtrlPMRUFiles<CR>
nnoremap <leader>fd :CtrlPBookmarkDir<CR>
nnoremap <leader>fv :CtrlPRTS<CR>
nnoremap <leader>fl :CtrlPLine<CR>
nnoremap <leader>ft :CtrlPBufTag<CR>
nnoremap <leader>fat :CtrlPTag<CR>
let ctrlp_max_height=35
" Open marked buffers in same window
let g:ctrlp_open_multiple_files = 'i'
" do search by filename instead of path by default
let g:ctrlp_by_filename = 1

" }}}
" Perforce {{{

let g:p4EnableRuler = 1
let g:p4EnableMenu = 0
let g:p4EnableActiveStatus = 0
let g:p4OptimizeActiveStatus = 1
let g:p4EnableFileChangedShell = 0
let g:p4DefaultListSize = 1000
let g:p4UseVimDiff2 = 1
let g:p4UseVimDiff = 1
let g:p4Autoread = -1
let g:p4PromptToCheckout = 0
let g:no_plugin_maps = 1
let g:loaded_perforcemenu = 1
let g:p4ClientRoot='c:/src'
let g:p4Client=$P4CLIENT

" opened files
nnoremap <silent> <leader>po :PO<CR>
" Edit file
nnoremap <silent> <leader>pe :PEdit<CR>
nnoremap <silent> <leader>pr :PRevert<CR>
nnoremap <silent> <leader>pc :PF change<CR>
nnoremap <silent> <leader>pf :PFileLog<CR>
nnoremap <silent> <leader>pd :PF diff<CR>

" }}}
" Powerline {{{

let g:Powerline_symbols = 'fancy'
let g:Powerline_cache_enabled = 1
let g:Powerline_theme='mytheme'
" }}}
" QuickTask {{{

nnoremap <silent> <leader>et :e $TEMP/tasks.txt<CR>

" }}}
" code_complete {{{

let g:completekey = "<c-tab>"   "hotkey

" }}}

" }}}
" Clearing highlighting of previously searched pattern when vimrc is loaded
:nohlsearch

