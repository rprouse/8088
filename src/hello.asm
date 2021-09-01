%include 'library.inc'

    cpu 8086
    bits 16
    org 0x0100
start:
    mov bx,.string       ; Load register BX with address of 'string'
.loop:
    mov al,[bx]         ; Load a byte in AL from address pointed by BX
    test al,al          ; Test AL for zero
    je exit             ; Jump if equal (jump if zero)
    push bx             ; Push BX to the stack
    mov ah,0x0e         ; Load AH with the code for terminal output
    mov bx,0x000f       ; BH is page zero, BL is color (graphics mode)
    int 0x10            ; Call the BIOS for displaying one letter
    pop bx              ; Restore BX from the stack
    inc bx              ; Increment BX
    jmp .loop

    jmp exit

.string:
    db "Hello World!",0
