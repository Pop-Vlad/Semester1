
; Read from the keyboard a filename of file which contains sentences
; The program will reverse the last word from each sentence.
; The program will display on the console the reversed words.  

bits 32

global start

extern exit, fopen, fclose, fread, scanf, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    max_length equ 100
    read_format db "%s", 0
    file_name resb 20
    access_mode db "r", 0
    file_descriptor dd 0
    text resb max_length
    len dd 0
    write_format db "%s", 0
    result resb max_length
    index_poit dd 0
    index_space dd 0
    
    test_ db 123
    test_format db "%d", 0
    
segment code use32 class=code
    start:
        
        ; Reading the file name from the keyboard
        push dword file_name
        push dword read_format
        call [scanf]
        add esp, 4*2
        
        ; Opening the file
        push dword access_mode
        push dword file_name
        call [fopen]
        mov [file_descriptor], eax
        add esp, 4*2
        
        ; Reading the text
        push dword [file_descriptor]
        push dword 1
        push dword max_length
        push dword text
        call [fread]
        add esp, 4*4
        mov [len], eax
        
        mov esi, text
        mov edi, result
        mov ecx, 0
        
        parse:
        
        cld
        lodsb
        inc ecx
        cmp al, 0
        je finish
        cmp al, "."
        je get_last_word
        jmp parse
        
        get_last_word:
        sub ecx, 2
        get_last_word_parse:
        mov al, [text + ecx]
        cmp al, " "
        je end_of_word
        stosb
        dec ecx
        jmp get_last_word_parse
        end_of_word:
        mov al, " "
        stosb
        add ecx, 2
        jmp parse
        
        finish:
        
        ; Printing the result text
        push dword result
        push dword write_format
        call [printf]
        add esp, 4*2
        
        ; Closing the file
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        ; Exiting the program
        push dword 0
        call [exit]
        
        



        
        