#!/bin/sh

REPO=myslackbuilds/15.0

cd $REPO
find . -type f -exec md5sum {} \; > CHECKSUMS.md5
