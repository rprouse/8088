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
- `test reg,imm` - Bitwise compare of register and constant or zero (same as AND but without modifying the register)
- `jz label` - Jump if bits were not set ("zero")
- `jnz label` - Jump if bits were set ("not zero")

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

- `int` - Call a BIOS subroutine
-
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

- `0x10` - Output a character in `AL` to the screen
- `0x16` - Get a character from the keyboard