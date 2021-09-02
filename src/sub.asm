    cpu 8086
    bits 16
    org 0x0100
    jmp start

%include 'library.inc'

start:
    mov al,0x04
    sub al,0x03  ; Subtract 0x03 from AL

    add al,0x30   ; Convert to ASCII digit
    call chout
    jmp exit