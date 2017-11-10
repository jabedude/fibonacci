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

./fibonacci 2
if [ $? -eq 0 ]; then
        echo " + Fib returns 0 w/ no command args"
else
        echo " - FAIL: FIB DOES NOT RETURN 0 w/ ARGS"
fi

ret=$(./fibonacci 100)
if [ $ret == "0x0000000000000000000000000000000000000000000000000000000000000000000000000000001333db76a7c594bfc3" ]; then
        echo " + Fib works w/ 100"
else
        echo " - FAIL FIB DOES NOT WORK W/ 100"
fi

ret=$(./fibonacci 200)
if [ $ret == "0x0000000000000000000000000000000000000000000000000000000000000338864a5c1caeb07d0ef067cb83df17e395" ]; then
        echo " + Fib works w/ 200"
else
        echo " - FAIL FIB DOES NOT WORK W/ 200"
fi

ret=$(./fibonacci 300)
if [ $ret == "0x000000000000000000000000000000000000000000008a4ba39e1a1741497bbbef460a25486ee575f510e921b33e2e10" ]; then
        echo " + Fib works w/ 300"
else
        echo " - FAIL FIB DOES NOT WORK W/ 300"
fi

ret=$(./fibonacci 400)
if [ $ret == "0x0000000000000000000000000017322a2cfd320a23266116c4c2c95b3feea3e57fa3d9dfe8b8591e1d72120f26c6fadb" ]; then
        echo " + Fib works w/ 400"
else
        echo " - FAIL FIB DOES NOT WORK W/ 400"
fi

ret=$(./fibonacci 500)
if [ $ret == "0x0000000003e3fe615f5f0dad9359c2b1e46ffa400471515e14b7801fd988dea30773c33170414e4e1e2278b212c93d2d" ]; then
        echo " + Fib works w/ 500"
else
        echo " - FAIL FIB DOES NOT WORK W/ 500"
fi
