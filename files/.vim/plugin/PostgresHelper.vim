function Pgd()
  vertical new
  execute '0r ! psql pod-api -c "\d+ ' . @/ . '"'
endfunction
