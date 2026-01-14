bits 32

global _word_len
extern _printf

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    format db '%d', 0

; our code starts here
segment code use32 class=code
    _word_len:
        ;create stack frame
        push EBP
        mov EBP, ESP
        
        ;[EBP+4*1] - return value
        mov ECX, [EBP+4*2]
        xor EAX, EAX
        
        loop:
            movzx EDX, byte[ECX] 
            jz done
            
            cmp EDX, ' '
            je done
            
            inc EAX
            inc ECX
            jmp loop
        
        done:
            push EAX
            push format
            call _printf
            add ESP, 4*2
            
            ;restore stack frame
            mov ESP, EBP
            pop EBP
            ret                
