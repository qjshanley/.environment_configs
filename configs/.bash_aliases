# User specific aliases and functions
alias vi='vim'
alias lh='ls -lh'
alias lha='ls -lha'

function datica() {
  case $1 in
    qub3r)  shift 1 && $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
    *)      $(which datica) -E 7f1569c5-8382-4cdf-833e-20326e12822c $@ ;;
  esac
}

function shh() { 
  if [ "$1" == "-c" ]; then
    # copy dot files
    shift 1
    scp ~/.vimrc ~/.screenrc ~/.bash_aliases "$1":~/.
  fi
  ssh -t "$1" screen -D -R
}

function oom_check() {
  printf "Container ID: " && read CID
  CPU_SET="$(sudo docker inspect $CID | grep "Id" | awk -F'"' '{print $4}')" && dmesg -t | grep "$CPU_SET"
}
