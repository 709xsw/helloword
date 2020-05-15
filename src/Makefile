# the c and c++ rules are already setup by default
# the only one that needs changing is the assembler rule, as we use nasm instaead of GNU as.

SOURCES=boot.o main.o

CFLAGS=-nostdlib -nostdinc -fno-builtin -fno-stack-protector
LDFLAGS=-Tlink.ld
ASFLAGS=-felf

all: $(SOURCE) link

clean:
	-rm *.o kernel

link:
	ld $(LDFALGS) -o kernel $(SOURCES)

.s.o:
	nasm $(ASFLAGS) $<
