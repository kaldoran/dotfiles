" PLUGIN CONFIGURATION =============================
call plug#begin('~/.vim/plugged')
Plug 'L9'
Plug 'Colour-Sampler-Pack'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
"snippets --------------------
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"-----------------------------
Plug 'fugitive.vim' " TODO: nvim-compatible
Plug 'searchfold.vim'
Plug 'Tabular'
Plug 'The-NERD-Commenter'
"Plug 'tpope/vim-commentary'
Plug 'EasyMotion'
Plug 'FuzzyFinder'
Plug 'mattn/webapi-vim' "vim-quicklink dependency
Plug 'christoomey/vim-quicklink'
Plug 'AndrewRadev/switch.vim'
Plug 'ack.vim'
Plug 'taglist.vim'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'plasticboy/vim-markdown', { 'frozen': 1 }
Plug 'DrawIt'
Plug 'tpope/vim-rsi', 'no_meta_opts'
Plug 'tpope/vim-unimpaired'
Plug 'atweiden/vim-dragvisuals'
Plug 'shinokada/listtrans.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-speeddating'
" tpop/vim-eunuch -----------------------
Plug 'tpope/vim-eunuch', { 'frozen': 1 }
Plug 'tpope/vim-eunuch', 'RmSwp-command'
"----------------------------------------
Plug 'scrooloose/syntastic' " TODO: nvim-compatible
Plug 'Valloric/YouCompleteMe', { 'do' : './install.sh --clang-completer --omnisharp-completer' } " TODO: nvim-compatible
Plug 'rdnetto/YCM-Generator', 'stable' " TODO: nvim-compatible
Plug 'dahu/Area-41'
Plug 'Xe/lolcode.vim'
Plug 'aaronbieber/vim-quicktask'
Plug 'TaskList.vim'
Plug 'mhinz/vim-startify'
Plug 'Raimondi/delimitMate'

" This is taken care by pacman (archlinux)
"Plugin 'vim-jedi' -- pacman
"Plugin 'vim-runtime' -- pacman
"Plugin 'vim-spell-fr' -- pacman
call plug#end()

filetype plugin indent on
let mapleader=","
let g:syntaxed_fts = ["vim","tex","python","pyrex","c","cpp","php","js","html","css","cs","java","mkd","markdown","rst","cmake","make"]

""" PERSONNAL PLUGIN SETTINGS
" This code sources files under a directory. I've stopped using this in favor of
" placing all files under ~/.vim/after/plugin/
let s:settings_dir="~/.vim/plugins-config/"
let s:configs = ["taglist.vim",
            \ "rsi.vim",
            \ "gundo.vim",
            \ "pyclewn.vim",
            \ "vim-multi-cursor.vim",
            \ "ack.vim",
            \ "fugitive.vim",
            \ "snipMate.vim",
            \ "ultisnips.vim",
            \ "jedi-vim.vim",
            \ "NERDCommenter.vim",
            \ "pi_netrw.vim",
            \ "dragvisuals.vim",
            \ "quicktask.vim",
            \ "listtrans.vim",
            \ "fuzzyfinder.vim",
            \ "markdown.vim",
            \ "youcompleteme.vim",
            \ "syntastic.vim"]
for s:plugin in s:configs
    execute ":source " . s:settings_dir . s:plugin
endfor
" ==================================================

" COMMANDS ====================================
" Start a urxvt in the current working directory
command! Shell !urxvt -cd "$PWD" &
au BufRead,BufNewFile,Filetype yaml command! YaumlPdf !yauml -Tpdf -o '%:p:t:r'.pdf '%:p:t'
au BufRead,BufNewFile,FileType tex command! WcLatex write !detex | wc -w
nnoremap <leader>yp :YaumlPdf<CR>
" =============================================

"TODO: Comments
syntax on " enable syntax highlighting
set fo=tcroql " wraps comments after hitting <enter>, 'o' or when typing text after textwidth
set autochdir
set encoding=utf-8
set hlsearch " hightlight search
set incsearch " search preview
set ignorecase " search is not case sensitive
set smartcase " smart search
set showmatch " highlight brackets
set history=50 " 50 lines of command lines history
set viminfo='20,\"50 " .viminfo file with 50 lines of registers
set ruler " show the cursor position all the time
set spelllang=fr " spellcheck language
set ai " autoindenting
set tabstop=4 " tabulation
set shiftwidth=4 " tabulation
set expandtab " tabulation
set smarttab
set softtabstop=4 " Comportement du «backspace» avec les tabs
set backspace=2 " make backspace work like most other apps
set number " line numbers
set relativenumber " relative numbers too
set laststatus=2 "status bar always show
set noshowmode
" filetype settings
au BufRead,BufNewFile ~/.mutt/* set filetype=muttrc
au BufRead,BufNewFile *.sage set filetype=python
au BufRead,BufNewFile *.pxd,*.pyx,*.spyx set filetype=python | set syntax=pyrex
au BufRead,BufNewFile *.tex,*.tikz,*.sagetex set filetype=tex
au BufRead,BufRead *.mustache set filetype=html
set tw=80 " wrapping lines
au BufRead,BufNewFile,Filetype python,c,cpp,java,cs,html,css,php set tw=80
au BufRead,BufNewFile,Filetype yaml,mkd,markdown set tw=80
au BufRead,BufNewFile,Filetype tex set tw=100

" COLORSCHEME ==========
"set t_Co=256 " using 256 colors (needed for colorschemes and lightline plugin)
colorscheme wombat256mod
" ======================

" highlighting extra white sapces ====================================
fun! s:StripTrailingWhiteSpaces()
    let l:pos = getcurpos()
    exec ":%s/\\s\\+$//e"
    call setpos('.', l:pos)
endf
highlight ExtraWhiteSpaces ctermbg=red guibg=red
autocmd ColorScheme hightlight ExtraWhiteSpaces ctermbg=red guibg=red
match ExtraWhiteSpaces /\s\+$\| \+\ze\t/
exec "au FileType ".join(g:syntaxed_fts, ',')." au BufWritePre * call s:StripTrailingWhiteSpaces()"
" ====================================================================

au BufRead,BufNewFile,Filetype c,cpp set si
" TODO:
" save and recover folding areas
"autocmd BufWrite * mkview
"autocmd BufRead * silent loadview

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Source $MYVIMRC every time it's edited
" TODO: bug avec le lightline
"augroup vimrc
	"au!
	"au bufwritepost .vimrc source $MYVIMRC
"augroup END

" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" CUSTOM CONFIGURATION ==========
source ~/.vim/abbreviations.vim
source ~/.vim/functions.vim
source ~/.vim/mappings.vim
" ===============================
