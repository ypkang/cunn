#!/bin/bash

set -ex

function sudo_up {
  if [ "$EUID" != 0 ]; then
    sudo -E "$@" "$@"
    exit $?
  fi
}

LIBDIR=/usr/local/torch/install/lib/lua/5.1

sudo_up

cp ${LIBDIR}/libTHCUNN.so ${LIBDIR}/libTHCUNN.so.original
cp ${LIBDIR}/libcunn.so ${LIBDIR}/libcunn.so.original

luarocks make rocks/cunn-scm-1.rockspec

cp ${LIBDIR}/libTHCUNN.so ${LIBDIR}/libTHCUNN.so.profile
cp ${LIBDIR}/libcunn.so ${LIBDIR}/libcunn.so.profile

ln -s ${LIBDIR}/libTHCUNN.so.original ${LIBDIR}/libTHCUNN.so
ln -s ${LIBDIR}/libcunn.so.original ${LIBDIR}/libcunn.so
