global start


section .text
start:
askForPath:
  push    dword msg.len  ; pushes the lenght of the message on the stack
  push    dword msg      ; pushes the message itself on the stack
  push    dword 0x1       ; stdout
  mov     eax, 0x4        ; sys_write
  sub     esp, 0x4        ; Extra 4 bytes on stack needed by int 0x80
  int     0x80            ; calls interrupt handler for syscalls with eax as parameter
  add     esp, 0x10

readPath:
  and     esp, -0x10      ; Make sure stack is 16 byte aligned at program start
                          ;     not necessary in this example since we don't call
                          ;     external functions that conform to the OS/X 32-bit ABI

  push    dword 0x1       ; Read 100 characters
  push    dword INPUT     ; Input buffer
  push    dword 0x0       ; stdin
  int     0x80
  add     esp, 0x10

  push    dword 0x1      ; Print 5 character
  push    dword INPUT    ; Output buffer = buffer we read characters into
  push    dword 1       ; Standard output = FD 1
  mov     eax, 4        ; syscall sys_write
  sub     esp, 4        ; Extra 4 bytes on stack needed by int 0x80
  int     0x80
  add     esp, 16       ; Restore stack
  jmp     readPath


Exit:
  push    dword 0x0
  mov     eax, 0x1
  sub     esp, 0x10


section .bss
  INPUT: resd 0x1


section .data

msg:    db  "testing"
.len:   db  $ - msg
