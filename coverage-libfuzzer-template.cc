#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

extern "C" int LLVMFuzzerInitialize(int *argc, char ***argv) __attribute__((weak));
extern "C" int LLVMFuzzerTestOneInput(const unsigned char*, size_t);

/*
// basically insert your libfuzzer testcase in here
#include "libfoo/foo.h"
extern "C" int LLVMFuzzerTestOneInput(const unsigned char *data, size_t size) {

  // do stuff

  return 0;
}
// do not forget LLVMFuzzerInitialize() if you use it!
*/

int main(int argc, char **argv) {

  if (LLVMFuzzerInitialize)
    LLVMFuzzerInitialize(&argc, &argv);

  for (int i = 1; i < argc; i++) {

    fprintf(stderr, "Running: %s (%d/%d)\n", argv[i], i, argc - 1);
    FILE *f = fopen(argv[i], "r");
    if (f) {

      fseek(f, 0, SEEK_END);
      size_t len = ftell(f);
      fseek(f, 0, SEEK_SET);
      unsigned char *buf = (unsigned char *)malloc(len);

      if (buf) {

        size_t n_read = fread(buf, 1, len, f);
        fclose(f);
        if (n_read > 0)
          LLVMFuzzerTestOneInput(buf, len);
        free(buf);

      }

    }

  }

  fprintf(stderr, "Done.\n");
  return 0;

}
