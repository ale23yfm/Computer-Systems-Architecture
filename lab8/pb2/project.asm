bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

import printf msvcrt.dll
import scanf msvcrt.dll

extern read

segment data use32 class=data
    message db "Enter the numbers: ", 0
    format db "%[^", 10, "]", 0   ; 10 = '\n'

    text times 100 dd 0

segment code use32 class=code
start:
        ;Read from the keyboard a string of numbers, given in the base 10 as signed numbers (a string of characters is read from the keyboard and a string of numbers must be stored in the memory).
        ;printf(message)
        push dword message
        call [printf]
        add esp, 4*1
        
        ;scanf(text,format)
        push dword text
        push dword format
        call [scanf]
        add esp, 4*2
        
        push text
        
        call read

        ; exit
        push dword 0
        call [exit]
