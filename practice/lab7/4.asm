bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll   
import fclose msvcrt.dll   
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "ana.txt", 0
    access_mode db "w", 0
    file_descriptor dd -1
    

; our code starts here
segment code use32 class=code
    start:
        ; The following code will create an empty file called "ana.txt" in the current folder.
        
        ;EAX = fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add ESP, 4*2
        
        ;verify if the file was created
        mov [file_descriptor], EAX
        cmp EAX, 0
        je final
        
        ;fclose(file_descriptor)
        push dword file_descriptor
        call [fclose]
        add ESP, 4*1
        
        final:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
