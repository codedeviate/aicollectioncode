.global _start
.align 2

_start:
    // Write the message to stdout
    mov x0, 1          // File descriptor 1 is stdout
    adr x1, msg        // Address of the message
    mov x2, #14        // Length of the message (13 bytes)
    mov x16, #4        // sys_write system call number
    svc #0x80          // Make the system call

    // Exit the program
    mov x0, #0         // Exit status 0
    mov x16, #1        // sys_exit system call number
    svc #0x80          // Make the system call

msg:    .ascii "Hello, World!\n"
