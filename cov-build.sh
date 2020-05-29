#!/bin/bash
test -z "$1" -o "$1" = -h && {
  echo "Syntax: $0 <cmd>"
  echo "Example: $0 ./configure --disable-shared"
  echo "sets the appropriate settings for a lcov coverage build for configure/make"
  exit 1
}
export CC=gcc
export CXX=g++
export CFLAGS="-fprofile-arcs -ftest-coverage"
export CXXFLAGS="$CFLAGS"
export CPPFLAGS="$CFLAGS"
export LDFLAGS="-lgcov --coverage"
$*
