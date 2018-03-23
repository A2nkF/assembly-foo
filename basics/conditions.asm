global start

section .text
start:
  mov     eax, 10
  mov     ebx, 15
  sub     ebx, eax
  mov     ecx, 5
  cmp     ecx, 5
  je      skip
  push    dword mesg2.lenght  ; pushes the lenght of the message on the stack
  push    dword mesg2         ; pushes the message itself on the stack         ; "We did not jump :/"
  jmp     end

skip:
  push    dword mesg1.len     ; pushes the lenght of the message on the stack
  push    dword mesg1         ; pushes the message itself on the stack        ; "We did jump \o/"
  jmp     end

end:
  push    dword 1
  mov     eax, 4              ; subs 4 from the stack pointer
  sub     esp, 4
  int     0x80                ; calls interrupt handler for syscalls with eax as parameter
  add     esp, 16             ; adds 16 to the stack pointer
  push    dword 0
  mov     eax, 1
  sub     esp, 12             ; resets stack pointer( -4 + 16 = 12 )
  int     0x80


section .data

mesg1:  db    "We did jump \o/", 0x0a
.len:   equ   $ - mesg1

mesg2:  db    "We did not jump :/", 0x0a
.lenght equ   $ - mesg2
