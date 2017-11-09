#!/bin/bash

echo "fibonacci program test runner --------------------"

make clean
make

dir=$(ls)
if [[ $dir == *"fibonacci"* ]]; then
        echo "Makefile default target is good"
else
        echo "Makefile error"
fi

./fibonacci
if [ $? -eq 1 ]; then
        echo " + Fib returns error w/ no command args"
else
        echo " - FAIL: FIB DOES NOT ERROR W/ NO ARGS"
fi

./fibonacci 0
if [ $? -eq 0 ]; then
        echo " + Fib returns 0 w/ no command args"
else
        echo " - FAIL: FIB DOES NOT RETURN 0 w/ ARGS"
fi

ret=$(./fibonacci 20)
if [[ ret == *"20"* ]]; then
        echo " + Fib converts 20 correctly"
else
        echo " - FAIL: FIB DOES NOT CONVERT 20"
fi
