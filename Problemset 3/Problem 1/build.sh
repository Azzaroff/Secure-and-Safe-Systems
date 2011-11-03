#!/bin/sh
testgen/testgen rgb_test.ts
gnatmake -I../../Problemset\ 2/Problem\ 1/ rgb_test.adb
