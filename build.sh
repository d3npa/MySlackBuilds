#!/bin/sh

alias info='echo "[*] $1"'

error() {
  printf "\x1b[91m%s\x1b[0m\n" "[!] error $1"
  exit 1
}

usage() {
  cat <<- EOF
This script downloads a slackbuild from the slackhax repo and builds it without
 relying on sbopkg. On a Slackware (Current) system this should just work. On
 other distros, review the slackbuild script for possible program dependencies.
 This script itself depends on wget and bash. 

Run under root user (do not use sudo if $$PATH is different!)

Usage: $0 <slackbuild name>
EOF
  exit 0
}

if [ $UID != 0 ]
then
  echo "rerun as root"
  exit 1
fi

SLACKBUILD=$1
URL_BASE="https://pixeldreams.tokyo/slackbuilds/15.0/slackhax/$SLACKBUILD"

test -z $SLACKBUILD && usage

SLACKBUILD_DIR="/tmp/slackbuild_$SLACKBUILD"
test -e "$SLACKBUILD_DIR" && \
  (rm -r "$SLACKBUILD_DIR" || error "removing old $SLACKBUILD_DIR")
mkdir -p "$SLACKBUILD_DIR" || error "creating $SLACKBUILD_DIR"
cd $SLACKBUILD_DIR

INFO_URL="$URL_BASE/${SLACKBUILD}.info"
SLACKBUILD_URL="$URL_BASE/${SLACKBUILD}.SlackBuild"
wget "$INFO_URL" || error "downloading $INFO_URL"
wget "$SLACKBUILD_URL" || error "downloading $SLACKBUILD_URL"

set +x
pwd
ls
source "./${SLACKBUILD}.info"
info "Downloading and building $PRGNAM $VERSION ($HOMEPAGE)"

WGET_COMMAND="$(which wget) $WGETFLAGS $DOWNLOAD"
$WGET_COMMAND || error "downloading $DOWNLOAD"
bash ${SLACKBUILD}.SlackBuild


