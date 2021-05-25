#!/bin/sh
VER=`echo $CXX|sed 's/clang++//'
llvm-cov$VER gcov $*
