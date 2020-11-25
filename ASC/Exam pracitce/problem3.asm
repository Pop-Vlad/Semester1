
bits 32

global start

extern exit, scanf, printf, fopen, fclose, fread
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll

segment data use32 class = data
    max_length equ 10
    file_name resb max_length
    access_mode db "r", 0
    file_descriptor db 0
    read_format_file db "%s", 0
    read_format_N db "%d", 0
    current_byte db 0
    sum dd 0
    write_format db "Sum: %d", 0
    N db 0
    

segment code use32 class = code
start:
    
    push file_name
    push read_format_file
    call [scanf]
    add esp, 4*2
    
    push N
    push read_format_N
    call [scanf]
    add esp, 4*2
    
    push access_mode
    push file_name
    call [fopen]
    add esp, 4*2
    mov [file_descriptor], eax
    
    mov eax, 1
    mov bl, [N]
    mov edx, 0
    
    parse_file:
    push dword [file_descriptor]
    push dword 1
    push dword 1
    push current_byte
    call [fread]
    add esp, 4*4
    cmp eax, 0
    je finish
    push dword [current_byte]
    push write_format
    call [printf]
    add esp, 4*2
    mov al, [current_byte]
    here:
    mov ecx, [N]
        rcl al, 1
        adc dword [sum], 0
    loop here
    
    
    jmp parse_file
    
    finish:
    push dword [file_descriptor]
    call [fclose]
    add esp, 4
    
    push dword [sum]
    push write_format
    call [printf]
    add esp, 4*2
    
    push dword 0
    call [exit]