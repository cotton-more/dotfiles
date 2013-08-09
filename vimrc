set nocompatible        " Must be first line

" Setup Bundle Support {
" The next three lines ensure that the ~/.vim/bundle/ system works
    filetype on
    filetype off
    set rtp+=~/.vim/bundle/vundle
    call vundle#rc()
" }

" Use bundles config {
    if filereadable(expand("~/.vimrc.bundle"))
        source ~/.vimrc.bundle
    endif
" }

" General {
    " Prevent cursor from moving back one character on insert mode exit
    inoremap <silent> <Esc> <Esc>`^
    set encoding=utf-8
    set ffs=unix,dos,mac
    set ttyfast
    filetype plugin indent on   " Automatically detect file types
    set omnifunc=syntaxcomplete#Complete
    if !has('gui')
        set term=$TERM
    endif
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)

    " Turn off backup, use version control system
    set nobackup
    set nowb
    set noswapfile

    try
        set undodir=~/.vimundo
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif
    catch
    endtry

    if has ('x') && has ('gui') " On Linux use + register for copy-paste
        set clipboard=unnamedplus
    elseif has ('gui')          " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif

    " Disable scrollbars (real hackers don't use scrollbars for navigation!)
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
" }

" Formatting {
    set nowrap                      " Wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
" }

" UI {
    highlight NonText guibg=#060606

    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set guioptions+=e
        set guitablabel=%M\ %t
        set lines=40                " 40 lines of text instead of 24
        if has("gui_gtk2")
            set guifont=Anonymous\ Pro\ 14,Consolas\ Regular\ 14,Courier\ New\ Regular\ 16
        elseif has("gui_win32")
            set guifont=Anonymous_Pro:h15,Consolas:h10,Courier_New:h10
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
    endif

    set relativenumber
    set numberwidth=4

    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line
    set cursorcolumn                " highlight cursor column
    highlight clear SignColumn      " SignColumn should match background for
                                    " things like vim-gitgutter

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2
    endif

    set nostartofline               " Keep cursor in same column for long-range motion cmds
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

    set smarttab
    set shiftround
" }

" Key (re)Mappings {
    noremap! hh <Esc>
    noremap! jj <Esc>

    let mapleader = ','
    let maplocalleader = '-'

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Toggle search highlighting
    nnoremap <silent> <leader>/ :nohl<CR>

    nnoremap <tab> %
    vnoremap <tab> %

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    nnoremap <Left> :echoe "Use h"<CR>
    nnoremap <Right> :echoe "Use l"<CR>
    nnoremap <Up> :echoe "Use k"<CR>
    nnoremap <Down> :echoe "Use j"<CR>

    " Tab for autocomplete in Insert mode
    imap <Tab> <C-N>

    " Fast saving
    nmap <leader>w :w!<cr>

    " Toggle paste mode on and off
    map <leader>pp :setlocal paste!<cr>:
" }

" Functions {
    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }
" }

autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" ----------------------------------------------------------------------------
" Allow overriding these settings
" ----------------------------------------------------------------------------
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
