section .data
    Num dw 5                    ; num = 5; (16-bit word, like DC.W)
    Res dw 1                    ; res = 1; (16-bit word, like DC.W)
    newline db 10              ; newline character

section .bss
    buffer resb 10             ; Buffer to store the decimal ASCII string

section .text
    global _start
    
_start:
    ; MOVE Num, D0
    movzx eax, word [Num]      ; Load Num into EAX (D0 equivalent)
    
    ; Move Res, D1
    movzx ebx, word [Res]      ; Load Res into EBX (D1 equivalent)
    
LOOP:
    ; CMP #1, D0
    cmp eax, 1                 ; Compare EAX with 1
    
    ; BEQ END
    je END                     ; Jump to END if equal
    
    ; MULS D0, D1
    imul ebx, eax              ; Multiply EBX by EAX, store in EBX
    
    ; SUB #1, D0
    sub eax, 1                 ; Decrement EAX by 1
    
    ; JMP LOOP
    jmp LOOP                   ; Jump back to LOOP
    
END:
    ; MOVE D1, Res
    mov word [Res], bx         ; Store BX (lower 16 bits of EBX) into Res
    
    ; Convert the result to ASCII
    mov ax, word [Res]         ; Load result into AX
    mov rcx, 0                 ; Initialize digit counter
    mov rbx, 10                ; Divisor for decimal conversion
    
convert_loop:
    mov rdx, 0                 ; Clear remainder
    div rbx                    ; Divide RAX by 10, quotient in RAX, remainder in RDX
    add dl, '0'                ; Convert remainder to ASCII
    push rdx                   ; Save digit on stack
    inc rcx                    ; Increment digit counter
    test rax, rax              ; Check if quotient is zero
    jnz convert_loop           ; If not zero, continue conversion
    
    ; Stack now contains the digits in reverse order
    ; Move them to buffer in correct order
    mov rbx, buffer            ; Point to buffer
    
print_loop:
    pop rdx                    ; Get digit from stack
    mov [rbx], dl              ; Store in buffer
    inc rbx                    ; Increment buffer pointer
    dec rcx                    ; Decrement digit counter
    jnz print_loop             ; Continue until all digits are processed
    
    ; Calculate the length of the string
    mov rdx, rbx
    sub rdx, buffer            ; RDX = string length
    
    ; Print the result
    mov eax, 1                 ; syscall: write
    mov edi, 1                 ; file descriptor: stdout
    mov rsi, buffer            ; buffer to write
    syscall                    ; call kernel
    
    ; Print a newline
    mov eax, 1                 ; syscall: write
    mov edi, 1                 ; file descriptor: stdout
    mov rsi, newline           ; newline character
    mov rdx, 1                 ; length 1
    syscall                    ; call kernel
    
    ; Exit the program
    mov eax, 60                ; syscall: exit
    xor edi, edi               ; exit code 0
    syscall                    ; invoke operating system to exit
