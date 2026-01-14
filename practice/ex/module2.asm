bits 32

global _product

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

; our code starts here
segment code use32 class=code
    _product:
        ;create stack frame
        push EBP
        mov EBP, ESP
        
        ;[EBP+4*1] - return value
        mov EAX, [EBP+4*2]
        imul dword [EBP+4*3]
        
        ;restore stack frame
        mov ESP, EBP
        pop EBP
        ret
