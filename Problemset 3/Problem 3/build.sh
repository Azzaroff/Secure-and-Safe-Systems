#!/bin/sh
../Problem\ 1/testgen/testgen coffee_machine_test.ts
gnatmake -I./ coffee_machine_test.adb
./coffee_machine_test
