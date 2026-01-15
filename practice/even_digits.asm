bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global _num_from_even

segment data use32 class=data

segment code use32 class=code
    _num_from_even: 
        ;created stack frame
        push EBP
        mov EBP, ESP
        
        ;[EBP+4] - return value
        xor EAX, EAX ; number
        mov ESI, [EBP+8]
        
        digits:
            xor EBX, EBX
            mov BL, [ESI]
            cmp BL, 0 ;if it ended
            je done
            cmp BL, '0' ; not number
            jb not_digit
            cmp BL, '9' ; not number
            ja not_digit
            sub BL, '0' ; transformed into digit
            test BL, 1 ; if 1 -> odd, 0 -> even
            jnz not_digit
            mov ECX, 10
            mul ECX
            add EAX, EBX    
            
        not_digit:
            inc ESI
            jmp digits
        done:
            ;restore stack frame
            mov ESP, EBP
            pop EBP
            ret
