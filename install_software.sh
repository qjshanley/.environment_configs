#!/usr/bin/env bash

DEFAULT_URL_PATTERN='http://ftpmirror.gnu.org/${SOFTWARE}/${SOFTWARE}-${VERSION}.${EXTENSION}'
declare -A SOFTWARE_LIST=(
  [0,"SOFTWARE"]="autoconf"         [0,"CONFIG_OPTIONS"]="--prefix=/usr/local"      [0,"VERSION"]="2.69"        [0,"EXTENSION"]="tar.gz"        [0,"URL"]="$DEFAULT_URL_PATTERN"
  [1,"SOFTWARE"]="automake"         [1,"CONFIG_OPTIONS"]="--prefix=/usr/local"      [1,"VERSION"]="1.16"        [1,"EXTENSION"]="tar.xz"        [1,"URL"]="$DEFAULT_URL_PATTERN"
  [2,"SOFTWARE"]="bash"             [2,"CONFIG_OPTIONS"]="--prefix=/usr/local"      [2,"VERSION"]="4.4.18"      [2,"EXTENSION"]="tar.gz"        [2,"URL"]="$DEFAULT_URL_PATTERN"
  [3,"SOFTWARE"]="gawk"             [3,"CONFIG_OPTIONS"]="--prefix=/usr/local"      [3,"VERSION"]="4.2.1"       [3,"EXTENSION"]="tar.xz"        [3,"URL"]="$DEFAULT_URL_PATTERN"
  [4,"SOFTWARE"]="screen"           [4,"CONFIG_OPTIONS"]="--prefix=/usr/local"      [4,"VERSION"]="4.6.2"       [4,"EXTENSION"]="tar.gz"        [4,"URL"]="$DEFAULT_URL_PATTERN"
  [5,"SOFTWARE"]="sed"              [5,"CONFIG_OPTIONS"]="--prefix=/usr/local"      [5,"VERSION"]="4.5"         [5,"EXTENSION"]="tar.xz"        [5,"URL"]="$DEFAULT_URL_PATTERN"
  [6,"SOFTWARE"]="tar"              [6,"CONFIG_OPTIONS"]="--prefix=/usr/local"      [6,"VERSION"]="1.30"        [6,"EXTENSION"]="tar.gz"        [6,"URL"]="$DEFAULT_URL_PATTERN"
  [7,"SOFTWARE"]="coreutils"        [7,"CONFIG_OPTIONS"]="--prefix=/usr/local"      [7,"VERSION"]="8.30"        [7,"EXTENSION"]="tar.xz"        [7,"URL"]="$DEFAULT_URL_PATTERN"
  [8,"SOFTWARE"]="inetutils"        [8,"CONFIG_OPTIONS"]="--prefix=/usr/local"      [8,"VERSION"]="1.9.4"       [8,"EXTENSION"]="tar.gz"        [8,"URL"]="$DEFAULT_URL_PATTERN"
  [9,"SOFTWARE"]="findutils"        [9,"CONFIG_OPTIONS"]="--prefix=/usr/local"      [9,"VERSION"]="4.6.0"       [9,"EXTENSION"]="tar.gz"        [9,"URL"]="$DEFAULT_URL_PATTERN"

  [10,"SOFTWARE"]="pkg-config"
	[10,"CONFIG_OPTIONS"]="--prefix=/usr/local --with-internal-glib"
	[10,"VERSION"]="0.29.2"
	[10,"EXTENSION"]="tar.gz"
	[10,"URL"]='https://pkg-config.freedesktop.org/releases/${SOFTWARE}-${VERSION}.${EXTENSION}'

  [11,"SOFTWARE"]="wget"            [11,"CONFIG_OPTIONS"]="--prefix=/usr/local"     [11,"VERSION"]="1.20.1"     [11,"EXTENSION"]="tar.gz"       [11,"URL"]="$DEFAULT_URL_PATTERN"

  [12,"SOFTWARE"]="gnutls"
        [12,"CONFIG_OPTIONS"]="--prefix=/usr/local"
        [12,"VERSION"]="3.6.6"
        [12,"EXTENSION"]="tar.xz"
        [12,"URL"]='https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/${SOFTWARE}-${VERSION}.${EXTENSION}'
)

if [[ -z $* ]] ; then
	# prompt user for input
	i=0
	while [[ -n ${SOFTWARE_LIST[$i,SOFTWARE]} ]] ; do
		printf -- "%s: %s\n" "$i" "${SOFTWARE_LIST[$i,SOFTWARE]}"
		(( i++ ))
	done
	read -p "install numbers: " RANGE <>/dev/tty
else 
	# use arg list
	RANGE="$*"
fi

for i in $RANGE ; do
  SOFTWARE="${SOFTWARE_LIST[$i,SOFTWARE]}"
  VERSION="${SOFTWARE_LIST[$i,VERSION]}"
  EXTENSION="${SOFTWARE_LIST[$i,EXTENSION]}"
  URL="$(eval printf "%s" "${SOFTWARE_LIST[$i,URL]}")"

  printf -- "%s\n" "mkdir -p /tmp/install-$$ && cd /tmp/install-$$"
  printf -- "%s\n" "curl -JL $URL | tar xz > ${SOFTWARE}-${VERSION}"
  printf -- "%s\n" "cd ${SOFTWARE}-${VERSION}"
  printf -- "./configure %s && make && sudo make install\n" "${SOFTWARE_LIST[$i,CONFIG_OPTIONS]}"
done > /dev/stdout
