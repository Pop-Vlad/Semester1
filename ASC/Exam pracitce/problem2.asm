
bits 32

global start

extern exit, fopen, fclose, scanf, fprintf
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class = data
    file_name db "problem2.txt", 0
    access_mode db "w", 0
    file_descriptor dd 0
    read_format db "%d", 0
    write_format db "%d, %s, %d", 10, 0
    current_number dd 0
    number_of_1s db 0
    number_hexadecimal resb 8
    position db 0


segment code use32 class = code
start:
    push dword access_mode
    push dword file_name
    call [fopen]
    mov [file_descriptor], eax
    add esp, 4*2
    
    again:
        push dword current_number
        push dword read_format
        call [scanf]
        add esp, 4*2
        mov eax, [current_number]
        
        cmp eax, 0
        je finish
        
        
        convertion:
        
        mov bx, 16
        mov ecx, 8
        divisions:
            div word bx
            cmp dl, 15
            jne skip1
                mov byte [number_hexadecimal + ecx - 1], "F"
                jmp end_digit
            skip1:
            cmp dl, 14
            jne skip2
                mov byte [number_hexadecimal + ecx - 1], "E"
                jmp end_digit
            skip2:
            cmp dl, 13
            jne skip3
                mov byte [number_hexadecimal + ecx - 1], "D"
                jmp end_digit
            skip3:
            cmp dl, 12
            jne skip4
                mov byte [number_hexadecimal + ecx - 1], "C"
                jmp end_digit
            skip4:
            cmp dl, 11
            jne skip5
                mov byte [number_hexadecimal + ecx - 1], "B"
                jmp end_digit
            skip5:
            cmp dl, 10
            jne skip6
                mov byte [number_hexadecimal + ecx - 1], "A"
                jmp end_digit
            skip6:
                add dl, "0"
                mov byte [number_hexadecimal + ecx - 1], dl
            end_digit:
        loop divisions
        convertion_end:
        
        mov dword [number_of_1s], 0
        mov ecx, 32
        check_bit:
            rcl eax, 1
            adc dword [number_of_1s], 0
        loop check_bit
        
        
        push dword [number_of_1s]
        push dword [number_hexadecimal]
        push dword [current_number]
        push dword write_format
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2
    jmp again
    
    finish:
    push dword [file_descriptor]
    call [fclose]
    add esp, 4
    
    push dword 0
    call [exit]