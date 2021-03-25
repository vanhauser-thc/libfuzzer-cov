# coverage for libfuzzer

libfuzzer is good but checking the coverage the tools are not as advanced as
what gcc has available.

hence these tools to have gcc coverage on libfuzzer fuzzing targets

NOTE: by default clang/clang++ is used. if you want to use gcc/g++ instead
then specify the -g option in cov-build.sh and cov-generate.sh, and edit
cov-compile.sh to use the g++ line instead.

# how-to

## step 1: build the target

build the target library for coverage with `cov-build.sh`.
usually enough is a 
```
$ cov-build.sh ./configure --disable-shared
```

## step 2: build the coverage tool

same as the fuzz.cc target to fuzz, we need to have a small to to get the
coverage. this is easy: simply merge your `fuzz.cc` with
`coverage-libfuzzer-template.cc` and name it `cov.cc`.

then *edit(!)* `cov-compile.sh` and set the correct `libTARGET.a` and `$LIBS`
and `$INCLUDE` this needs to compile. Basically the same you needed to compile
your fuzzing harness.

afterwards compile `cov.cc` to the `cov` executable with the `cov-compile.sh` command.

## step 3: gather the coverage

simply run the `cov-generate.sh` script with the libfuzzer queue directory and
the compiled `cov` binary (you must still be in the source top directory of the
for coverage compiled target):

```
$ cov-generate.sh ../libTARGET/queue ./cov
```

## step 4: view the coverage

open a webbrowser for `./report/index.html`
