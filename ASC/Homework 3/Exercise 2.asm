; a - byte, b - word, c - double word, d - qword - Signed representation
; (c-d-a)+(b+b)-(c+a)

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 28
    b dw 82
    c dd 12
    d dq 123
    
    
segment code use32 class=code
    start:
        xor eax, eax   ; eax = 0
        xor edx, edx   ; edx = 0
        xor ebx, ebx   ; ebx= 0
        xor ecx, ecx   ; ecx = 0
        
        mov ebx, [c]   ; ebx = c
        
        mov al, [a]    ; al = a
        cbw            ; ax = a
        cwd            ; dx:ax = a
        push dx
        push ax
        pop eax        ; eax = a
        
        sub ebx, eax   ; ebx = c - a
        sbb ecx, 0     ; ecx:ebx = c - a
        
        sub ebx, [d]
        sbb ecx, [d+2] ; ecx:ebx = c - d - a
        
        xor eax, eax   ; eax = 0
        mov ax, [b]    ; ax = b
        cwd            ; dx:ax = b
        push dx
        push ax
        pop eax        ; eax = b
        
        add eax, eax   ; eax = b + b
        add ebx, eax
        adc ecx, 0     ; ecx:ebx = (c - d - a) + (b + b)
        
        mov al, [a]    ; al = a
        cbw            ; ax = a
        cwd            ; dx:ax = a
        push dx
        push ax
        pop eax        ; eax = a
        
        add eax, [c]   ; eax = a + c
        sbb ecx, 0     ; subtreact carry from minuend in case of overflow
        sub ebx, eax
        sbb ecx, 0     ; ecx:ebx = (c - d - a) + (b + b) - (c + a)
        
        push    dword 0
        call    [exit]