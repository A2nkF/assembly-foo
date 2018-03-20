global start

section .text
start:

askForString:
  push    dword msg2.len ; pushes the lenght of the message on the stack
  push    dword msg2     ; pushes the message itself on the stack
  push    dword 1
  mov     eax, 4
  sub     esp, 4
  int     0x80          ; calls interrupt handler for syscalls with eax as parameter
  add     esp, 16

readString:
  and     esp, -16      ; Make sure stack is 16 byte aligned at program start
                        ;     not necessary in this example since we don't call
                        ;     external functions that conform to the OS/X 32-bit ABI

  push    dword 10      ; Read 10 characters
  push    dword STRING  ; Input buffer
  push    dword 0       ; Standard input = FD 0
  mov     eax, 3        ; syscall sys_read
  sub     esp, 4        ; Extra 4 bytes on stack needed by int 0x80
  int     0x80
  add     esp, 16       ; Restore stack


writeToFile:
  mov eax, 4
  ;push dword msg.len
  push dword STRING
  push dword ebx
  sub esp, 4
  int 0x80
  add esp, 16
Exit:
  mov     eax, 1
  push    0
  sub     esp, 12
  int     0x80

section .bss
  INPUT: resd 100


section .data
  msg2: db  "String: ",0x0
  .len:   equ $ - msg2
