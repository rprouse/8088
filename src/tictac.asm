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
    call .find_line
    call .get_move
    mov byte [bx],'X'
    call .show_board
    call .find_line
    call .get_move
    mov byte [bx],'O'
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
    mov al,0xb3     ; Graphic |
    call chout
    call .show_square
    mov al,0xb3     ; Graphic |
    call chout
    call .show_square
    call .show_crlf
    ret

.show_div:
    mov al,0xc4     ; Graphic -
    call chout
    mov al,0xc5     ; Graphic +
    call chout
    mov al,0xc4     ; Graphic -
    call chout
    mov al,0xc5     ; Graphic +
    call chout
    mov al,0xc4     ; Graphic -
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

.find_line:
    ; First horizontal row
    mov al,[board]    ; X.. ... ...
    cmp al,[board+1]  ; .X. ... ...
    jne .find_second_line
    cmp al,[board+2]  ; ..X ... ...
    je .win

.find_second_line:
    ; Second horizontal row
    mov al,[board+3]  ; ... X.. ...
    cmp al,[board+4]  ; ... .X. ...
    jne .find_third_line
    cmp al,[board+5]  ; ... ..X ...
    je .win

.find_third_line:
    ; Third horizontal row
    mov al,[board+6]  ; ... ... X..
    cmp al,[board+7]  ; ... ... .X.
    jne .find_first_column
    cmp al,[board+8]  ; ... ... ..X
    je .win

.find_first_column:
    ; First vertical column
    mov al,[board]    ; X.. ... ...
    cmp al,[board+3]  ; ... X.. ...
    jne .find_second_column
    cmp al,[board+6]  ; ... ... X..
    je .win

.find_second_column:
    ; Second vertical column
    mov al,[board+1]  ; .X. ... ...
    cmp al,[board+4]  ; ... .X. ...
    jne .find_third_column
    cmp al,[board+7]  ; ... ... .X.
    je .win

.find_third_column:
    ; Third vertical column
    mov al,[board+2]  ; ..X ... ...
    cmp al,[board+5]  ; ... ..X ...
    jne .find_first_diagonal
    cmp al,[board+8]  ; ... ... ..X
    je .win

.find_first_diagonal:
    ; First diagonal
    mov al,[board]    ; X.. ... ...
    cmp al,[board+4]  ; ... .X. ...
    jne .find_second_diagonal
    cmp al,[board+8]  ; ... ... ..X
    je .win

.find_second_diagonal:
    ; Second diagonal
    mov al,[board+2]  ; ..X ... ...
    cmp al,[board+4]  ; ... .X. ...
    jne .check_tie
    cmp al,[board+6]  ; ... ... X..
    je .win

.check_tie:
    mov bx,board
    mov cx,9
.check_tie_loop:
    cmp byte [bx],0x40     ; Does the square contain an ASCII letter or digit
    jl .finish        ; If we find a number, there are open squares
    inc bx
    loop .check_tie_loop

    ; Tie
    mov al,'T'
    call chout
    mov al,'i'
    call chout
    mov al,'e'
    call chout
    mov al,' '
    call chout
    mov al,'g'
    call chout
    mov al,'a'
    call chout
    mov al,'m'
    call chout
    mov al,'e'
    call chout
    call .show_crlf
    jmp exit

.finish:
    ret

.win:
    ; AL contains the letter that won the game
    call chout
    mov al,' '
    call chout
    mov al,'W'
    call chout
    mov al,'i'
    call chout
    mov al,'n'
    call chout
    mov al,'s'
    call chout
    mov al,'!'
    call chout
    call .show_crlf
    jmp exit