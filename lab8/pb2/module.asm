bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global reading        

; declare external functions needed by our program
extern printf     
import printf msvcrt.dll

segment data use32 class=data
    message db "Enter the numbers: ", 0
    format_s db "%[^", 10, "]", 0   ; 10 = '\n'
    number dd 0
    format db "%d", 10, 13, 0

    text times 100 dd 0

segment code use32 class=code
    reading: 
        read_number:
            ;read one char
            lodsb
            cmp AL, " "
            je end_nr
            cmp AL, 0
            je end_nr
            
            ;convert to digit
            mov ECX, 0
            mov CL, AL
            sub CL, '0'
            
            ;multiply the previous number by 10
            mov EAX, [number]
            mov EBX, 10
            mul EBX 
            
            ;add the current digit             
            add EAX, ECX  
            
            ;store current number into number
            mov [number], EAX
        jmp read_number
        
        end_nr:
            ;printf(format, number)
            push dword [number] 
            push dword format
            call [printf]
            add ESP, 4*2
            
            mov dword [number], 0
            jmp reading
            
        last_nr:
            ;printf(format, number)
                push dword [number] 
                push dword format
                call [printf]
                add ESP, 4*2
                ret 4
