; (a*a+b/c-1)/(b+c)+d-x; a-word; b-byte; c-word; d-doubleword; x-qword
; Signed representation

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
        imul word [a] ; dx:ax = a*a 
        mov cx, dx
        mov bx, ax    ; cx:bx = a*a
        
        mov eax, 0    ; eax = 0
        mov al, [b]   ; al = b
        cbw           ; ax = b
        cwd           ; dx:ax = b
        idiv word [c] ; ax = b/c
        
        add bx, ax
        adc cx, 0     ; cx:bx = a*a + b/c
        sub bx, 1     
        sbb cx, 0     ; cx:bx = a*a + b/c - 1
        
        mov al, [b]   ; al = b,
        cbw           ; ax = b
        add ax, [c]   ; ax = b + c
        
        mov dx, cx    ; dx:bx = a*a + b/c - 1
        mov cx, ax    ; cx = b + c
        mov ax, bx    ; dx:ax = a*a + b/c - 1
        
        idiv cx       ; ax = (a*a + b/c - 1)/(b + c)
        
        mov edx, 0    ; edx = 0
        add eax, [d]  
        adc edx, 0    ; edx:eax = (a*a + b/c - 1)/(b + c) + d
        
        sub eax, [x]
        sbb edx, [x+2]; edx:eax = (a*a + b/c - 1)/(b + c) + d - x
        
        push    dword 0
        call    [exit]