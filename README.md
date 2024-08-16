# MySlackBuilds

自分で書いたSlackBuildスクリプトのリポジトリです。もともとはgit使わずに適当にやってましたが、変更履歴残したくなって、gitで管理するようになりました。利用方法はHPにて: 

[https://pixeldreams.tokyo/slackbuilds/](https://pixeldreams.tokyo/slackbuilds/)
## テンプレート・スクリプト

新しいSlackBuildをはじめるときのためのテンプレート・スクリプトも書きました。自分のシステムでは `$HOME/bin` においてますのでここに適当にコピペします。もし使う場合は `$MAINTAINER` と `$EMAIL` 、`$BUILD_SUFFIX` を変えてください。

```sh
#!/bin/sh

NAME=$1
VERSION=$2
MAINTAINER='kyo.ko'
EMAIL='kyo@tilde.pink'
BUILD_SUFFIX='k'

usage() {
  echo "usage: $0 <name> <version>" >&2
  exit 1
}

test -z $NAME && usage
test -z $VERSION && usage

cat <<-EOF > slack-desc
app: $NAME
app:
app: enter description here
app:
app:
app:
app:
app:
app:
app:
app:
EOF

cat <<-EOF > $NAME.info
PRGNAM="$NAME"
VERSION="$VERSION"
HOMEPAGE=""
DOWNLOAD=""
MD5SUM=""
REQUIRES=""
MAINTAINER="$MAINTAINER"
EMAIL="$EMAIL"
EOF

cat <<-EOF > $NAME.SlackBuild
#!/bin/sh -e
CWD=\$(pwd)
TMP=\${TMP:-/tmp}
OUTPUT=\${OUTPUT:-/tmp}
VERSION=\${VERSION:-$VERSION}
PKG_VERSION=\${VERSION}

BUILD=\${BUILD:-1_$BUILD_SUFFIX}

APP=$NAME
WRKDIR=\$TMP/wrk-\$APP
PKGDIR=\$WRKDIR/package
BLDDIR=\$WRKDIR/build

rm -rf \$WRKDIR
mkdir -p \$PKGDIR/install
cp \$CWD/slack-desc \$PKGDIR/install/slack-desc

mkdir -p \$BLDDIR
# build package here

cd \$PKGDIR
chown -R root:root .
chmod -R u+w,go+r-w,a-s .
/sbin/makepkg -l y -c n \$OUTPUT/\$APP-\$PKG_VERSION-\$ARCH-\$BUILD.tgz
EOF

echo 'generated generic SlackBuild files.'
echo "make sure to edit fields in $NAME.info"
```

