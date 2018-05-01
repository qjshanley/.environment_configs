#!/usr/bin/env bash

DEFAULT_URL_PATTERN='http://ftpmirror.gnu.org/${SOFTWARE}/${SOFTWARE}-${VERSION}.${EXTENSION}'
declare -A GNU_SOFTWARE_LIST=(
  [0,"SOFTWARE"]="sed"
  [0,"VERSION"]="4.5"
  [0,"EXTENSION"]="tar.xz"
  [0,"URL"]="$DEFAULT_URL_PATTERN"

  [1,"SOFTWARE"]="screen"
  [1,"VERSION"]="4.6.2"
  [1,"EXTENSION"]="tar.gz"
  [1,"URL"]="$DEFAULT_URL_PATTERN"
)

i=0
while [ -n "${GNU_SOFTWARE_LIST["$i","SOFTWARE"]}" ] ; do
  mkdir -p /tmp/gnu && cd /tmp/gnu

  SOFTWARE="${GNU_SOFTWARE_LIST[$i,SOFTWARE]}"
  VERSION="${GNU_SOFTWARE_LIST[$i,VERSION]}"
  EXTENSION="${GNU_SOFTWARE_LIST[$i,EXTENSION]}"
  URL="$(eval printf "%s" "${GNU_SOFTWARE_LIST[$i,URL]}")"

  printf "%s\n" "curl -JOL $URL"
  printf "%s\n" "tar xzvf ${SOFTWARE}-${VERSION}.${EXTENSION}"
  printf "%s\n" "cd ${SOFTWARE}-${VERSION}"
  printf "%s\n" "./configure --prefix=/usr/local && make && sudo make install"
  printf "done\n\n"

  i=$(( $i + 1 ))
done
