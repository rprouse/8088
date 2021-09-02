    cpu 8086
    bits 16
    org 0x0100
    jmp start

%include 'library.inc'

start:
    mov al,0x30
.count1:
    call chout
    inc al
    cmp al,0x39
    jl .count1

.count2:
    call chout
    dec al
    cmp al,0x30
    jge .count2

    jmp exit