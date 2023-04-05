"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"																				"
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗							"
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝							"
"               ██║   ██║██║██╔████╔██║██████╔╝██║								"
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║								"
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗							"
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝							"
"																				"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" zo to open a single fold under the cursor.
" zc to close the fold under the cursor.
" zR to open all folds.
" zM to close all folds
" zf to create a fold

" BASIC-SETTINGS --------------------------------------------------------------- {{{
" Mouse will work
set mouse=a

" highlights as you type search string
set incsearch

" auto tab when newline
set autoindent

" Syntax colours
syntax on

" set line number
set number relativenumber

" ignorecase when searching
set ignorecase

"highlights matches when searching
set showmatch

"sets max row width (Norme 42)
"set textwidth=80

"used to highlight l81 (Norme 42)
set colorcolumn=81

"highlight current line
set cursorline

"set tab to match ecole42
set tabstop=4
set shiftwidth=4
set softtabstop=4

"add a line at column 81 to make sure norm 42 is respected.
highlight ColorColumn ctermbg=0 guibg=lightgrey

"@DaiClement whitespace trick
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"Help with tabs
set smartindent
set cindent

"Help file related settings
" search down into subfolders with :find just use wildcard operator !!
set path+=**

" Display all matching files when tab complete
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}

" STATUSLINE ------------------------------------------------------------ {{{
" Returns current branch or an empty string if there is no git repository
function Gitbranch()
  let l:branchname = trim(system("git -C " . expand("%:h") . " branch --show-current 2>/dev/null"))
  return strlen(l:branchname) > 0?'   '.l:branchname.'  ':''
endfunction

augroup Gitget
    autocmd!
    autocmd BufEnter * let b:git_branch = Gitbranch()
augroup END

" Clear status line when vimrc is reloaded.
set statusline=

" Color first block
set statusline+=%#Visual#
" Show git if exists.
set statusline+=%{b:git_branch}

" Color second block
set statusline+=%#LineNr#
" Status line left side.
set statusline+=\ %n\ %f\ %m\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Color third block
set statusline+=%#VisualNOS#
" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c  

" Show the status on the second to last line.
set laststatus=2

" }}}

" NERDTree --------------------------------------------------------------- {{{

" a file browser to optimise your workflow
" https://github.com/preservim/nerdtree -- full documention here

" map Ctrl-N to toggle NerdTree
"map <C-n> :NERDTreeToggle<CR>

" Refresh NerdTree if its open otherwise toggle NerdTree
map <C-n> :call NERDTreeToggleAndRefresh()<CR>

function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

" auto load NERDTREE when starting vim with no file/folder
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close VIM if NERDTREE is only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" }}}

" THEMES --------------------------------------------------------------- {{{
" ++++++++++++++++++++++++++ "
"        SpaceGray           "
" ++++++++++++++++++++++++++ "
" the spacegrey theme works best for me but there are many 
" https://github.com/ajh17/Spacegray.vim -- full documentation here
" https://colorswat.ch/vim/  -- site to see themes and colors

let g:spacegray_use_italics = 1

colorscheme spacegray

" }}}

" MAPPINGS ----------------------------------------------------------------- {{{
"Syntax 
"	map_mode <what_you_type> <what_is_executed>

" nnoremap – Allows you to map keys in normal mode.
" inoremap – Allows you to map keys in insert mode.
" vnoremap – Allows you to map keys in visual mode.

" You can split the window in Vim by typing :split or :vsplit.
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s

" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" }}}
