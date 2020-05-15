;
; boot.s -- kernel start location. also defines multiboot header.
; Based on Bran's kernel development tutorial file start.asm
;

MBOOT_PAGE_ALIGN	equ 1<<0    ; Load kernel and modules on a page boundary
MBOOT_MEM_INFO		equ 1<<1 	; Provide your kernel with memory info 
MBOOT_HEADER_MAGIC	equ 0x1BADB002	; mULTIBOOT mAGIC VALUE
; Note: We do not use MBOOT_AOUT_KLUDGE. It means that GRUB does not pass us a symbo table 
MBOOT_HEADER_FLAGS	equ MBOOT_PAGE_ALIGN | MBOOT_MEM_INFO
MBOOT_CHECKSUM		equ -(MBOOT_HEADER_MAGIC + MBOOT_HEADER_FLAGS)


[BITS 32]						; aLL instructions should be 32-bit.

[GLOBAL mboot]					; Make 'mboot' accessible from c.
[EXTERN code]					; Start of th '.text' section.
[EXTERN bss]					; Start of th '.bss' section.
[EXTERN end]					;  End of the last loadable section.

mboot:
	dd MBOOT_HEADER_MAGIC   	; GRUB will search for this value on each
	dd MBOOT_HEADER_FLAGS		; 4-byte boundary in your kernel file
	dd MBOOT_CHECKSUM			; To ensure that the above values are correct

	dd mboot					; Location of this descriptor
	dd code 					; Start of kernel '.text' (code) section.
	dd bss						; End of kernel.
	dd end 						; kernel entry point (initial EIP).
	dd start

[GLOBAL start]				
[EXTERN main]

start:
	push ebx

	; Execute the kernel:
	cli
	call main 
	jmp $

