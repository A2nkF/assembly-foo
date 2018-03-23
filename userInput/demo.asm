global start

section .data
    str: times 100 db 0 ; Allocate buffer of 100 bytes
    lf:  db 10          ; LF for full str-buffer

section .bss
    e1_len resd 1
    dummy resd 1

section .text

start:
    mov eax, 3          ; Read user input into str
    mov ebx, 0          ; |
    mov ecx, str        ; | <- destination
    mov edx, 100        ; | <- length
    int 80h             ; \

    mov [e1_len],eax    ; Store number of inputted bytes
    cmp eax, edx        ; all bytes read?
    jb .2               ; yes: ok
    mov bl,[ecx+eax-1]  ; BL = last byte in buffer
    cmp bl,10           ; LF in buffer?
    je .2               ; yes: ok
    inc DWORD [e1_len]  ; no: length++ (include 'lf')

    .1:                 ; Loop
    mov eax,3           ; SYS_READ
    mov ebx, 0          ; EBX=0: STDIN
    mov ecx, dummy      ; pointer to a temporary buffer
    mov edx, 1          ; read one byte
    int 0x80            ; syscall
    test eax, eax       ; EOF?
    jz .2               ; yes: ok
    mov al,[dummy]      ; AL = character
    cmp al, 10          ; character = LF ?
    jne .1              ; no -> next character
    .2:                 ; end of loop

    mov eax, 4          ; Print 100 bytes starting from str
    mov ebx, 1          ; |
    mov ecx, str        ; | <- source
    mov edx, [e1_len]   ; | <- length
    int 80h             ; \

    mov eax, 1          ; Return
    mov ebx, 0          ; | <- return code
    int 80h             ; \
