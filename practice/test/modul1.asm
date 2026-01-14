bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global _display_last_char_count
   
extern _printf 

segment data use32 class=data
    buffer db "'x' appears n times", 0

segment code use32 class=code
    _display_last_char_count: 
        ;create stack frame
        push EBP
        mov EBP, ESP
        
        ;[EBP+4*1] - return value 
        mov ESI, [EBP+8]
        xor ECX, ECX
        
        count_len:
            cmp byte[ESI+ECX], 0
            je len_found
            inc ECX
            jmp count_len
            
        len_found:
            test ECX, ECX
            jz done
            mov EDI, ECX
            dec EDI
            mov BL, [ESI+EDI]
            
            xor edx, edx             ; counter
            xor ecx, ecx             ; index
            
        count_loop:
            cmp byte[ECX+ESI], 0
            je print_result
            cmp [ECX+ESI], BL
            jne next_char
            inc EDX
            
        next_char:
            inc ECX 
            jmp count_loop
            
        print_result:
            mov [buffer], BL
            add EDX, '0'
            mov [buffer+12], DL
            push buffer
            call _printf
            add ESP, 4
           
        done:
            ;recover stack frame
            mov ESP, EBP
            pop EBP
            ret       
