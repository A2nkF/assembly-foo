global start


section .text
start:

mov eax, 4      ; write…
mov ebx, 1      ; to the standard output (screen/console)…
mov ecx, prompt ; the information at memory address prompt
mov edx, 19     ; 19 bytes (characters) of that information
int 0x80        ; invoke an interrupt

mov eax, 3      ; read…
mov ebx, 0      ; from the standard input (keyboard/console)…
mov ecx, name   ; storing at memory location name…
mov edx, 23     ; 23 bytes (characters) is ok for my name
int 0x80

mov eax, 4      ; write…
mov ebx, 1      ; to the standard output (screen/console)…
mov ecx, Msg    ; the information at helloMsg…
mov edx, 23     ; 23 bytes (characters) is ok for my name
int 0x80

mov eax, 1      ; sys_exit
mov ebx, 0      ; exit status. 0 means “normal”, while 1 means “error”

section .data
prompt: db "What is your name? ", 0x0a
Msg: dq "Hello ", 0x0a
name: db " "    ; space characters
