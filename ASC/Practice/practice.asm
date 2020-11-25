bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
    source dw 10, 45, 32, 20, 100
    len equ ($ - source) // 2
    destination resb len

segment code use32 class = code
start:
    
    mov eax, 11111b
    mov ah, 0
    add ah, 1
    
    push dword 0
    call [exit]