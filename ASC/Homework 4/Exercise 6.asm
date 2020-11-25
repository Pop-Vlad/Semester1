; Given the word A, obtain the integer number n represented on the bits 0-2 of A. Then obtain the word B by rotating A n positions to the right. Compute the doubleword C:
; the bits 8-15 of C have the value 0
; the bits 16-23 of C are the same as the bits of 2-9 of B
; the bits 24-31 of C are the same as the bits of 7-14 of A
; the bits 0-7 of C have the value 1

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data

    A dw 1010111000101010b
    n db 0
    B dw 0
    C dd 0
    
segment code use32 class=code
    start:
        
        ; ------ Calculate n ------
        
        mov ax, [A]       ; ax= A
        and al, 00000111b ; al = a2 a1 a0
        mov [n], al       ; n = a2 a1 a0
        
        ; ------ Calculate B ------
        
        mov ax, [A]       ; ax = A
        mov cl, [n]       ; cl = n
        ror ax, cl        ; ax = A (rotated by n position )
        mov [B], ax       ; B = A (rotated by n position )
        
        ; ------ Calculate C ------
        
        mov al, 00000000b ; al = 00000000
        mov [C+1], al     ; bits 8-15 of C = 00000000
        
        mov ax, [B]       ; ax = B
        shr ax, 2         ; al = bits 2 -9 of B
        mov [C+2], al     ; bits 16 - 23 of C = bits 2 - 9 of B
        
        mov ax, [A]       ; ax = A
        shr ax, 7         ; al = bits 7 -14 of A
        mov [C+3], al     ; bits 24 - 31 of C = bits 7 -14 of A
        
        mov al, 11111111b ; al = 11111111
        mov [C], al       ; bits 0 - 7 of C = 11111111
        
        push    dword 0
        call    [exit]