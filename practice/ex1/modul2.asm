bits 32

global _build_number

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

; our code starts here
segment code use32 class=code
    _build_number:
        ;create stack frame
        push EBP
        mov EBP, ESP
        
        ;[EBP+4*1] - return value
        mov ESI, [EBP+4*2]
        mov ECX, [EBP+4*3]
        xor EAX, EAX
        
        digit_loop:
            mov BL, [ECX+ESI]
            cmp BL, '0'
            jb done
            cmp BL, '9'
            ja done
            
            sub BL, '0'
            mov EDX, 10
            mul EDX
            add EAX, EBX
            
            inc ECX
            jmp digit_loop
            
        done:
            ;restore stack frame
            mov ESP, EBP
            pop EBP
            ret
