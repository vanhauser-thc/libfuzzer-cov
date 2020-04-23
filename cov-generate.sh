#!/bin/sh
test -z "$1" -o -z "$2" -o '!' -d "$1" -o '!' -x "$2" && { 
  echo "Syntax: $0 queue-dir cmd"
  echo "this generates the coverage information."
  echo "must be run in the top source code directory"
  echo "qeueu-dir - queue directory of libfuzzer"
  echo "cmd - the cov command compiled with cov-compile.sh"
  exit 1
}
mkdir report 2> /dev/null
lcov --no-checksum --zerocounters --directory .
lcov --no-checksum --capture --initial --directory . --output-file report/trace.lcov_base
"$2" "$1"/*
lcov --no-checksum --capture --directory . --output-file report/trace.lcov_info
lcov --no-checksum -a report/trace.lcov_base -a report/trace.lcov_info --output-file report/trace.lcov_tmp
lcov --no-checksum -r report/trace.lcov_tmp /usr/include/\*  --output-file report/trace.lcov_info_final
genhtml --output-directory report report/trace.lcov_info_final
echo
echo Report: `pwd`/report/index.html
