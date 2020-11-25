
%include "CheckDecimal.asm"

%ifndef _PARSESTRING_ASM_
%define _PARSESTRING_ASM_

parseString:
    pop ebx
    pop ecx
    mov dl, [ebx + esi]      ; move the current letter in dl
    cmp edx, 0               ;
    je endParse              ; check if the letter == 0 (the string reached its end), if true go to the next step
    push dword edx           ;
    call checkDecimal        ; check if the letter is a number
    cmp eax, 1               ;
    jne .skip                ;
    mov [ecx + edi], dl      ;
    inc edi                  ;
    .skip:                   ;
    inc esi                  ;
    jmp parseString          ; go back to repeat the algorithm for the next letter
endParse:
    ret 8

%endif