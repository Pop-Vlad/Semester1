; a - byte, b - word, c - double word, d - qword - Unsigned representation
; (c-b+a)-(d+a)

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b dw 50
    c dd 212
    d dq 46
    
    
segment code use32 class=code
    start:
        
        xor eax, eax  ; eax = 0
        xor ebx, ebx  ; ebx = 0
        xor ecx, ecx  ; ecx = 0
        xor edx, edx  ; edx = 0
        
        mov eax, [c]  ; eax = c
        mov bx, [b]   ; bx = b
        sub eax, ebx  ; eax = c - b
        
        mov dl, [a]   ; dl = a
        add eax, edx  ; eax = c - b + a
        mov ebx, eax  ; ebx = c - b + a
        
        mov eax, [d]
        mov edx, [d+2]; edx:eax = d
        mov cl, [a]   ; cl = a
        add eax, ecx
        adc edx, 0    ; edx:eax = d + a
        
        xor ecx, ecx  ; ecx = 0
        sub ebx, eax
        sbb ecx, edx  ; ecx:ebx = (c - b + a) - (d + a)
        
        push    dword 0
        call    [exit]