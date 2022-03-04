# Compiler settings
#
ASM_COMPILER = nasm
C_COMPILER = gcc
ASM_FLAGS = -f elf32
C_FLAGS = -m32
DEBUG_FLAGS = -g -F stabs

# Files
C_FILE := $(wildcard *.c)
C_OBJ = $(C_FILE:.c=.o)
ASM_FILE := $(wildcard *.asm)
ASM_OBJ = $(ASM_FILE:.asm=.o)
OUTFILE = test


# Compilation and execution

all : compile exec

compile : $(C_OBJ) $(ASM_OBJ)
	@ echo -n "Compiling $(C_OBJ) $(ASM_OBJ): " 
	@ $(C_COMPILER) $(C_FLAGS) $^ -o $(OUTFILE) $(DEBUG_FLAGS)
	@ printf "\033[32mdone\033[0m\n"
	@ rm *.o 

$(C_OBJ) : $(C_FILE)
	@ echo -n "Compiling $(C_FILE): "
	@ $(C_COMPILER) $(C_FLAGS) -c $^ -o $@ $(DEBUG_FLAGS)
	@ printf "\033[32mdone\033[0m\n"

$(ASM_OBJ) : $(ASM_FILE)
	@ echo -n "Compiling $(ASM_FILE): "
	@ $(ASM_COMPILER) $(ASM_FLAGS) $^ -o $@ $(DEBUG_FLAGS)
	@ printf "\033[32mdone\033[0m\n"	

exec : $(OUTFILE)
	@ echo ""
	@ ./$^

clean:
	rm test
