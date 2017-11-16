PROG = TestTwoNums

CC = gcc 
LD = ld 
NASM = nasm   

LDFLAGS = -melf_i386 
NASMFLAGS = -f elf -F stabs  


OBJS = $(PROG).o 

default: $(PROG)  

$(PROG): $(OBJS)  
        $(LD) $(LDFLAGS) $(OBJS) -o $(PROG)  

$(PROG).o: $(PROG).asm 
        $(NASM) $(NASMFLAGS) $(PROG).asm

clean: 
        rm -rf *.o *~  

cleanall: 
        rm -rf *.o $(PROG) *~
