    .section .text
    .global _start

_start:
    mov $60, %rax       # Syscall number for exit
    xor %rdi, %rdi      # Exit code 0
    syscall             # Invoke the syscall
