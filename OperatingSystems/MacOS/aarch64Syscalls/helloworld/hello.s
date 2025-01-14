    .global _start          ; Declare the entry point of the program
    .align 2                ; Align the next data to a 4-byte boundary

_start:
    ; Write system call (syscall number 4 in X16, parameters in X0, X1, X2)
    mov X0, #1              ; File descriptor 1 (stdout)
    adr X1, helloworld      ; Load the address of the "Hello, World!" string into X1
    mov X2, #14             ; The length of the string (14 bytes)
    mov X16, #4             ; Syscall number for 'write' (4 in X16 for AArch64)
    svc #0x80               ; Make the system call (writes to stdout)

    ; Exit system call (syscall number 1 in X16, exit code in X0)
    mov X0, #0              ; Exit code 0 (success)
    mov X16, #1             ; Syscall number for 'exit' (1 in X16)
    svc #0x80               ; Make the system call (exits the program)

; Data section
helloworld:
    .ascii  "Hello, World!\n"  ; The string to print
