
; Module that checks if a number is positive or negative

checkPositive:
    mov eax, [esp + 4]  ; move the number into eax
    cmp eax, 0          ; 
    jge .positive       ; check if eax is positive. If true go to positive:
    .negative:          ;
        mov eax, 0      ; eax = 0
        ret 4           ; return and clean stack
    .positive:          ;
        mov eax, 1      ; eax = 1
        ret 4           ; return and clean stack
