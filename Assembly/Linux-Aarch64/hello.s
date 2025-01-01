.section __TEXT,__text,regular,pure_instructions
.globl _start

_start:
    // Write "Hello, World!" to stdout
    movz x16, #0x4              // Load lower 16 bits of syscall number (macOS sys_write)
    movk x16, #0x2000, lsl #16  // Load upper 16 bits
    mov x0, #1                  // file descriptor (stdout)
    adrp x1, message            // Load the page address of the message
    add x1, x1, :lo12:message   // Add the page offset to get the full address
    mov x2, #13                 // message length
    svc #0                      // make syscall

    // Exit the program
    movz x16, #0x1              // Load lower 16 bits of syscall number (macOS sys_exit)
    movk x16, #0x2000, lsl #16  // Load upper 16 bits
    mov x0, #0                  // exit code
    svc #0                      // make syscall

.section __TEXT,__cstring,cstring_literals
message:
    .asciz "Hello, World!"
