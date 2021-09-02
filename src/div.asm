    cpu 8086
    bits 16
    org 0x0100
    jmp start

%include 'library.inc'

start:
    mov al,0x64
    mov cl,0x21
    div cl        ; Divide AL by CL, result => AL, remainder => AH

    add al,0x30   ; Convert to ASCII digit
    call chout

    push ax
    mov al,0x0D   ; CR
    call chout
    mov al,0x0A   ; LF
    call chout
    pop ax

    mov al,ah     ; Look at the remainder
    add al,0x30   ; Convert to ASCII digit
    call chout

    jmp exit