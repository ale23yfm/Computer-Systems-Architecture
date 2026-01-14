bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global _read_numbers      

extern _build_number  

segment data use32 class=data

segment code use32 class=code
    _read_numbers: 
        ;create stack frame
        push EBP
        mov EBP, ESP
        
        ;[EBP+4*1] - return value
        mov ESI, [EBP+4*2]
        xor ECX, ECX
        
        loop:
            cmp byte[ESI, ECX], 0
            je done
            
            push ECX
            push ESI
            call _build_number
            add ESP, 4*2
            
            inc ECX
            jmp loop
        
        done:
            ;restore stack frame
            mov ESP, EBP
            pop EBP
            ret
