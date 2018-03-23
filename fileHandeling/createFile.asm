global start

section .text
start:

createFile:
  mov     eax, 5      ; Open system call = 5
  push    dword 0666o ; set Permissions to -rw-r--r--   ; 0666o is octal
  push    dword 0202h ; create File   ; 0202h is hexadecimal
  push    dword path  ; Path
  sub     esp, 4      ; Reserved space for system call
  int     0x80
  add     esp,16

Exit:
  mov     eax, 1
  push    0
  sub     esp, 12
  int     0x80


section .bss
INPUT: resd 100
section .data
  path:   db  "/Users/acebot/Stuff/hacktheplanet/binary-hacking/assembly/test/test.txt",0x0
