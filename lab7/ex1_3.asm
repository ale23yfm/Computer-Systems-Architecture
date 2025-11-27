bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

segment data use32 class=data
    message db "%d + %d = %d", 0
    ma db "a=", 0
    mb db "b=", 0
    a dd 0
    b dd 0
    result dd 0
    format db "%d", 0
    
       
; our code starts here
segment code use32 class=code
        ;3. Two natural numbers a and b (a, b: dword, defined in the data segment) are given. Calculate their sum and display the result in the following format: "<a> + <b> = <result>". Example: "1 + 2 = 3"
    start:
        ;printf(ma)
        push dword ma
        call [printf]
        add ESP, 4*1
        
        ;scanf(format, &a)
        push dword a
        push dword format
        call [scanf]
        add ESP, 4*2
        
        ;printf(mb)
        push dword mb
        call [printf]
        add ESP, 4*1
        
        ;scanf(format, &b)
        push dword b
        push dword format
        call [scanf]
        add ESP, 4*2
        
        mov EBX, [a]
        mov ECX, [b]
        add EBX, ECX
        mov [result], EBX
        
        ;printf(message, a, b, result)
        push dword [result]
        push dword [b]
        push dword [a]
        push dword message 
        call [printf]
        add ESP, 4*4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
