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
