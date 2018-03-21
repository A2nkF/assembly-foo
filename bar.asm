global start

section .text
start:

askForPath:
  push    dword msg1.len  ; pushes the lenght of the message on the stack
  push    dword msg1      ; pushes the message itself on the stack
  push    dword 0x1       ; stdout
  mov     eax, 0x4        ; sys_write
  sub     esp, 0x4        ; Extra 4 bytes on stack needed by int 0x80
  int     0x80            ; calls interrupt handler for syscalls with eax as parameter
  add     esp, 0x10

readPath:
  and     esp, -0x10      ; Make sure stack is 16 byte aligned at program start
                          ;     not necessary in this example since we don't call
                          ;     external functions that conform to the OS/X 32-bit ABI

  push    dword 0x64      ; Read 100 characters
  push    dword PATH      ; Input buffer
  push    dword 0x0       ; stdin
  int     0x80
  add     esp, 0x10

createFile:
  mov     eax, 0x5        ; sys_open
  push    dword 0x01B6    ; set Permissions to -rw-r--r-- (it could be "0o666" too )
  push    dword 0x0202    ; create File
  push    dword PATH      ; Path
  sub     esp, 0x4        ; Extra 4 bytes on stack needed by int 0x80
  int     0x80
  add     esp,0x10

askForString:
  push    dword msg2.len  ; pushes the lenght of the message on the stack
  push    dword msg2      ; pushes the message itself on the stack
  push    dword 0x1       ; stdout
  mov     eax, 0x4        ; sys_write
  sub     esp, 0x4
  int     0x80            ; calls interrupt handler for syscalls with eax as parameter
  add     esp, 0x10

readString:
  and     esp, -0x10      ; Make sure stack is 16 byte aligned at program start
                          ;     not necessary in this example since we don't call
                          ;     external functions that conform to the OS/X 32-bit ABI

  push    dword 0x64      ; Read 100 characters
  push    dword STRING    ; Input buffer
  push    dword 0x0       ; stdin
  mov     eax, 0x3        ; sys_read
  sub     esp, 0x4        ; Extra 4 bytes on stack needed by int 0x80
  int     0x80
  add     esp, 0x10       ; Restore stack

openFile:
  mov     eax, 0x5           ; sys_open
  push    dword 0x0          ; Mode = 0
  push    dword 0x2          ; Read/Write flag
  push    dword PATH         ; Path
  sub     esp, 0x4           ; Extra 4 bytes on stack needed by int 0x80
  int     0x80
  add     esp, 0x10
  mov     ebx, eax

writeToFile:
  mov     eax, 0x4           ; sys_open
  push    dword 0x64         ; read 100 characters
  push    dword STRING       ; string to read from
  push    dword ebx          ; dunno
  sub     esp, 0x4           ; Extra 4 bytes on stack needed by int 0x80
  int     0x80
  add     esp, 0x10

printMessage:
  push    dword msg3.len     ; pushes the lenght of the message on the stack
  push    dword msg3         ; pushes the message itself on the stack
  push    dword 0x1
  mov     eax, 0x4        ; sys_write
  sub     esp, 0x4
  int     0x80            ; calls interrupt handler for syscalls with eax as parameter
  add     esp, 0x10

Exit:
  mov     eax, 1
  push    0x0
  sub     esp, 4
  int     0x80
  add     esp, 0xc

section .bss              ; defines buffer size
  PATH: resd 0x64
  STRING: resd 0x64


section .data
  msg1: db  "Path to the file you want to create(less than 100 characters): ",0x0
  .len:   equ $ - msg1

  msg2: db  "What should be written to the file(less than 100 characters): ",0x0
  .len:   equ $ - msg2

  msg3: db  "DONE.",0x0a
  .len:   equ $ - msg3
