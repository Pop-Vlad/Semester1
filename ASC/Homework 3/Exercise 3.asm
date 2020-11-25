; (a*a+b/c-1)/(b+c)+d-x; a-word; b-byte; c-word; d-doubleword; x-qword
; Unsigned representation

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 14
    b db 29
    c dw 2
    d dd 102
    x dq 16
    
    
segment code use32 class=code
    start:
        
        xor eax, eax  ; eax = 0
        mov ax, [a]   ; ax = a
        mul word [a]  ; dx:ax = a*a 
        mov cx, dx
        mov bx, ax    ; cx:bx = a*a
        
        mov eax, 0    ; eax = 0
        mov al, [b]   ; al = b, ax = b
        mov dx, 0     ; dx:ax = b
        div word [c]  ; ax = b/c
        
        add ax, bx
        adc cx, 0     ; cx:ax = a*a + b/c
        sub ax, 1
        sbb cx, 0     ; cx:ax = a*a + b/c - 1
        mov dx, cx    ; dx:ax = a*a + b/c - 1
        
        mov ebx, 0    ; ebx = 0
        mov bl, [b]   ; bl = b, bx = b
        add bx, [c]   ; bx = b + c
        
        div bx        ; ax = (a*a + b/c - 1)/(b + c)
        
        mov edx, 0    ; edx = 0
        add eax, [d]  
        adc edx, 0    ; edx:eax = (a*a + b/c - 1)/(b + c) + d
        
        sub eax, [x]
        sbb edx, [x+2]; edx:eax = (a*a + b/c - 1)/(b + c) + d - x
        
        push    dword 0
        call    [exit]