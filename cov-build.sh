#!/bin/bash

test -z "$1" -o "$1" = "-h" && {
  echo "Syntax: $0 [-c|-g] <command> [options]"
  echo "Sets build options for coverage instrumentation with gcov/lcov."
  echo "Set CC/CXX environment variables if you do not want clang/clang++."
  echo "Specify the -c parameter if you want to use clang/clang++ (default)."
  echo "Specify the -g parameter if you want to use gcc/g++ instead."
  echo "Example: $0 ./configure --disable-shared"
  exit 1
}

CLANG=yes
test "$1" = "-g" && { CLANG= ; shift ; }
test "$1" = "-c" && { CLANG=yes ; shift ; }
test "$1" = "-g" && { CLANG= ; shift ; }

test -z "$CC" -a -z "$CLANG" && CC=gcc
test -z "$CXX" -a -z "$CLANG" && CXX=g++
test -z "$CC" -a -n "$CLANG" && CC=clang
test -z "$CXX" -a -n "$CLANG" && CXX=clang++

test -n "$CC" && export CC
test -n "$CXX" && export CXX
export CFLAGS="-fprofile-arcs -ftest-coverage"
export CXXFLAGS="$CFLAGS"
export CPPFLAGS="$CFLAGS"
test -z "$CLANG" && export LDFLAGS="-lgcov --coverage"
test -n "$CLANG" && export LDFLAGS="--coverage"

$*
