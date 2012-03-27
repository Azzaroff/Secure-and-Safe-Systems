#!/bin/sh
rm *.gcda *.gcov *.gcno *.o vectors_test
../../Problemset\ 3/Problem\ 1/testgen/testgen vectors_test.ts
gnatmake -fprofile-arcs -ftest-coverage -I./ vectors_test.adb
./vectors_test
gcov vectors
