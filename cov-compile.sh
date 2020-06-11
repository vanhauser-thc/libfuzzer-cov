#!/bin/sh
# cov.cc -> libfuzzer target + coverage-libfuzzer-template.cc
# libfoo -> the target library to fuzz
# LIBS -> more libs needed to compile the target, e.g. -lm -lz
echo this file needs to be modified by hand. read the header.
exit 1
# for clang++:
clang++ -fprofile-arcs -ftest-coverage --coverage -Iinclude/ -o cov cov.cc libfoo.a $LIBS
# for g++:
#g++ -fprofile-arcs -ftest-coverage -Iinclude/ -o cov cov.cc libfoo.a $LIBS -lgcov --coverage
