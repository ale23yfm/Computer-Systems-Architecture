bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    ; ...    
    a dd 0
    b dd 0
    result dd 0
    message_a  db "a=", 0
    message_b  db "b=", 0
    format  db "%d", 0
       
; our code starts here
segment code use32 class=code
        ;2. Read two numbers a and b (in base 10) from the keyboard and calculate a/b. This value will be stored in a variable called "result" (defined in the data segment). The values are considered in signed representation.
    start:
        ;display the message a= to enable reading from the keyboard
        push dword message_a
        call [printf]
        add ESP, 4*1
        
        ;read the number a
        push dword a
        push dword format
        call [scanf]
        add ESP, 4*2
        
        ;display the message b= to enable reading from the keyboard
        push dword message_b
        call [printf]
        add ESP, 4*1
        
        ;read the number b
        push dword b
        push dword format
        call [scanf]
        add ESP, 4*2
        
        mov EAX, dword [a]
        cdq
        mov EBX, dword [b]
        idiv EBX
        mov dword [result], EAX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
