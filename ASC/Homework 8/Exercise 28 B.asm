
; A file name (defined in data segment) is given. Create a file with the given name, then read words from the keyboard until character '$' is read. Write only the words that contain at least one lowercase letter to file.

bits 32

global start

extern exit, scanf, fopen, fclose, fprintf
import exit msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class = data
    file_name dd "output.txt", 0  ; file_name = output.txt
    access_mode dd "w", 0         ; access_mode = write
    file_descriptor dd -1         ; file_descriptor = -1
    read_format dd "%s", 0        ; read_format = string
    write_format dd "%s ", 0      ; create the write_format
    current_sting resb 256        ; reserve 256 for the string
    
segment code use32 class = code

    start:
        
        ; ---------- File creation / opening ----------
        file_open:
            push dword access_mode      ; push access_mode = write
            push dword file_name        ; push file_name = "output.txt"
            call [fopen]                ; eax = descriptor of "output.txt"
            add esp, 4*2                ; clean stack
            mov [file_descriptor], eax  ; file_descriptor = eax
        
        beginning:
        
        ; ---------- Reading a string from keyboard ----------
        read:
            push dword current_sting  ; push current_sting
            push dword read_format    ; push read_format = string
            call [scanf]              ; current_sting = keyoard input
            add esp, 4*2              ; clean stack
        
        ; ---------- Check if string == $ ----------
        check_for_character:
            cmp byte [current_sting], '$'  ;
            je file_close                  ; if current_sting == $ go to file_close
        
        ; ---------- Analyze the current string. If it has a lowercase letter, write it to the file ----------
        mov ecx, 0
        analyze_string:
            cmp byte [current_sting + ecx], 0     ;
            je beginning                          ; if current_sting has reached the end return to beginning
            cmp byte [current_sting + ecx], 'a'   ;
            jb skip                               ; if the current character in the string is less than a (not a lowercase letter) skip writting it to file
            cmp byte [current_sting + ecx], 'z'   ;
            ja skip                               ; if the current character in the string is greater than z (not a lowercase letter) skip writting it to file
                
                ; ---------- Write a word to the file ----------
                write_to_file:
                    push dword current_sting      ; push current_sting
                    push dword write_format       ; push write_format
                    push dword [file_descriptor]  ; push file_descriptor
                    call [fprintf]                ; write current_sting to the file
                    add esp, 4*3                  ; clean stack
                    jmp beginning                 ; return to beginning
            
            skip:
                inc ecx             ; ecx = ecx + 1
                jmp analyze_string  ; go to analyzing the next letter
        
        
        jmp beginning  ; repeat the instructions above (beginning from read) until $ is given as input
        
        ; ---------- Closing the file ----------
        file_close:
            push dword [file_descriptor]  ; push file_descriptor
            call [fclose]                 ; close "output.txt"
            add esp, 4                    ; clean the stack
    
    push dword 0
    call [exit]