# 8080/8088 Assembly Notes

## Instructions

### Load, Store, Compare

- `mov dest,src` - Move a value to,from register or memory, `mov eax,10`

### Branching

- `cmp b,a` - Compare two values
- `je label` - Jump if equal
- `jne label` - Jump if not equal
- `jg label` - Jump if b > a
- `jge label` - Jump if b >= a
- `jl label` - Jump if b < a
- `jle label` - Jump if b <= a
- `jnc label` - Jump if carry is not set
- `test reg,imm` - Bitwise compare of register and constant or zero (same as AND but without modifying the register)
- `jz label` - Jump if bits were not set ("zero")
- `jnz label` - Jump if bits were set ("not zero")
- `loop label` - Decrease CX and jump if non-zero

### Increment and Decrement

- `inc dest` - Increments a register/memory, `inc eax`
- `dec dest` - Decrements a register/memory, `dec word [0x1000]`

### Arithmetic

- `add dest,src` - dest = dest + src
- `sub dest,src` - dest = dest - src
- `mul reg` - unsigned multiplication, edx:eax = eax * reg
- `imul reg` - signed multiplication, edx:eax = eax * reg
- `div reg` - unsigned division, edx = edx:eax % reg, eax = edx:eax / reg
- `idiv reg` - unsigned division, edx = edx:eax % reg, eax = edx:eax / reg

### Logical Operators

- `and dest,src` - dest = src & dest, `and ebx,eax`
- `or dest,src` - dest = src | dest, `or eax,[0x2000]`
- `xor dest,src` - dest = src ^ dest, `xor ebx,0xffffffff`
- `not reg` - reg = ~reg
- `neg reg` - reg = -reg

### Rotational Operators

- `shl dest,count` - dest = dest << count, `shl al,1`. Carry flag set to high bit. Low bit becomes 0.
- `sal dest,count` - synonym for `shl`
- `shr dest,count` - dest = dest >> count, `shr dword[eax],4`. Carry flag set to low bit. High bit becomes 0.
- `sar dest,count` - Same as `shr` except the high bit remains the same. It is a signed shift right.
- `ror dest,count` - Rotate bits right directly
- `rcr dest,count` - Rotate bits right through carry bit
- `rol dest,count` - Rotate bits left directly
- `rcl dest,count` - Rotate bits left through carry bit

### Transfer

### Set and Clear Status Bits

### Stack

- `push src` - Pushes register/value to the stack
- `pop dest` - Pops a register/value from the stack

### Misc

- `jmp label` - Relative jump to location
- `jmp reg` - Absolute jump to location in register
- `call func` - Call a subroutine
- `ret` - Return from subroutine
- `nop` - No-op, opcode 0x90
- `hlt` - Halt the CPU

### Interupts

- `int addr` - Call a BIOS subroutine
- `in reg,(addr)` - Read from a port

## Addressing Modes

## Status Flags

## Registers

| Register | High | Low | Common Use |
| -------- | ---- | --- | ---------- |
| AX       | AH   | AL  | Accumulator |
| BX       | BH   | BL  | Address |
| CX       | CH   | CL  | Counter |
| DX       | DH   | DL  | 32-bit extension of AX |
| SI       |      |     | Source Address |
| DI       |      |     | Destination Address |
| BP       |      |     | Base pointer along with SP |
| SP       |      |     | Stack Pointer |
| Flags    |      |     | State of last instruction affecting flags |

## BIOS Routines

- `0x10` - Video services
  - `AH = 0x00` Set video mode
    - `AL = 0x02` Text 80x25 color, data segment 0xb800
    - `AL = 0x12` VGA 640x480x16 color, data segment 0xa000
    - `AL = 0x13` VGA 320x240x256 color, data segment 0xa000
  - `AH = 0x0e` Display letter in AL to terminal. Set `BH = 0x00` and `BL = 0x0f`
- `0x13` - Disk services
  - `AH = 0x02` Read Sector from floppy or hard drive. On return, carry bit is error.
    - `AL` number of sectors to read
    - `CH` low byte of cylinder number
    - `CL` sector number (bits 0-5) and high two bits of cylinder (bits 7-6)
    - `DH` head number
    - `DL` drive number (0x00 A:, 0x01 B:, 0x80 hdd 1, 0x81 hhd 2)
    - `ES:BX` data buffer
  - `AH = 0x03` Write sector to floppy or hdd. On return, carry bit is error.
    - `AL` number of sectors to write
    - `CH` low byte of cylinder number
    - `CL` sector number (bits 0-5) and high two bits of cylinder (bits 7-6)
    - `DH` head number
    - `DL` drive number (0x00 A:, 0x01 B:, 0x80 hdd 1, 0x81 hhd 2)
    - `ES:BX` data buffer
- `0x16` - Keyboard services
  - `AH = 0x00` Get key, AH is BIOS scan code and AL is ASCII char
  - `AH = 0x01` Check if a key is available without emptying buffer, AH is BIOS scan code and AL is ASCII char
  - `AH = 0x02` Get keyboard flags to AL
    - `bit 0 == 1` right shift pressed
    - `bit 1 == 1` left shift pressed
    - `bit 2 == 1` ctrl key pressed
    - `bit 3 == 1` alt key pressed
    - `bit 4 == 1` scroll lock down
    - `bit 5 == 1` num lock down
    - `bit 6 == 1` caps lock down
    - `bit 7 == 1` insert on
- `0x19` - Bootstrap loader
- `0x1A` - Time services
  - `AH = 0x00` Get system time, num ticks since midnight to `CX:DX`
- `0x20` - Terminate program