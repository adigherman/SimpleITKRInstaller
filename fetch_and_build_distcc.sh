#!/bin/bash -x

if [ -d "${DISTCC_SRC}" ] ; then

  cd ${DISTCC_SRC} &&
  [ -d distcc ] || (
  ##git clone https://github.com/distcc/distcc &&
  git clone https://github.com/afbjorklund/distcc &&
  cd distcc &&
  git checkout localslots &&
  ./autogen.sh &&
  ./configure --disable-pump-mode --prefix=/usr/local/distcc&&
  make )
else
    echo "Missing ${DISTCC_SRC}"
    exit 1
fi
