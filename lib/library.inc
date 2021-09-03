exit:
    int 0x20            ; Exit to the command line

; Display a letter contained in AL
chout:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov ah,0x0e         ; Load AH with the code for terminal output
    mov bx,0x000f       ; BH is page zero, BL is color (graphics mode)
    int 0x10            ; Call the BIOS for displaying one letter
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; Read keyboard into AL
chin:
    push bx
    push cx
    push dx
    push si
    push di
    mov ah,0x00         ; keyboard read
    int 0x16            ; Call the BIOS to read it
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    ret

; Display the value of AX as a decimal number
display_number:
    mov dx,0
    mov cx,10
    div cx              ; AX = DX:AX / CX
    push dx
    cmp ax,0
    je .display_digit
    call display_number ; Recursively call to pull off the next digit

.display_digit:
    pop ax
    add al,'0'          ; Convert the remainder to ASCII digit
    call chout
    ret