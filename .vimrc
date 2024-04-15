set nocompatible      " Enable Vim mode (instead of vi emulation)

set autoindent        " Intelligent indentation matching
set autoread          " Update the file if it's changed externally
set backspace=indent,eol,start  " Allow backspacing over anything
set belloff=all       " Turn off bells
set display=truncate  " Show '@@@' when the last screen line overflows
set formatoptions+=j  " Delete comment char when joining lines
set history=100       " Undo up to this many commands
set hlsearch          " Highlight search results
set incsearch         " Highlight search matches as you type them
set ruler             " Show cursor position
set ttyfast           " Redraw faster for smoother scrolling
set wildmenu          " Show menu for tab completion in command mode

syntax on             " Enable syntax highlighting

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=ucs-bom,utf-8,latin1
endif

" CTRL-L will mute highlighted search results
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set viminfo=""
set mouse=
set ttymouse=
