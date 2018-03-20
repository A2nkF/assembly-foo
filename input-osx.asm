global start

section .text
start:
    and     esp, -16      ; Make sure stack is 16 byte aligned at program start
                          ;     not necessary in this example since we don't call
                          ;     external functions that conform to the OS/X 32-bit ABI

    push    dword 5       ; Read 5 character
    push    dword INPT    ; Input buffer
    push    dword 0       ; Standard input = FD 0
    mov     eax, 3        ; syscall sys_read
    sub     esp, 4        ; Extra 4 bytes on stack needed by int 0x80
    int     0x80
    add     esp, 16       ; Restore stack

    push    dword 5       ; Print 5 character
    push    dword INPT    ; Output buffer = buffer we read characters into
    push    dword 1       ; Standard output = FD 1
    mov     eax, 4        ; syscall sys_write
    sub     esp, 4        ; Extra 4 bytes on stack needed by int 0x80
    int     0x80
    add     esp, 16       ; Restore stack

    push    dword LENGTH  ; Number of characters to write
    push    dword NEWLINE ; Write the data in the NEWLINE string
    push    dword 1       ; Standard output = FD 1
    mov     eax, 4        ; syscall sys_write
    sub     esp, 4        ; Extra 4 bytes on stack needed by int 0x80
    int     0x80
    add     esp, 16       ; Restore stack

    push    dword 0       ; Return value from program = 0
    mov     eax, 1        ; syscall sys_exit
    sub     esp, 4        ; Extra 4 bytes on stack needed by int 0x80
    int     0x80


section .bss
    INPT: resd 5

section .data
    NEWLINE: db 0xa, 0xd
    LENGTH: equ $-NEWLINE
