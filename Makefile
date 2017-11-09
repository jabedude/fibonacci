all: fibonacci
fibonacci: fib.o
	gcc -o fibonacci fib.o

fib.o: fibonacci.s
	nasm -felf64 fibonacci.s -o fib.o

debug:
	nasm -g -felf64 fibonacci.s -o fib.o
debug: fibonacci

clean:
	rm -f *.o fibonacci
