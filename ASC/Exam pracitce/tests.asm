
bits 32

global start

extern exit, fopen, printf, fclose, fprintf, fread, scanf
import exit msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import fread msvcrt.dll
import scanf msvcrt.dll

segment data use32 class = data
    file_name db "myfile.txt",0
    access_mode db "w", 0
    file_descriptor dd 0
    
    string_size equ 100
    string resb string_size
    string2 db "Hello, Vlad", 0
    format db "%s", 0

segment code use32 class = code
start:
    
    push dword access_mode
    push dword file_name
    call [fopen]
    add esp, 4*2
    mov [file_descriptor], eax
    
    push dword string2
    push dword format
    push dword [file_descriptor]
    call [fprintf]
    add esp, 4*3
    
    push dword [file_descriptor]
    call [fclose]
    add esp, 4
    
    push dword string
    push dword format
    call [scanf]
    add esp, 4*2
    
    push dword string
    push dword format
    call [printf]
    add esp, 4*2
    
    push dword 0
    call [exit]