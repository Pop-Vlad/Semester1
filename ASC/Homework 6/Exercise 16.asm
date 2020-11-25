
; Being given two alphabetical ordered strings of characters, s1 and s2, build using merge sort the ordered string of bytes that contain all characters from s1 and s2.

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
    s1 db "abdegimx"          ; s1 = abdegimx
    len1 dd $-s1              ; len1 = 8
    s2 db "cdfhjor"            ; s2 = cfhjor
    len2 dd $-s2              ; len2 = 6
    result resb len1 + len2   ; reserve 14 bytes for result
    
segment code use32 class = code
    start:
        
        mov ecx, 0        ; ecx = 0
        mov edx, 0        ; edx = 0
        mov edi, result   ; edi = 0
        
        ; ---------- Step 1 ----------
        ; Choose the character from the 2 strings and move it to destination, until one string has no characters left
        
        step1:
            
            cmp dword [len1], 0
            je step2.a           ; if len1 == 0, go to step2.a
            cmp dword [len2], 0
            je step2.b           ; if len2 == 0, go to step 2.b
            mov al, [s1 + ecx]   ; al = the character on position ecx of s1
            mov bl, [s2 + edx]   ; bl = the character on position edx of s2
            cmp al, bl
            ja from_s2           ; if s1 > s2 go to from_s2 
            
            ; Take a character from s1 and move it to result
            
            from_s1:
                stosb              ; append al to result
                inc ecx            ; ecx = ecx + 1
                dec dword [len1]   ; len1 = len1 -1
                jmp step1          ; return to step1
            
            ; Take a character from s2 and move it to result
            
            from_s2:
                mov al, bl         ; al =bl
                stosb              ; append al to result
                inc edx            ; edx =edx + 1
                dec dword [len2]   ; len2 = len2 - 1
                jmp step1          ; return to step1
        
        ; ---------- Step 2 ----------
        ; Append the remaining string to the destination
        
            ; Append the remaining part from s2
            
            step2.a:
                cmp dword [len2], 0
                je exit               ; if len2 == 0 go to exit
                mov al, [s2 + edx]    ; al = the character on position edx of s2
                stosb                 ; append al to result
                inc edx               ; edx = edx + 1
                dec dword [len2]      ; len2 = len2 - 1
            
            ; Append the remaining part from s1
            
            step2.b:
                cmp dword [len1], 0
                je exit               ; if len1 == 0 go to exit
                mov al, [s1 + ecx]    ; al = the character on position ecx of s1
                stosb                 ; append al to result 
                inc ecx               ; ecx = ecx + 1
                dec dword [len1]      ; len1 = len1 - 1
        
        push dword 0
        call [exit]