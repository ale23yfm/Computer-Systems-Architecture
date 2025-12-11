bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global read        

; declare external functions needed by our program
extern printf     
import printf msvcrt.dll

segment data use32 class=data
    format db "%s", 0

segment code use32 class=code
    read:
        ;printf(format, text)
        push dword [esp+4]
        push dword format
        call [printf]
        add esp, 4*2

        ret 4
