#!/bin/sh
# cov.cc -> libfuzzer target + coverage-libfuzzer-template.cc
# libfoo -> the target library to fuzz
# LIBS -> more libs needed to compile the target, e.g. -lm -lz

test -z "$1" -o "$1" = "-h" && {
  echo "Syntax: $0 [compile commands with '-o output']"
  echo
  echo Compiles a fuzzing harness for coverage gathering
  echo
  echo Example: $0 fuzz.cc .libs/libfoo.a -lz -I. -Iinclude
  exit 1
}

LOCATION=`command -v $0|sed 's/[a-z.-]*$//'`

test -z "$CXX" && CXX=clang++
export CXX
# for clang++:
echo if this fails, perform the necessary changes by hand:
echo $CXX -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -fprofile-arcs -ftest-coverage --coverage -I. -Iinclude/ -o cov $INCLUDES $LIBS $LOCATION/coverage-libfuzzer-template.cc $*
echo
$CXX -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -fprofile-arcs -ftest-coverage --coverage -I. -Iinclude/ -o cov $INCLUDES $LIBS $LOCATION/coverage-libfuzzer-template.cc $*
# for g++:
#g++ -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -fprofile-arcs -ftest-coverage -lgcov --coverage -I. -Iinclude/ -o cov cov.cc $INCLUDES $LIBS
