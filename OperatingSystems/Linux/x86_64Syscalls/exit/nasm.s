section .text
global _start

_start:
    mov rax, 60         ; Syscall number for exit
    xor rdi, rdi        ; Exit code 0
    syscall             ; Invoke the syscall
