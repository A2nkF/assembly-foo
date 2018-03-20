global start

section .text
start:

  mov  eax,4		    ;sys_wite
  mov  ebx,1		    ;To stdout
  mov  ecx,msg		  ;'Input some data: '
  mov  edx,msg.len
  int  80h		      ;Call kernel

  mov  eax ,3       ; sys_read
  mov  ebx, 0       ; from stdin
  mov  ecx, inp_buf
  mov  edx, 24
  int  80h

  push eax

  mov  eax, 4
  mov  ebx, 1
  mov  ecx, msg2
  mov  edx, msg2.siz
  int  80h

  mov  eax,4
  mov  ebx,1
  mov  ecx, inp_buf
  pop  edx        ; get input count back
  int  80h

section .bss

inp_buf resb 256

section .data

msg: db "Input some data: ", 0x0a
.len: equ $ - msg

msg2: db "You entered: ", 0x0a
.siz: equ $ - msg2
