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
set tabstop=2                   " show existing tab
set shiftwidth=2                " when indenting with '>', use spaces
set expandtab                   " On pressing tab, insert spaces
set laststatus=2                " always display the status on the bottom-1 line
set hlsearch                    " when searching, highlight all
set shortmess+=I                " don't display the intro message
set backspace=indent,eol,start  " enable regular backspacing
set timeoutlen=1000 
set ttimeoutlen=10


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

set winheight=5
set winwidth=30
set winminheight=0

" Arrow key mappings for multi-window navigation
nnoremap <UP>     <C-W>k
nnoremap <DOWN>   <C-W>j
nnoremap <LEFT>   <C-W>h
nnoremap <RIGHT>  <C-W>l

" SHIFT-Arrow key mappings to resize windows
map <ESC>[1;0A :resize           +2<CR>
map <ESC>[1;0B :resize           -2<CR>
map <ESC>[1;0C :vertical resize  +4<CR>
map <ESC>[1;0D :vertical resize  -4<CR>

" ALT/OPT-Arrow key mappings for full window resize
map <ESC>[1;2a :wincmd K <BAR> :call KeepNetRWLeft()<CR>
map <ESC>[1;2b :wincmd J <BAR> :call KeepNetRWLeft()<CR>
map <ESC>[1;2c :wincmd L <BAR> :call KeepNetRWLeft()<CR>
map <ESC>[1;2d :wincmd H <BAR> :call KeepNetRWLeft()<CR>

" ALT/OPT-o/O key mappings for full window resize
map ø :resize <BAR> :vertical resize<CR>
map Ø :wincmd = <BAR> :execute "0," . winnr() . " windo echo "<CR>

" SHIFT-ALT/OPT-Arrow key mappings for full window resize
map <ESC>[1;2A :resize<CR>
map <ESC>[1;2B :resize<CR>
map <ESC>[1;2C :vertical resize<CR>
map <ESC>[1;2D :vertical resize<CR>

function SetupNetRW()
  let g:netrw_banner = 0
  let g:netrw_liststyle = 3
  let g:netrw_browse_split = 4
  Vexplore
  vertical resize 0
  2 windo echo
endfunction

function MinimizeOnLeave()
  if @% == 'NetrwTreeListing'
    vertical resize 0
  endif

  if winheight('%') < 8
    resize 0
  endif
  
  if winwidth('%') < 35
    vertical resize 0
  endif
endfunction

function KeepNetRWLeft()
  let goToWin = winnr('$')
  windo if @% == "NetrwTreeListing" | if winnr() != 1 | let goToWin = 2 | end | wincmd H | end
  execute "0," . goToWin . " windo echo"
endfunction

augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * call SetupNetRW()
  autocmd WinEnter NetrwTreeListing execute line('.')
  autocmd WinLeave * call MinimizeOnLeave()
augroup END
