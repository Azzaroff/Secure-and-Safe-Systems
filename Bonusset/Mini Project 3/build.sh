#!/bin/sh
../../Problemset\ 3/Problem\ 1/testgen/testgen vectors_test.ts
gnatmake -I./ vectors_test.adb
./vectors_test
