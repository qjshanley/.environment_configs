#!/usr/bin/env bash

DEFAULT_URL_PATTERN='http://ftpmirror.gnu.org/${SOFTWARE}/${SOFTWARE}-${VERSION}.${EXTENSION}'
declare -A GNU_SOFTWARE_LIST=(
  [0,"SOFTWARE"]="bash"
  [0,"VERSION"]="4.4.18"
  [0,"EXTENSION"]="tar.gz"
  [0,"URL"]="$DEFAULT_URL_PATTERN"

  [1,"SOFTWARE"]="screen"
  [1,"VERSION"]="4.6.2"
  [1,"EXTENSION"]="tar.gz"
  [1,"URL"]="$DEFAULT_URL_PATTERN"

  [2,"SOFTWARE"]="gawk"
  [2,"VERSION"]="4.2.1"
  [2,"EXTENSION"]="tar.xz"
  [2,"URL"]="$DEFAULT_URL_PATTERN"

  [3,"SOFTWARE"]="sed"
  [3,"VERSION"]="4.5"
  [3,"EXTENSION"]="tar.xz"
  [3,"URL"]="$DEFAULT_URL_PATTERN"

  [4,"SOFTWARE"]="autoconf"
  [4,"VERSION"]="2.69"
  [4,"EXTENSION"]="tar.gz"
  [4,"URL"]="$DEFAULT_URL_PATTERN"

  [5,"SOFTWARE"]="automake"
  [5,"VERSION"]="1.16"
  [5,"EXTENSION"]="tar.xz"
  [5,"URL"]="$DEFAULT_URL_PATTERN"
)

i=0
while [ -n "${GNU_SOFTWARE_LIST["$i","SOFTWARE"]}" ] ; do
  SOFTWARE="${GNU_SOFTWARE_LIST[$i,SOFTWARE]}"
  VERSION="${GNU_SOFTWARE_LIST[$i,VERSION]}"
  EXTENSION="${GNU_SOFTWARE_LIST[$i,EXTENSION]}"
  URL="$(eval printf "%s" "${GNU_SOFTWARE_LIST[$i,URL]}")"

  printf "%s\n" "mkdir -p /tmp/gnu && cd /tmp/gnu"
  printf "%s\n" "curl -JOL $URL"
  printf "%s\n" "tar xzvf ${SOFTWARE}-${VERSION}.${EXTENSION}"
  printf "%s\n" "cd ${SOFTWARE}-${VERSION}"
  printf "%s\n" "./configure --prefix=/usr/local && make && sudo make install"

  i=$(( $i + 1 ))
done
