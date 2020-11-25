
%ifndef _B_ASM_
%define _B_ASM_

analyse_bytes:
    cld
    mov edx, 0
    mov esi, [esp + 4*3]
    mov edi, [esp + 4*2]
    begin:
        lodsd
        cmp eax, 0
        je finish
        mov bl, al
        mov bh, "4"
        
        shr eax, 8
        cmp al, bl
        jb skip1
            mov bl, al
            mov bh, "3"
        skip1:
        shr eax, 8
        cmp al, bl
        jb skip2
            mov bl, al
            mov bh, "2"
        skip2:
        shr eax, 8
        cmp al, bl
        jb skip3
            mov bl, al
            mov bh, "1"
        skip3:
        mov al, bh
        stosb
        add dl, bl
        jmp begin
    finish:
    mov [esp + 4], dl
    ret 12

%endif