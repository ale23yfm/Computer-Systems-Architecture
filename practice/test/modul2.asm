bits 32

global _sum_digits
extern _printf

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    format db 'Sum of digits is %d', 0

; our code starts here
segment code use32 class=code
    _sum_digits:
        ;create stack frame
        push EBP
        mov EBP, ESP
        
        ;[EBP+4*1] - return value 
        mov ESI, [EBP+8]
        xor EAX, EAX
        
        loop:
            mov BL, [ESI]
            cmp BL, 0
            je done
            cmp BL, '0'
            jb not_digit
            cmp BL, '9'
            ja not_digit
            sub BL, '0'
            movzx EBX, BL
            add EAX, EBX
            
        not_digit:
            inc ESI    
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
