%include 'library.inc'

; Read from the keyboard and echo to the screen
    cpu 8086
    bits 16
    org 0x0100
start:
    call chin

    cmp al,0x1b         ; ESC key pressed?
    je exit

    call chout
    jmp start

    jmp exit
