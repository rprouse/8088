; Read from the keyboard and echo to the screen
    cpu 8086
    bits 16
    org 0x0100
    jmp start

%include 'library.inc'

start:
    call char_in

    cmp al,0x1b         ; ESC key pressed?
    je exit

    call char_out
    jmp start

    jmp exit
