This README explains the CPU flags affected by the `MUL` and `IMUL` instructions in the 3 assembly programs in the folder `mul`.

`MUL` and `IMUL` affect:
- **Carry Flag (CF)**
- **Overflow Flag (OF)**

The other arithmetic flags (`AF`, `PF`, `SF` and `ZF`) are **undefined**.

> **Note:** The Interrupt Flag (IF) is not affected by `MUL` or `IMUL`.

---

## `mul1.asm`

### Flags set:
- **Interrupt Flag (IF)**

### Binary Representation

```text
25 = 0001 1001
10 = 0000 1010
```

After multiplication:

```text
250 = 0000 0000 1111 1010
      |_______| |_______|
        AH          AL
```

### CF and OF
Since, `AH` is 0, the result fits within the original 8-bit operand size.
Therefore:

```text
CF = 0
OF = 0
```

- **Carry Flag (CF) = 0** because the upper half of the result (`AH`) is `0000 0000`.
- **Overflow Flag (OF) = 0** because the result(`250`) does not require more than 8 bits.

---

## `mul2.asm`

### Flags set:
- **Carry Flag (CF)**
- **Interrupt Flag (IF)**
- **Overflow Flag (OF)**

### Binary Representation

```text
3000 = 0000 1011 1011 1000
 200 = 0000 0000 1100 1000
```

After multiplication:
```text
600000 = 0000 0000 0000 1001 0010 0111 1100 0000
```

Therefore:

```text
DX = 0000 0000 0000 1001
AX = 0010 0111 1100 0000
```

### CF and OF
Since `DX` is not 0, the result does not fit within **16 bits**. 
Therefore:

```text
CF = 1
OF = 1
```

- **Carry Flag (CF) = 1** because the upper half of the result (`DX`) is non-zero.
- **Overflow Flag (OF) = 1** because the result does not fit within the original 16-bit operand size.

---

## `mul3.asm`

### Flags set:
- **Carry Flag (CF)**
- **Interrupt Flag (IF)**
- **Overflow Flag (OF)**

### Binary Representation

```text
100000 * 300000 = 30,000,000,000
```

Therefore:
```text
EDX = 00000000 00000000 00000000 00000110
EAX = 11111100 00100011 10101100 00000000
```

### CF and OF

For a 32-bit `MUL`, CF and OF check whether the upper 32 bits (`EDX`) are zero.

Since `EDX` is not zero, it means the result did not fit into the lower 32 bits.

Therefore:
```text
CF = 1
OF = 1
```

- **Carry Flag (CF) = 1** because the upper half of the result (`EDX`) is non-zero.
- **Overflow Flag (OF) = 1** because the result does not fit within the original 32-bit operand size.