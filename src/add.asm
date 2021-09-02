    cpu 8086
    bits 16
    org 0x0100
    jmp start

%include 'library.inc'

start:
    mov al,0x04
    add al,0x03

    add al,0x30   ; Convert to ASCII digit
    call char_out
    jmp exit