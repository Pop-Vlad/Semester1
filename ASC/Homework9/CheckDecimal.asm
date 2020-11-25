

; Check if a given character is a number (in the set {0, 1, 2, 3, 4, 5, 6, 7, 8, 9})

checkDecimal:
    mov eax, [esp + 4]  ; mov the charater into eax
    cmp eax, "0"        ;
    jae .skip1          ; check if the ascii code of the character is above the one of "0"
    mov eax, 0          ; the result of the comparison is stored in eax (in this case, false)
    ret 4               ; return and clean the stack
    .skip1:             ;
    cmp eax, "9"        ;
    jbe .skip2          ; check if the ascii code of the character is below the one of "9"
    mov eax, 0          ; the result of the comparison is stored in eax (in this case, false)
    ret 4               ; return and clean stack
    .skip2:             ;
    mov eax, 1          ; the result of the comparison is stored in eax (in this case, true)
    ret 4               ; return and clean the stack
