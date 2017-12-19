"general settings
if exists('+relativenumber')
  set relativenumber
endif

if exists('+number')
  set number
endif

syntax on
set laststatus=2
set smartindent
set tabstop=2
set softtabstop=2
set hlsearch
set showtabline=2
set expandtab 
set shiftwidth=2 
set smarttab
set autoindent
set shortmess+=I
set backspace=indent,eol,start

let mapleader = ','

" git commands
map <Leader>gs :! git status<CR>
map <Leader>gd :! git diff %<CR>
map <Leader>ga :! git add %<CR>

"code folding settings
if exists('+foldmethod')
  set foldmethod=indent
  set foldlevel=1
  set foldlevelstart=0
  set foldnestmax=10
  nnoremap f za
  nnoremap < zm
  nnoremap > zr
endif

"make tabs intuitive for insert mode
inoremap <S-Tab> <Esc><<i
nnoremap <Tab> >>i<Esc>
nnoremap <S-Tab> <<i<Esc>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

"key mappings
map! zz <Esc>
nnoremap ; :
nnoremap T :tabnew<CR>
nnoremap L :tabnext<CR>
nnoremap H :tabprev<CR>
nnoremap <C-S-L> :tabm +1<CR>
nnoremap <C-S-H> :tabm -1<CR>
nnoremap s :%s/    /\t/gc<CR>
set pastetoggle=<F2>
nnoremap <F3> :Explore<CR>
nnoremap <F4> :buffers<CR>:buffer<Space>
nnoremap <F8> :let @/ = ""<CR>

"key mappings for multi-window navigation
nnoremap <Up> <c-w>k
nnoremap <Down> <c-w>j
nnoremap <Left> <c-w>h
nnoremap <Right> <c-w>l

"mapping CTRL-SHIFT-Arrow keys
map [1;6A <C-S-Up>
map [1;6B <C-S-Down>
map [1;6D <C-S-Left>
map [1;6C <C-S-Right>

"mapping ALT-SHIFT-Arrow keys
map [1;9A :resize +2<CR>
map [1;9B :resize -2<CR>
map [1;9C :vertical resize +4<CR>
map [1;9D :vertical resize -4<CR>

