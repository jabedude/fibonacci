all: fibonacci
fibonacci: fib.o
	gcc -s -o fibonacci fib.o

fib.o: fibonacci.s
	nasm -felf64 fibonacci.s -o fib.o

clean:
	rm -f *.o fibonacci
