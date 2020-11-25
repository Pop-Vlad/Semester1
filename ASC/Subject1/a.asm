bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

%include "b.asm"

segment data use32 class=data
    sir dd 1234A678h, 12345678h, 1AC3B47Dh, 0FEDC9876h, 0
    ranks resb 100
    sum dd 0
    ranks_format db "The ranks of the bytes: %s", 10, 0
    sum_format db "The sum of the bytes: %i", 10, 0
    
    
segment code use32 class=code
    start:
        
        ; call analyse_bytes
        push dword sir
        push dword ranks
        push dword sum
        call analyse_bytes
        mov [sum], edx
        
        ; print the ranks
        push dword ranks
        push dword ranks_format
        call [printf]
        add esp, 4*2
        
        ; print the sum
        push dword [sum]
        push dword sum_format
        call [printf]
        add esp, 4*2
        
        push    dword 0
        call    [exit]