; Tic-Tac-Toe
    cpu 8086
    bits 16
    org 0x0100

board:  equ 0x0300

    jmp start

%include 'library.inc'

start:
.init:
    ; Populate the board with the numbers 1-9
    mov bx,board
    mov cx,9
    mov al,'1'
.init_loop:
    mov [bx],al
    inc al
    inc bx
    loop .init_loop

.game_loop:
    call .show_board
    call .get_move
    mov byte [bx],'X'
    call .show_board
    call .get_move
    mov byte [bx],'06'
    jmp .game_loop

.get_move:
    call chin
    cmp al,0x1b       ; ESC pressed?
    je exit

    ; Validate input
    sub al,'1'        ; Convert ASCII to decimal
    jc .get_move      ; If it is less than, invalid, get next char
    cmp al,0x09
    jge .get_move     ; If >= 9, invalid, get next char

    cbw               ; Expand AL to 16 bits using AH
    mov bx,board
    add bx,ax         ; Get the offset into the board
    mov al,[bx]       ; Get the content of the square
    cmp al,'@'        ; ASCII letter before A, IE, is this a letter or number
    jg .get_move      ; This square is taken, try again
    call .show_crlf
    ret

.show_board:
    mov bx,board
    call .show_row
    call .show_div
    mov bx,board+3
    call .show_row
    call .show_div
    mov bx,board+6
    call .show_row
    ret

.show_row:
    call .show_square
    mov al,'|'
    call chout
    call .show_square
    mov al,'|'
    call chout
    call .show_square
    call .show_crlf
    ret

.show_div:
    mov al,'-'
    call chout
    mov al,'+'
    call chout
    mov al,'-'
    call chout
    mov al,'+'
    call chout
    mov al,'-'
    call chout
    call .show_crlf
    ret

.show_square:
    mov al,[bx]
    inc bx
    call chout
    ret

.show_crlf:
    mov al,0x0d
    call chout
    mov al,0x0a
    call chout
    ret