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

    call chout

    inc bx              ; Increment BX
    jmp .loop

    jmp exit

.string:
    db "Hello World!",0
