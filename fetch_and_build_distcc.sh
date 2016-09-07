#!/bin/bash

if [ -d "${DISTCC_SRC}" ] ; then

  cd ${DISTCC_SRC} &&
  [ -d distcc ] || (
  git clone https://github.com/distcc/distcc
  git checkout 3.2
  ./configure
  make )
else
    echo "Missing DISTCC_SRC"
fi
