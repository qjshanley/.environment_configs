" general settings
if exists('+relativenumber')
  set relativenumber
endif

if exists('+number')
  set number
endif

set t_Co=256                    " turn on 256 color
syntax on                       " enable syntax highlighting
filetype plugin indent on       " latest smart tab setting
"set tabstop=4                   " defines the number of columns a tab character should account for (just use the default)
set shiftwidth=4                " the number of columns text is indented with the reindent operations (<< and >>)
set softtabstop=4               " defines the number of columns used when you hit Tab in insert mode
set expandtab                   " causes the number of spaces, defined in softtabstop, to be used when you hit Tab in insert mode. converts the tab key to insert n spaces.
set hlsearch                    " when searching, highlight all
set shortmess+=I                " don't display the intro message
set backspace=indent,eol,start  " enable regular backspacing
set timeoutlen=1000 
set ttimeoutlen=10
set winheight=1
set winwidth=1
set winminheight=0
set winminwidth=1

let mapleader = ','

" Yank/Paste to clipboards
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" turn number on and off
map <Leader>no :set nonumber <bar> :set norelativenumber<CR>
map <Leader>nO :set number <bar> :set relativenumber<CR>

" set tab width
map <Leader>tw2 :set tabstop=2 <bar> :set shiftwidth=2 <bar> :set softtabstop=2 <CR>
map <Leader>tw4 :set tabstop=4 <bar> :set shiftwidth=4 <bar> :set softtabstop=4 <CR>

" git commands
map <Leader>gs :! git status<CR>
map <Leader>gd :! git diff %<CR>
map <Leader>ga :! git add %<CR>

" open commands
map <Leader>ob :buffers<CR>:buffer<Space>
map <Leader>oe :Vexplore<CR>

" code folding settings
if exists('+foldmethod')
  set foldmethod=indent
  set foldlevel=1
  set foldlevelstart=0
  set foldnestmax=10
  nnoremap f za
  nnoremap < zm
  nnoremap > zr
endif

" make tabs intuitive for insert mode
inoremap <S-Tab> <Esc><<i
nnoremap <Tab> >>i<Esc>
nnoremap <S-Tab> <<i<Esc>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" key mappings
nnoremap T :tabnew<CR>
nnoremap L :tabnext<CR>
nnoremap H :tabprev<CR>
nnoremap <C-S-L> :tabm +1<CR>
nnoremap <C-S-H> :tabm -1<CR>
"nnoremap s :%s/    /\t/gc<CR>
set pastetoggle=<F2>
nnoremap <F8> :let @/ = ""<CR>

" quicker page navigation
noremap <C-j> <C-d>
noremap <C-k> <C-u>
