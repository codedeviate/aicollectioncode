    .data
    /* Define the message string and calculate its length.
       The string "Hello, World!\n" will be written to stdout,
       and we calculate its length using the assembler's ability
       to determine the difference between the current position and
       the start of the string. */
msg:
    .ascii "Hello, World!\n"  /* The message string */
len = . - msg   /* Calculate the length of the message by subtracting the address of 'msg' from the current address */

    .text
    .globl _start   /* Declare the entry point of the program */

_start:
    /* Step 1: Perform the syscall to write the message to stdout.
       This is the 'write' syscall (number 64 on Linux ARM64).
       The arguments are:
       - x0: file descriptor (1 for stdout)
       - x1: pointer to the message (address of 'msg')
       - x2: length of the message (calculated as 'len')
       We invoke the syscall with 'svc #0' (supervisor call). */
    mov     x0, #1          /* Set file descriptor to 1 (stdout) */
    ldr     x1, =msg        /* Load the address of 'msg' into x1 (buffer) */
    ldr     x2, =len        /* Load the length of the message into x2 (count) */
    mov     x8, #64         /* Set the syscall number for 'write' (64) in x8 */
    svc     #0              /* Make the syscall (invoke write) */

    /* Step 2: Perform the syscall to exit the program.
       This is the 'exit' syscall (number 93 on Linux ARM64).
       The arguments are:
       - x0: exit status (0 for success)
       We invoke the syscall with 'svc #0' again. */
    mov     x0, #0          /* Set the exit status to 0 (success) */
    mov     x8, #93         /* Set the syscall number for 'exit' (93) in x8 */
    svc     #0              /* Make the syscall (invoke exit) */
