default: native

native:
	if [ ! -d bin/ ]; then mkdir bin/; fi

	as src/main.S -o obj.o
	ld obj.o -o bin/main.elf
	rm obj.o

virtual:
	if [ ! -d bin/ ]; then mkdir bin/; fi

	arm-linux-gnueabi-as src/main.S -o obj.o
	arm-linux-gnueabi-ld obj.o -o bin/main.elf
	rm obj.o

