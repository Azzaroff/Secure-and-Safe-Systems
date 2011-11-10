#!/bin/sh
../Problem\ 1/testgen/testgen ./mark_graph_test.ts
gnatmake -I./ mark_graph_test.adb
./mark_graph_test
