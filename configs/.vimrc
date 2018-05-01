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
set hlsearch                    " when searching, highlight all
set shortmess+=I                " don't display the intro message
set backspace=indent,eol,start  " enable regular backspacing
set timeoutlen=1000 
set ttimeoutlen=10
set winheight=1
set winwidth=1
set winminheight=0
set winminwidth=1

" Formats the statusline
set laststatus=2
set statusline=%f\ %=%m%r\ [%p%%]\ [line:%03l/%03L,col:%03v]

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
map <ESC>[1;2a :call MoveWindow("K")<CR>
map <ESC>[1;2b :call MoveWindow("J")<CR>
map <ESC>[1;2c :call MoveWindow("L")<CR>
map <ESC>[1;2d :call MoveWindow("H")<CR>

" ALT/OPT-o/O key mappings for full window resize
map ø :call MakeMainWindow()<CR>
map Ø :resize <BAR> :vertical resize<CR>

" SHIFT-ALT/OPT-Arrow key mappings for full window resize
map <ESC>[1;2A :resize<CR>
map <ESC>[1;2B :resize<CR>
map <ESC>[1;2C :vertical resize<CR>
map <ESC>[1;2D :vertical resize<CR>

function MakeMainWindow()
  " create the window order
  wincmd J
  let i = 1
  let windowCount = winnr('$')
  while i < windowCount
    1 windo wincmd J
    let i += 1
  endwhile

  " send NetRW windows to the left
  call KeepDrawerLeft()

  " find the first non NetRW window and Move left
  call SelectMain()
  call MoveWindow('H')
endfunction

function SelectMain()
  let i = 1
  let windowCount = winnr('$')
  let found = 'false'
  while found == 'false' && i <=  windowCount
    execute i . ' windo if @% != "NetrwTreeListing" | let found = "true" | endif'
    let i += 1
  endwhile
endfunction

function MoveWindow(Direction)
  execute "wincmd " . a:Direction
  call KeepDrawerLeft()
  if a:Direction == 'K' || a:Direction == 'H'
    call SelectMain()
  else
    windo echo
  endif
endfunction

function SetupDrawer()
  let g:netrw_banner = 0
  let g:netrw_liststyle = 3
  let g:netrw_browse_split = 4
  Vexplore
  2 windo call MakeMainWindow()
endfunction

function OpenDrawer()
  vertical resize 40
  execute line('.')
endfunction

function CloseDrawer()
  vertical resize 0
endfunction

function KeepDrawerLeft()
  windo if @% == "NetrwTreeListing" | wincmd H | call CloseDrawer() | endif
endfunction

augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * call SetupDrawer()
  autocmd WinEnter NetrwTreeListing call OpenDrawer()
  autocmd WinLeave NetrwTreeListing call CloseDrawer()
augroup END

function SetupWindowStyle()
  " default the statusline to green when entering Vim
  hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15
endfunction

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

augroup WindowStylizing
  autocmd!
  autocmd VimEnter * call SetupWindowStyle()
  autocmd InsertEnter * call InsertStatuslineColor(v:insertmode)
  autocmd InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15
augroup END
