global start

section .text ; code goes here
start: ; entry point
    push    dword msg.len ; pushes the lenght of the message on the stack
    push    dword msg ; pushes the message itself on the stack
    push    dword 1
    mov     eax, 4
    sub     esp, 4
    int     0x80 ; calls interrupt handler for syscalls with eax as parameter
    add     esp, 16

    push    dword 0
    mov     eax, 1
    sub     esp, 12
    int     0x80

section .data; inline data goes here

msg:    db      "Hello, world!", 0x0a; string of bytes called "Hello, world"; 0x0a is the code for \n
.len:   equ     $ - msg ; determin the lenght of the string by subtracting
