" general settings
if exists('+relativenumber')
  set relativenumber
endif

if exists('+number')
  set number
endif

command Q qa

set t_Co=256                    " turn on 256 color
syntax on                       " enable syntax highlighting
filetype plugin indent on       " latest smart tab setting
set tabstop=2                   " show existing tab
set shiftwidth=2                " when indenting with '>', use spaces
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

" turn number on and off
map <Leader>no :set nonumber <bar> :set norelativenumber<CR>
map <Leader>nO :set number <bar> :set relativenumber<CR>

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
