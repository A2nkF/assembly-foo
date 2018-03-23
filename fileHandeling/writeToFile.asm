global start

section .text

start:
openFile:
mov eax, 5       ; Open system call = 5
push dword 0     ; Mode = 0
push dword 2     ; Read/Write flag
push dword path  ; Path
sub esp, 4       ; Reserved space for system call
int 0x80
add esp, 16
mov ebx, eax

writeToFile:
mov eax, 4
push dword msg.len
push dword msg
push dword ebx
sub esp, 4
int 0x80
add esp, 16

Exit:
mov eax, 1
push 0
sub esp, 12
int 0x80

section .data
  path:   db  "/Users/acebot/Stuff/hacktheplanet/binary-hacking/assembly/test/test.txt",0x0

  msg: db  "hacktheplanet",0x0
  .len:   equ $ - msg
