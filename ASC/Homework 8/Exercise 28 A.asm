
; Read numbers (in base 10) in a loop until the digit '0' is read from the keyboard. Determine and display the biggest number from those that have been read.

bits 32

global start

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class = data
    
    current_number dd 0  ; current_number = 0
    biggest_number dd 0  ; biggest_number = 0
    format db "%d", 0    ; format = decimal

segment code use32 class = code
    
    start:
    
        ; ---------- Read a number from the keyboard ----------
        read:
            push dword current_number  ; push addres of current_number
            push dword format          ; push format = decimal
            call [scanf]               ; current_number = keyboard input
            add esp, 4*2               ; clean stack
        
        ; ---------- Check if number is 0, if true go to displaing the biggest number ----------
        check_if_0:
            cmp dword [current_number], 0  ;
            je display                     ; if current_number == 0, go to displaing the biggest number
        
        ; ---------- Obtain the biggest number ----------
        obtain_biggest_nr:
            mov eax, [current_number]  ; eax = current_number
            cmp eax, [biggest_number]  ;
            jbe skip                   ; if eax <= biggest_number skip the next instruction
            mov [biggest_number], eax  ; biggest_number = eax
            skip:
    
        jmp start ; repeat all of the instructions above until 0 is given as input
    
        ; ---------- Show the biggest number on screen ----------
        display:
            push dword [biggest_number]  ; push biggest_number
            push dword format            ; push format = decimal
            call [printf]                ; print biggest_number
            add esp, 4*2                 ; clean stack
    
    push dword 0
    call [exit]