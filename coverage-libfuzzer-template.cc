#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

extern "C" int LLVMFuzzerTestOneInput(const unsigned char*, size_t);

/*
// basically insert your libfuzzer testcase in here
#include "libfoo/foo.h"
extern "C" int LLVMFuzzerTestOneInput(const unsigned char *data, size_t size) {

  // do stuff

  return 0;
}
// Do not forget LLVMFuzzerInitialize() if you use it an enable it in main()
*/

int main(int argc, char **argv) {

  // uncomment if your harness uses LLVMFuzzerInitialize()
  //LLVMFuzzerInitialize(NULL, NULL);

  for (int i = 1; i < argc; i++) {

    fprintf(stderr, "Running: %s (%d/%d)\n", argv[i], i, argc - 1);
    FILE *f = fopen(argv[i], "r");
    fseek(f, 0, SEEK_END);
    size_t len = ftell(f);
    fseek(f, 0, SEEK_SET);
    unsigned char *buf = (unsigned char *)malloc(len);
    size_t n_read = fread(buf, 1, len, f);
    fclose(f);
    LLVMFuzzerTestOneInput(buf, len);
    free(buf);

  }

  fprintf(stderr, "Done.\n");
  return 0;

}
