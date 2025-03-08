section .text
    global _start
    
_start:
    ; Evaluate: 2 + 4 * 3 - 6
    
    ; MOVE #2, D0
    mov eax, 2              ; Store 2 in EAX (D0 equivalent)
    
    ; MOVE #4, D1
    mov ebx, 4              ; Store 4 in EBX (D1 equivalent)
    
    ; MOVE #3, D2
    mov ecx, 3              ; Store 3 in ECX (D2 equivalent)
    
    ; MOVE #6, D3
    mov edx, 6              ; Store 6 in EDX (D3 equivalent)
    
    ; MULS D1, D2   ; D2 := 12
    imul ecx, ebx           ; Multiply ECX by EBX, store in ECX (4 * 3 = 12)
    
    ; ADD D0, D2    ; D2 := 14
    add ecx, eax            ; Add EAX to ECX (12 + 2 = 14)
    
    ; SUB D3, D2    ; D2 := 8
    sub ecx, edx            ; Subtract EDX from ECX (14 - 6 = 8)
    
    ; Push the result that is in D2 to the stack
    ; MOVE D2, -(SP)
    push rcx                ; Push RCX onto the stack (using 64-bit register)
    
    ; MOVE (SP)+, D7
    pop r8                  ; Pop from stack into R8 (D7 equivalent)
    
    ; Exit program
    mov eax, 60             ; syscall: exit
    xor edi, edi            ; exit code 0
    syscall                 ; invoke operating system to exit

