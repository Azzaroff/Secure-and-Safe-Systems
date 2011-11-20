#!/bin/sh
../Problem\ 1/testgen/testgen mark_graph_test.ts
gnatmake -I../MiniProject\ 4 mark_graph_test.adb
./mark_graph_test
