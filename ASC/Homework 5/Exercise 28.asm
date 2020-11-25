
; Two character strings S1 and S2 are given.
; Obtain the string D by concatenating the elements found on the positions multiple of 3 from S1 and the elements of S2 in reverse order. 

; Example:
; S1: '+', '4', '2', 'a', '8', '4', 'X', '5'
; S2: 'a', '4', '5'
; D: '+', 'a', 'X', '5', '4', 'a'

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data

    S1 db '+', '4', '2', 'a', '8', '4', 'X', '5'
    LS1 equ $-S1
    S2 db 'a', '4', '5'
    LS2 equ $-S2
    D times LS1 db 0
    D1 times LS2 db 0

segment code use32 class=code
    start:
        
        ; ------ Obtain the characters from S1 ------
        
        mov eax, LS1 ; eax = LS1
        mov edx, 0   ; edx:eax = LS1
        mov ebx, 3   ; ebx = 3
        div ebx      ; eax = LS1 / 3 , edx = LS1 % 3
        cmp edx, 0   ; check if LS1 % 3 = 0
        je skip
            inc eax      ; eax = LS1 / 3 + 1
        skip:
        mov ecx, eax ; ecx = Ls1 / 3 (+ 1) (the number of times step 1 is looped)
        mov esi, 0   ; esi = 0
        mov edi, 0   ; edi = 0
        
        step1:
            mov al, [S1 + esi] ; al = character from S1
            mov [D + edi], al  ; D = D + character from S1
            add esi, 3         ; esi = esi + 3
            add edi, 1         ; edi = edi + 1
        loop step1
        
        ; ------ Obtain the characters from S2 ------
        
        mov ecx, LS2 ; ecx = LS2 (the number of times step 2 is looped)
        mov esi, LS2 ; esi = LS2
        dec esi      ; esi = LS2 - 1
            
        step2:
            mov al, [S2 + esi] ; al = character from S2
            mov [D + edi], al  ; D = D + character from S2
            dec esi            ; esi = esi - 1
            inc edi            ; edi = edi + 1
        loop step2
        
        ; -------------------------------------------
        
        push dword 0
        call [exit]