
bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class = data
    sir dq 1110111b, 100000000h, 0ABCD0002E7FCh, 5, 0
    res resd 100
    print_format db "%b ", 0

segment code use32 class = code
start:
    
    mov esi, sir
    mov edi, res
    
    begin:
        mov eax, [esi]
        cmp eax, 0
        je finish
        add esi, 8
        
        mov dl, 0
        mov ecx, 32
        find_sequence:
            mov ebx, 111b
            and ebx, eax
            shr eax, 1
            cmp ebx, 111b
            jne skip
                add dl, 1
                shr eax, 2
            skip:
        loop find_sequence
        
        cmp dl, 2
        jb skip2
            mov eax, [esi]
            stosd
        skip2:
        jmp begin
    finish:
    
    mov esi, res
    print:
        lodsd
        cmp eax, 0
        je end_of_program
        push dword print_format
        push eax
        call [printf]
        add esp, 4*2
        jmp print
    end_of_program:
    
    push dword 0
    call [exit]