; Guess a number between 0 and 7
    cpu 8086
    bits 16
    org 0x0100
    jmp start

%include 'library.inc'

start:
    in al,(0x40)    ; Read the timer counter chip
    and al,0x07     ; Mask bits to get 0 to 7
    add al,0x30     ; Convert to ASCII
    mov cl,al       ; Move AL into CL

.game_loop:
    mov al,'?'
    call chout
    call chin
    cmp al,cl       ; Did you guess right?
    jne .game_loop

    mov al,':'
    call chout
    mov al,')'
    call chout

    jmp exit