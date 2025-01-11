section .data
    msg db 'Hello, World!', 0xA   ; Define the string with a newline character (0xA)

section .text
    global _start                  ; Declare the entry point

_start:
    ; sys_write (1 = file descriptor for stdout)
    mov rax, 1                     ; syscall number for sys_write
    mov rdi, 1                     ; file descriptor (1 = stdout)
    mov rsi, msg                   ; pointer to the message
    mov rdx, 14                    ; message length
    syscall                        ; invoke syscall

    ; sys_exit (0 = exit status)
    mov rax, 60                    ; syscall number for sys_exit
    xor rdi, rdi                   ; exit code (0)
    syscall                        ; invoke syscall
