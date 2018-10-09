DEFAULT_URL_PATTERN='http://ftpmirror.gnu.org/${SOFTWARE}/${SOFTWARE}-${VERSION}.${EXTENSION}'
URL="$DEFAULT_URL_PATTERN"
SOFTWARE="bash"
CONFIG_OPTIONS="--prefix=/usr/local"
VERSION="4.4.18"
EXTENSION="tar.gz"

printf -- "%s\n" "mkdir -p /tmp/install-$$ && cd /tmp/install-$$"
printf -- "%s\n" "curl -JL $URL | tar xz > ${SOFTWARE}-${VERSION}"
printf -- "%s\n" "cd ${SOFTWARE}-${VERSION}"
printf -- "./configure %s && make && sudo make install\n" "$CONFIG_OPTIONS"
