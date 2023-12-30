default: native

native:
	as src/main.S -o src/obj.o
	ld src/obj.o -o src/main.elf
	rm src/obj.o

virtual:
	arm-linux-gnueabi-as src/main.S -o src/obj.o
	arm-linux-gnueabi-ld src/obj.o -o src/main.elf
	rm src/obj.o

