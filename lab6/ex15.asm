bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

segment data use32 class=data
    ; ...    
    s dd 12345607h, 1A2B3C15h
    l equ $-s
    d times l db 0
    
       
; our code starts here
segment code use32 class=code
        ;15. An S string of double words is given.
        ;Obtain the string D consisting of the bytes of the double words in the string D sorted in descending order in the unsigned interpretation.
            ;Example:
            ;s DD 12345607h, 1A2B3C15h
            ;d DB 56h, 3Ch, 34h, 2Bh, 1Ah, 15h, 12h, 07h
    start:
        mov ECX, l
        JECXZ end_loop
        mov ESI, s
        mov EDI, d
        CLD ; clear DF flag
        
        start_loop:
            movsb   
        loop start_loop  

        mov ECX, 7          
        sort:
                mov EDI, d
                mov EBX, 7
            sort_term:
                mov AL, [EDI]
                mov DL, [EDI+1]
                
                cmp AL, DL
                jge no_swap
                
                mov [EDI], DL
                mov [EDI+1], AL
            no_swap:
                inc EDI
                dec EBX
                jnz sort_term
        loop sort
        
        end_loop:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
