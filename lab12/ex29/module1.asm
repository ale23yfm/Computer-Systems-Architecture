bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global _sentence   
   
extern _word_len, _printf 

segment data use32 class=data
    newline db 10, 0

segment code use32 class=code
    _sentence: 
        ;create stack frame
        push EBP
        mov EBP, ESP
        push EBX
        
        ;[EBP+4*1] - return value
        mov ECX, [EBP+4*2]
        mov EBX, ECX
        
        skip_spaces:
            movzx EDX, byte[ECX]
            test EDX, EDX
            jz print_nl
            
            cmp EDX, ' '
            je next
            
            push EBX
            call _word_len
            add ESP, 4*1
            
            mov EBX, ECX
            
        next:
            inc ECX
            jmp skip_spaces
            
        print_nl:
            push newline
            call _printf
            add ESP, 4*1
        
        done:
            ;restore stack frame
            pop EBX
            mov ESP, EBP
            pop EBP
            ret
