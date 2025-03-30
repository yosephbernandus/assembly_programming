section .data
    filename db "sample.txt", 0
    msg db "Read bytes: ", 0
    newline db 10

section .bss
    buffer resb 1024    ; 1KB buffer
    fd resb 8           ; File descriptor
    bytes_read resb 8   ; Number of bytes read

section .text
global _start

_start:
    ; Open the file - sys_open (2)
    mov rax, 2          ; System call number for open
    mov rdi, filename   ; Filename
    mov rsi, 0          ; Flags (O_RDONLY)
    mov rdx, 0          ; Mode (not used for reading)
    syscall             ; Make the system call
    
    ; Save file descriptor
    mov [fd], rax
    
    ; Read from the file - sys_read (0)
    mov rax, 0          ; System call number for read
    mov rdi, [fd]       ; File descriptor
    mov rsi, buffer     ; Buffer to read into
    mov rdx, 1024       ; Number of bytes to read
    syscall             ; Make the system call
    
    ; Save bytes read
    mov [bytes_read], rax
    
    ; Close the file - sys_close (3)
    mov rax, 3          ; System call number for close
    mov rdi, [fd]       ; File descriptor
    syscall
    
    ; Exit the program - sys_exit (60)
    mov rax, 60         ; System call number for exit
    mov rdi, 0          ; Exit code
    syscall

