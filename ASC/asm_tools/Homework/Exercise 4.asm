
; [d-2*(a-b)+b*c]/2

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 91
    b db 73
    c db 3
    d dw 266

segment code use32 class=code
    start:
        xor eax, eax ;eax=0
        xor ebx, ebx ;ebx=0
        mov al, 2    ;al=2
        mov bl, [a]  ;bl=a
        sub bl, [b]  ;bl=a-b
        mul bl       ;ax=2*(a-b)
        mov bx, [d]  ;bx=d
        sub bx, ax   ;bx=d-2*(a-b)
        mov al, [b]  ;al=b
        mul byte [c] ;ax=b*c
        add ax, bx   ;ax=b*c+d-2*(a-b)=d-2*(a-b)+b*c
        mov bl, 2    ;bl=2
        div bl       ;al=ax/2, ah=ax%2
    
        push    dword 0
        call    [exit]