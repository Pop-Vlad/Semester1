
; (c+b+b)-(c+a+d)

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 298
    b dw 443
    c dw 2349
    d dw 342

segment code use32 class=code
    start:
        xor eax, eax ; eax=0
        xor ebx, ebx ; ebx=0
        mov ax, [c]  ; ax=c
        add ax, [b]  ; ax=c+b
        add ax, [b]  ; ax=c+b+b
        mov bx, [c]  ; bx=c
        add bx, [a]  ; bx=c+a
        add bx, [d]  ; bx=c+a+d
        sub ax, bx   ; ax=(c+b+b)-(c+a+d)
    
        push    dword 0
        call    [exit]