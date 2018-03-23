global start

section .text             ; code goes here
start:                    ; entry point
    call promptUser
    call readInput
    call printingInput
    call Exit

promptUser:
    push    dword msg.len ; pushes the lenght of the message on the stack
    push    dword msg     ; pushes the message itself on the stack
    push    dword 1
    mov     eax, 4
    sub     esp, 4
    int     0x80          ; calls interrupt handler for syscalls with eax as parameter
    add     esp, 16

readInput:
    and     esp, -16      ; Make sure stack is 16 byte aligned at program start
                          ;     not necessary in this example since we don't call
                          ;     external functions that conform to the OS/X 32-bit ABI

    push    dword 1      ; Read 10 characters
    push    dword INPT    ; Input buffer
    push    dword 0       ; Standard input = FD 0
    mov     eax, 3        ; syscall sys_read
    sub     esp, 4        ; Extra 4 bytes on stack needed by int 0x80
    int     0x80
    add     esp, 16       ; Restore stack

printingInput:
    push    dword 1      ; Print 5 character
    push    dword INPT    ; Output buffer = buffer we read characters into
    push    dword 1       ; Standard output = FD 1
    mov     eax, 4        ; syscall sys_write
    sub     esp, 4        ; Extra 4 bytes on stack needed by int 0x80
    int     0x80
    add     esp, 16       ; Restore stack
    jmp     readInput

Exit:
    push    dword 0       ; Return value from program = 0
    mov     eax, 1        ; syscall sys_exit
    sub     esp, 4        ; Extra 4 bytes on stack needed by int 0x80
    int     0x80


section .bss              ; defines buffer size
    INPT: resd 1


section .data             ; inline data goes here

msg:    db      "Enter Something: ";, 0x0a; string of bytes called "Hello, world"; 0x0a is the code for \n
.len:   equ     $ - msg   ; determin the lenght of the string by subtracting
