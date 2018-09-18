; file: first.asm
; Ask for two ints as input and print sum

; Compile with:
;   nasm -f coff first.asm
;   gcc -o first first.o driver.c asm_io.o

%include "asm_io.inc"

;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
prompt1 db    "Enter a number: ", 0
prompt2 db    "Enter another number: ", 0
outmsg1 db    "You entered ", 0
outmsg2 db    " and ", 0
outmsg3 db    ", the of these is ", 0

;
; unititialized data is put into the .bss segment
;
segment .bss
;
; These labels refer to doule words used to store the inputs
;
input1    resd 1
input2    resd 1

;
; code is put in the .text segment
;
segment .text
    global asm_main
asm_main:
    enter    0,0    ; setup routine
    pusha

    mov     eax, prompt1    ; print out prompt
    call    print_string

    call    read_int
    mov     [input1], eax   ; store into input1

    mov     eax, prompt2
    call    print_string

    call    read_int
    mov     [input2], eax

    mov     eax, [input1]
    add     eax, [input2]
    mov     ebx, eax

    dump_regs   1
    dump_mem    2, outmsg1, 1
;
; next print out result message as series of steps
;
    mov     eax, outmsg1
    call    print_string      ; print out first message
    mov     eax, [input1]
    call    print_int         ; print out input1
    mov     eax, outmsg2
    call    print_string      ; print out second message
    mov     eax, [input2]
    call    print_int         ; print out input2
    mov     eax, outmsg3
    call    print_string      ; print out third message
    mov     eax, ebx
    call    print_int         ; print out sum (ebx)
    call    print_nl          ; print new-line

    popa
    mov     eax, 0            ; return back to C
    leave
    ret
