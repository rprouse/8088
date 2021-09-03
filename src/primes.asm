; Calculate primes using the Sieve of Eratosthenes

    cpu 8086
    bits 16
    org 0x0100

table:      equ 0x8000
table_size: equ 1000

    jmp start

%include 'library.inc'

start:
    mov bx,table
    mov cx,table_size
    mov al,0

; Initialize the memory in the table to zero
.zero_loop:
    mov [bx],al         ; Write AL to the address pointed to by BX
    inc bx
    loop .zero_loop     ; Decrease CX and jump if non-zero

    mov ax,2            ; Start at first prime, 2. AX is the prime we are testing
.check_prime:
    mov bx,table        ; Set BX to the table address
    add bx,ax           ; Add the last prime to BX
    cmp byte [bx],0     ; Is it a prime? If it is still 0, we haven't marked it as a multiple
    jne .next

    push ax             ; This is a prime, display it
    call display_number
    mov al,','
    call chout
    pop ax

    mov bx,table
    add bx,ax
.mark_multiples:
    add bx,ax           ; Next multiple of AX
    cmp bx,table+table_size
    jg .next            ; Make sure we're not at the end of the table
    mov byte [bx],1     ; Set the value as not-prime in the table
    jmp .mark_multiples ; Back and multiply again

.next:
    inc ax              ; Increment AX to the next number to check
    cmp ax,table_size   ; Make sure we are not at the end
    jne .check_prime

    jmp exit