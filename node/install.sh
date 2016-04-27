OS=`uname`
DISTRO=""
VERSION=$1

detect_version ()
{
  if [ $# -ne "1" ]
  then
    #echo "Usage: `basename $0` <version>"
    #exit 1
    VERSION="6.0.0"
  fi
}


detect_os ()
{
  if [[ "$OS" =~ "Darwin" ]]; then
    DISTRO=node-v${VERSION}-darwin-x64
  else
    DISTRO=node-v${VERSION}-linux-x64
  fi
}

main ()
{
  detect_os
  detect_version

  rm -rf /usr/local/bin/node /usr/bin/node /usr/local/bin/npm /usr/bin/npm /tmp/node-*

  FILE=${DISTRO}.tar.gz

  cd /tmp

  curl -O http://nodejs.org/dist/v${VERSION}/$FILE
  tar -zxfv $FILE
  mkdir -p /usr/local/bin/

  ln -s /tmp/$DISTRO/bin/node /usr/local/bin/node
  ln -s /tmp/$DISTRO/bin/npm /usr/local/bin/npm

  rm -rf /usr/local/lib/node_modules
  rm $FILE

  npm config set prefix /usr/local
  node --version
}

main
