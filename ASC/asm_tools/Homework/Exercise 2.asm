
; (c-a-d)+(c-b)-a

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 5
    b db 7
    c db 10
    d db 2

segment code use32 class=code
    start:
        xor eax, eax ; eax=0
        xor ebx, ebx ; ebx=0
        mov al, [c]  ; al=c
        sub al, [a]  ; al=c-a
        sub al, [d]  ; al=c-a-d
        mov bl, [c]  ; bl=c
        sub bl, [b]  ; bl=c-b
        add al, bl   ; al=(c-a-d)-(c-b)
        sub al, [a]  ; al=(c-a-d)-(c-b)-a
    
        push    dword 0
        call    [exit]