
; Two strings containing characters are given. Calculate and display the result of the concatenation of all characters of type decimal number from the second string,
; and then followed by those from the first string, and vice versa, the result of concatenating the characters from the first string after those from the second string.

bits 32

global start

extern printf, exit
import printf msvcrt.dll
import exit msvcrt.dll

%include "CheckDecimal.asm"

segment data use32 class = data
    string1 db "abc123def9", 0
    string2 db "1e4b6eee9", 0
    format dd "%s", 10, 13, 0
    result resb 200

segment code use32 class = code
    start:
        
        ; ---------- Concatenate string 1 with string 2 ----------
        part1:
            
            ; ---------- Parse the first string ----------
            
            mov edx, 0  ; initialise edx
            mov esi, 0  ; initialise esi
            mov edi, 0  ; initialise edig
            
            .parse_string1:
                mov dl, [string1 + esi]  ; move the current letter in dl
                cmp edx, 0               ;
                je .end_parse_1          ; check if the letter == 0 (the string reached its end), if true go to the next step
                push dword edx           ; push the letter
                call checkDecimal        ; check if the letter is a number
                cmp eax, 1               ;
                jne .skip1               ; if the letter is not a number skip the operation
                mov [result + edi], dl   ; append the number to the result
                inc edi                  ; edi = edi + 1
                .skip1:                  ;
                inc esi                  ; esi = esi + 1
                jmp .parse_string1       ; go back to repeat the algorithm for the next letter
            .end_parse_1:
            
            ; ---------- Parse the second string ----------
            
            mov edx, 0  ; initialise edx
            mov esi, 0  ; initialise esi
            
            .parse_string2:
                mov dl, [string2 + esi]  ; move the current letter in dl
                cmp edx, 0               ;
                je .end_parse_2          ; check if the letter == 0 (the string reached its end), if true go to the next step
                push dword edx           ; push the letter
                call checkDecimal        ; check if the letter is a number
                cmp eax, 1               ;
                jne .skip2               ; if the letter is not a number skip the operation
                mov [result + edi], dl   ; append the number to the result
                inc edi                  ; edi = edi + 1
                .skip2:                  ;
                inc esi                  ; esi = esi + 1
                jmp .parse_string2       ; go back to repeat the algorithm for the next letter
            .end_parse_2:
            
            ; ---------- Print first the result ----------
            
            .print_result:
                mov byte [result + edi], 10     ; put a new line at the end of the string
                mov byte [result + edi + 2], 0  ; put a 0 at the end of the result to mark its end
                push dword result               ; push result onto stack
                push dword format               ; push format onto stack
                call [printf]                   ; print the result
                add esp, 4*2                    ; clean stack
        
        
        
        ; ---------- Concatenate string 2 with string 1 ----------
        part2:
            
            ; ---------- Parse the second string ----------
            
            mov edx, 0  ; initialise edx
            mov esi, 0  ; initialise esi
            mov edi, 0  ; initialise edig
            
            .parse_string2:
                mov dl, [string2 + esi]  ; move the current letter in dl
                cmp edx, 0               ;
                je .end_parse_2          ; check if the letter == 0 (the string reached its end), if true go to the next step
                push dword edx           ; push the letter
                call checkDecimal        ; check if the letter is a number
                cmp eax, 1               ;
                jne .skip2               ; if the letter is not a number skip the operation
                mov [result + edi], dl   ; append the number to the result
                inc edi                  ; edi = edi + 1
                .skip2:                  ;
                inc esi                  ; esi = esi + 1
                jmp .parse_string2       ; go back to repeat the algorithm for the next letter
            .end_parse_2:
            
            ; ---------- Parse the first string ----------
            
            mov edx, 0  ; initialise edx
            mov esi, 0  ; initialise esi
            
            .parse_string1:
                mov dl, [string1 + esi]  ; move the current letter in dl
                cmp edx, 0               ;
                je .end_parse_1          ; check if the letter == 0 (the string reached its end), if true go to the next step
                push dword edx           ; push the letter
                call checkDecimal        ; check if the letter is a number
                cmp eax, 1               ;
                jne .skip1               ; if the letter is not a number skip the operation
                mov [result + edi], dl   ; append the number to the result
                inc edi                  ; edi = edi + 1
                .skip1:                  ;
                inc esi                  ; esi = esi + 1
                jmp .parse_string1       ; go back to repeat the algorithm for the next letter
            .end_parse_1:
            
            ; ---------- Print the second result ----------
            
            .print_result:
                mov byte [result + edi], 10     ; put a new line at the end of the string
                mov byte [result + edi + 2], 0  ; put a 0 at the end of the result to mark its end
                push dword result               ; push result onto stack
                push dword format               ; push format onto stack
                call [printf]                   ; print the result
                add esp, 4*2                    ; clean stack
    
    push dword 0
    call [exit]