    .global _start          # Declare the entry point of the program

    .text                   # The section where code resides
_start:
    mov $60, %rax           # Syscall number for exit (60 is the exit syscall)
    xor %rdi, %rdi          # Exit code 0 (xor %rdi, %rdi is a compact way to zero %rdi)
    syscall                 # Make the syscall
