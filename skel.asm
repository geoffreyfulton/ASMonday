%include "asm_io.inc"


segment .data
;
; initialized data is put in the data segment
;
hello_world_text db "Hello, world!", 0

segment .bss
;
; uninitialized data is put in the bss segment
;

segment .text
    global asm_main
asm_main:
    enter   0,0         ; setup routine
    pusha

    mov     eax, [hello_world_text]
    call    print_string

;
; code is put in the text segment
;

    popa
    mov     eax, 0      ; return to C
    leave
    ret
