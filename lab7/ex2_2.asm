bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
    ; ...    
    vowels_l db 'a', 'e', 'i', 'o', 'u'
    vowels_u db 'A', 'E', 'I', 'O', 'U'
    consonants_count dd 0
    
    file_name db "ex2.txt", 0
    access_mode db "r", 0 
    
    file_descriptor dd -1    
    text db 0
    
    format  db "%d", 0
    message db "The number of consonants: %d", 0
       
; our code starts here
segment code use32 class=code
        ;2. A text file is given. Read the content of the file, count the number of consonants and display the result on the screen. The name of text file is defined in the data segment.
    start:
        ; eax = fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add ESP, 4*2
                
        ;verify if the code opened the file 
        cmp EAX, 0
        je the_end
        
        mov [file_descriptor], EAX
        
        start_read:
            ;read one character -> int fread(void * str, int size, int count, FILE * stream)
            push dword [file_descriptor]
            push 1
            push 1
            push dword text
            call [fread]
            add ESP, 4 * 4
            
            ; check if it is the end of the file 
            cmp EAX, 0
            je cleanup
            
            mov AL, byte[text]
            
            ;check if it is consonants
            cmp AL, 'a'
            jl check_upper
            cmp AL, 'z'
            jle maybe_lower
            jmp next_char ;not letter
                  
        check_upper:
            cmp AL, 'A'
            jl next_char ;not letter
            cmp AL, 'Z'
            jle maybe_upper
            jmp next_char ;not letter
        
        maybe_lower:
            mov ECX, 5 ; length of vowels_l
            mov ESI, vowels_l
            
            check_vowel_l:
                cmp AL, byte[ESI]
                je next_char
                inc ESI
            loop check_vowel_l
            
            ;if it is not vowel => consonant
            inc dword [consonants_count]
            jmp next_char
            
        
        maybe_upper:
            mov ECX, 5 ; length of vowels_u
            mov ESI, vowels_u
            
            check_vowel_u:
                cmp AL, byte[ESI]
                je next_char
                inc ESI
            loop check_vowel_u
            
            ;if it is not vowel => consonant
            inc dword [consonants_count]
            jmp next_char
                                  
        next_char:
            jmp start_read
               
        cleanup:
            push dword [consonants_count]
            push dword message
            call [printf]
            add esp, 4*2
            
            ;closing the file
            push dword [file_descriptor]
            call [fclose]
            add ESP, 4*1
            
        the_end:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
