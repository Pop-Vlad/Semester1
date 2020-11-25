
bits 32

global start

extern exit, fopen, fread, printf, fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll

segment data use32 class = data
    file_name db "r1.txt", 0
    access_mode dd "r", 0
    file_descriptor dd 0
    str_size equ 100
    source resb str_size
    destination resb str_size
    format dd "%s", 0
    format_test dd "%i", 0
    test_ db "wer", 0

segment code use32 class = code
    start:
        
        ;open file
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        mov [file_descriptor], eax
        
        ;read string
        push dword [file_descriptor]
        push dword str_size
        push dword 1
        push dword source
        call [fread]
        add esp, 4*4
        
        ;initilalise conversion
        mov esi, source
        mov edi, destination
        cld
        
        operate_letter:
        
        lodsb
        cmp al, 0
        je finish
        
        ;convert current letter
        decode:
    
            cmp eax, "a"
            jne skip1
                mov eax, "y"
                jmp back
            skip1:
            cmp eax, "b"
            jne skip2
                mov eax, "z"
                jmp back
            skip2:
            cmp eax, "c"
            jb skip3
                cmp eax, "z"
                    sub eax, 2
                    jmp back
                ja skip3
            
            skip3:
            cmp eax, "A"
            jne skip4
                mov eax, "Y"
                jmp back
            skip4:
            cmp eax, "B"
            jne skip5
                mov eax, "Z"
                jmp back
            skip5:
            cmp eax, "C"
            jb back
                cmp eax, "Z"
                    sub eax, 2
                    jmp back
                ja back
            
            jmp back
            
        back:
        ;store converted letter
        stosb
        jmp operate_letter
        
        finish:
        
        ;print message
        push dword destination
        push dword format
        call [printf]
        add esp, 4*2
        
        ;close file
        push dword file_name
        call [fclose]
        
        ;exit
        push dword 0
        call [exit]