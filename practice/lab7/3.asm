bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll   
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    format db '%d', 0

; our code starts here
segment code use32 class=code
    start:
        ; The code below will calculate the result of some arithmetic operations in the EAX register, save the value of the registers, then display the result value and restore the value of the registers.

        mov EAX, 10
        add EAX, 40
        mov EBX, 10
        mul EBX
        
        ;save the values 
        pushad
        
        ;printf(format, EAX)
        push dword EAX
        push dword format
        call [printf]
        add ESP, 4*2
        
        popad
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
