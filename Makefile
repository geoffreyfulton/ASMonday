#
# Linux makefile
#

AS			:= nasm
ASFLAGS		:= -f elf
CFLAGS 		:= -m32
LDFLAGS 	:= -m32
CC 			:= gcc
CXX 		:= g++
CXXFLAGS	:= -m32
TARGETS 	:= hello_world addusrnums
DEP 		:= driver.o asm_io.o


.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $<

all: $(TARGETS)

hello_world: $(DEP)

addusrnums: $(DEP)

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

hello_world.o: asm_io.inc

clean:
	rm -f *.o $(TARGETS)
