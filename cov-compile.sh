#!/bin/sh
# cov.cc -> libfuzzer target + coverage-libfuzzer-template.cc
# libfoo -> the target library to fuzz
# LIBS -> more libs needed to compile the target, e.g. -lm -lz

LOCATION=`command -v $0|sed 's/[a-z.-]*$//'`

test -z "$CXX" && CXX=clang++
export CXX
# for clang++:
echo if this fails, perform the necessary changes by hand:
echo $CXX -fprofile-arcs -ftest-coverage --coverage -I. -Iinclude/ -o cov $INCLUDES $LIBS $LOCATION/coverage-libfuzzer-template.cc $*
$CXX -fprofile-arcs -ftest-coverage --coverage -I. -Iinclude/ -o cov $INCLUDES $LIBS $LOCATION/coverage-libfuzzer-template.cc $*
# for g++:
#g++ -fprofile-arcs -ftest-coverage -lgcov --coverage -I. -Iinclude/ -o cov cov.cc $INCLUDES $LIBS
