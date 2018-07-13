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
    execute i . ' windo if @% !~ "NetrwTreeListing*" | let found = "true" | endif'
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
  windo if @% =~ "NetrwTreeListing*" | wincmd H | call CloseDrawer() | endif
endfunction

augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * call SetupDrawer()
  autocmd WinEnter NetrwTreeListing* call OpenDrawer()
  autocmd WinLeave NetrwTreeListing* call CloseDrawer()
augroup END
