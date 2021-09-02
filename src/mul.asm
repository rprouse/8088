    cpu 8086
    bits 16
    org 0x0100
    jmp start

%include 'library.inc'

start:
    mov al,0x03
    mov cl,0x02
    mul cl        ; Multiply AL by 0x02

    add al,0x30   ; Convert to ASCII digit
    call chout
    jmp exit