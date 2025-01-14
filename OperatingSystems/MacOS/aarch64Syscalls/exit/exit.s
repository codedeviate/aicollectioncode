    .global _main         ; Declare the entry point of the program

    .text                 ; The section where code resides
_main:
    mov x0, #0            ; Exit code 0 (set x0 register to 0)
    mov x16, #1           ; Syscall number for exit (1 is the exit syscall for macOS AArch64)
    svc #0                ; Make the syscall
