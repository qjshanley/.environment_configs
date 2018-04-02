# User specific aliases and functions
alias vi='vim'
alias lh='ls -lh | less'
alias lha='ls -lha | less'

shh() { 
  if [ "$1" == "-c" ]; then
    # copy dot files
    shift 1
    scp ~/.vimrc ~/.screenrc ~/.bash_aliases "$1":~/.
  fi
  ssh -t "$1" screen -D -R
}

oom_check() {
  printf "Container ID: "
  read CID
  CPU_SET="$(sudo docker inspect $CID | grep "Id" | awk -F'"' '{print $4}')" && dmesg -t | grep "$CPU_SET"
}
