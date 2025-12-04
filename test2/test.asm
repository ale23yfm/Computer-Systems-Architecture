bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, fprintf, scanf, fopen, fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

segment data use32 class=data
    n dd 0 
    number db 0
    sum dd 0
    sum_n dd 0
    
    message_n db "n= ", 0
    format db "%d", 0
    format_number db "%d %x %d", 13, 10, 0
    file_name db "output.txt", 0
    access_mode db "w", 0
    file_descriptor dd -1
    
; our code starts here
segment code use32 class=code
    start:
        ;printf(&message_n)
        push dword message_n
        call [printf]
        add ESP, 4*1
    
        ;scanf(&format, &n)
        push dword n
        push dword format
        call [scanf]
        add ESP, 4*2
        
        movzx EAX, byte [n]
        cmp EAX, 0
        je exit_program
        cmp EAX, 255
        ja exit_program
        
        mov ECX, EAX
        
        ;fopen(&file_name, &access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add ESP, 4*2
        
        ;verify if it opened the file correctly
        mov [file_descriptor], EAX
        cmp EAX, 0
        je exit_program 
        
        xor ESI, ESI ;index
        
        read_loop:
            ;read one number
            ;scanf(&format, &number)
            push dword number
            push dword format
            call [scanf]
            add ESP, 4*2
            
            ;add the number to the sum
            mov EDX, dword [sum]
            add EDX, dword [number]
            mov dword [sum], EDX
            
            mov EDX, [number]
                 
            sum_loop:
                ;sum of digits
                ;...
                mov dword [sum_n], 0
                jmp end_sum
                
            end_sum:
                ;fprintf(format_number, file_descriptor, &number, &number, sum_n)
                push dword [sum_n]
                push dword [number]
                push dword [number]
                push dword [file_descriptor]
                push dword format_number
                call [fprintf]
                add ESP, 4*5
                
                inc ESI
                jmp read_loop
                
        ;average
        mov EAX, [sum]
        mov EBX, [n]
        idiv EBX
                
        ;fprintf(&format, file_descriptor, &sum)
        push dword EAX
        push dword [file_descriptor]
        push dword format
        call [fprintf]  
        add ESP, 4*3            
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add ESP, 4*1
        
        exit_program:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
