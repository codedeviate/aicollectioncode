.section __TEXT,__text,regular,pure_instructions
.globl _start

_start:
    // Write "Hello, World!" to stdout
    mov x0, #1                  // file descriptor (stdout)
    ldr x1, =message            // message to write
    mov x2, #13                 // message length
    mov x16, #4                 // syscall number (sys_write)
    svc #0                      // make syscall

    // Exit the program
    mov x0, #0                  // exit code
    mov x16, #1                 // syscall number (sys_exit)
    svc #0                      // make syscall

.section __TEXT,__cstring,cstring_literals
message:
    .asciz "Hello, World!"
