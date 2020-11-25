
;   10/4

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b db 4

segment code use32 class=code
    start:
        xor eax, eax ; eax=0
        mov al, [a]  ; al=10
        div byte [b]  ; al=10/4
    
        push    dword 0
        call    [exit]