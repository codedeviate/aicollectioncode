build:
	as -o exit.o exit.s
	ld -o exit exit.o

build-as:
	as -o as.o as.s
	ld -o as as.o

build-nasm:
	nasm -f elf64 -o nasm.o nasm.s
	ld -o nasm nasm.o

clean:
	rm -f exit.o
	rm -f exit
	rm -f as.o
	rm -f as
	rm -f nasm.o
	rm -f nasm
