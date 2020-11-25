bits 64

global start

extern exit, fopen, fclose, fscanf, printf, fgets
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll
import fgets msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    file_name db "seeds.txt", 0
    access_mode db "r", 0
    file_descriptor dq 0
    read_format db "%d", 0
    current_seed dq 0
    max dq -1
    min dq 0
    print_format db "Min: %x, Max: %x", 0
    
    test_format db "%s", 0
    test_message db "www", 0
    
segment code use32 class=code
    start:
        
        push qword access_mode
        push qword file_name
        call [fopen]
        add rsp, 4*2
        mov [file_descriptor], rax
        
        next_seed:
        
        push qword current_seed
        push qword read_format
        push qword [file_descriptor]
        call [fscanf]
        add rsp, 4*3
        push qword test_message
        push qword test_format
        call [printf]
        add esp, 4*2
        
        mov rax, [current_seed]
        cmp rax, 0
        je finish
        
        push qword test_message
        push qword test_format
        call [printf]
        add esp, 4*2
        
        and [min], rax
        or [max], rax
        
        jmp next_seed
        
        finish:
        push qword [max]
        push qword [min]
        push qword print_format
        call [printf]
        add rsp, 4*5
        
        push qword [file_descriptor]
        call [fclose]
        add rsp, 4
        
        push    dword 0
        call    [exit]