; Read from the keyboard and echo to the screen
    org 0x0100
start:
    mov ah,0x00         ; keyboard read
    int 0x16            ; Call the BIOS to read it

    cmp al,0x1b         ; ESC key pressed?
    je exit

    mov ah,0x0e         ; Load AH with the code for terminal output
    mov bx,0x000f       ; BH is page zero, BL is color (graphics mode)
    int 0x10            ; Call the BIOS for displaying one letter
    jmp start

exit:
    int 0x20
