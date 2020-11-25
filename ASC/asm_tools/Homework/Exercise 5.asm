
; a*(b+c)+34

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 7
    b dw 3
    c dw 5

segment code use32 class=code
    start:
        xor eax, eax ; eax=0
        xor ebx, ebx ; ebx=0
        mov ax, [a]  ; ax=a
        mov bx, [b]  ; bx=b
        add bx, [c]  ; bx=b+c
        mul word bx  ; eax=a*(b+c)
        add eax, 34  ; eax=a*(b+c)+34
        
        push    dword 0
        call    [exit]