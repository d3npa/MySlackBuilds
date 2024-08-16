#!/bin/sh

PACKAGE=$1

if [ -z $PACKAGE ] || [ ! -f $PACKAGE ]
then
  echo "no such file: $PACKAGE"
  exit 1
fi

tar zxf $PACKAGE -C /
test -f /install/doinst.sh && \
  echo "executing /install/doinst.sh" && \
  sh /install/doinst.sh && \
  rm -r /install

