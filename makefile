all: main.S
	as main.S -o obj.o
	ld obj.o -o main.elf
	rm obj.o

