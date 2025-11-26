bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, printf, fclose, fread             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll   
import fread msvcrt.dll   
import printf msvcrt.dll   
import fclose msvcrt.dll   
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "ana.txt", 0
    access_mode db "r", 0
    file_descriptor dd -1
    len equ 100
    text times len db 0
    message db "This is your text: %s", 0

; our code starts here
segment code use32 class=code
    start:
        ; The following code will open a file called "ana.txt" from current folder,
        ; and it will read maximum 100 characters from this file.
        
        ;fopen(&file_name, &access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add ESP, 4*2
        
        ;verify if it opened the file
        mov [file_descriptor], EAX
        cmp EAX, 0
        je final
        
        ;fred(text, 1, &len, file_descriptor)
        push dword [file_descriptor]
        push dword 100
        push dword 1
        push dword text
        call [fread]
        add ESP, 4*4
        
        ;printf(&message, &text)
        push dword text
        push dword message
        call [printf]
        add ESP, 4*2
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add ESP, 4*1
        
        final:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
