% : %.asm
	@ echo -n "Compilation: " 
	 nasm -f elf32 -o $@.o $< -ggdb -F stabs
	 gcc -m32 main.c -c -o main.o -ggdb -F stabs
	 gcc -m32 main.o $@.o -o test -O0 -ggdb -F stabs
	@ echo "done"
	@ ./test

