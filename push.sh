#!/bin/sh

./gen-md5.sh
rsync -var --delete myslackbuilds conoha:/var/www/htdocs/slackhax.esper/
