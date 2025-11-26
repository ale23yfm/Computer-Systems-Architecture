bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll    
import scanf msvcrt.dll    
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    n dq 0 
    message db "Your number is %lld", 0
    input db "n= ", 0
    format db '%lld', 0

; our code starts here
segment code use32 class=code
    start:
        ; Printing a quadword on the screen
        
        ;prinf(input)
        push dword input
        call [printf]
        add ESP, 4*1
        
        ;scanf(format, n)
        push dword n
        push dword format
        call [scanf]
        add ESP, 4*2
                
        ;prinf(message, n)
        push dword [n+4]
        push dword [n]
        push dword message
        call [printf]
        add ESP, 4*3
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
