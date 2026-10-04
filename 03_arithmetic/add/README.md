This README explains the CPU flags affected by the `ADD` and `ADC` instructions in the 3 assembly programs in the folder `add`.

---

# `add1.asm`

```text
120 in binary = 01111000
 10 in binary = 00001010
                --------
Addition      = 10000010
```

### Flags Set
- **Parity Flag (PF)**
- **Auxiliary Carry Flag (AF)**
- **Sign Flag (SF)**
- **Interrupt Flag (IF)**
- **Overflow Flag**

### Auxiliary Carry Flag (AF)
There is a carry from the lower nibble. Hence:
```text
AF = 1
```

### Parity Flag (PF)
The number of 1's is 2 which is even. Hence:
```text
PF = 1
```

### Sign Flag (SF)
The left-most bit (MSB) of the result is 1. Hence:
```text
SF = 1
```

### Overflow Flag (OF)
For a signed 8-bit number, the range is:
```text
-128 to +127
```

The addition is `+130`.

Hence, from a signed perspective, `+130` is interpreted as `-126`.

Since, the addition of 2 positive numbers produced a negative result, **signed overflow occured** and therefore:

```text
OF = 1
```

### Interrupt Flag (IF)
The `ADD` instruction does not modify the Interrupt Flag.
On normal x86 execution, IF is normally enabled `(IF = 1)` so that the processor can respond to maskable interrupts.


---

# `add2.asm`

```text
num1 = 32000
num2 = 500
addition = 32500

32000 = 0111 1101 0000 0000
  500 = 0000 0001 1111 0100
        -------------------
32500 = 0111 1110 1111 0100
```

### Flags Set
- **Interrupt Flag (IF)**

### Why are other flags not set?
#### 1. Carry Flag (CF)
There is no carry from the leftmost bit (bit 15).

#### 2. Parity Flag (PF)
The number of 1's is **11** which is odd. Hence,

```text
PF = 0
```

#### 3. Auxiliary Carry Flag (AF)
There is no carry from the 3rd to 4th bit (lower nibble)
Therefore:
```text
AF = 0
```

#### 4. Zero Flag (ZF)
The result is not zero, hence:
```text
ZF = 0
```

#### 5. Sign Flag (SF)
The left most bit after addition is `0`, hence: 
```text
SF = 0
```

#### 6. Overflow Flag (OF)
The signed 16-bit range is `-32678 to +32767`
Both numbers are positive, hence the result `32500` is still within the signed 16-bit range.
Therefore:
```text
0F = 0
```

---

# `add3.asm`

## Before `ADC`
```text
    num1 =   1111 1111 1111 1111
    num2 =   0000 0000 0000 0001
             -------------------
addition = 1 0000 0000 0000 0000
```

### Flags set after `ADD`
- **Carry Flag (CF)**
- **Parity Flag (PF)**
- **Auxiliary Carry Flag (AF)**
- **Zero Flag (ZF)**
- **Interrupt Flag (IF)**

### Carry Flag (CF)
AX can only hold **16 bits**, so leftmost `1` does not fit. Therefore:
```text
CF = 1
```

### Zero Flag (ZF)
The result is `0`, therefore:
```text
ZF = 1
```

### Sign Flag (SF)
The MSB is `0`. Therefore:
```text
SF = 0
```

### Overflow Flag (OF)
There is no signed overflow. The signed interpretation of `0xFFFF` (1111 1111 1111 1111) is -1. `-1 + 1 = 0` which fits in the range `-32678 to +32678` for a signed number. Hence:
```text
OF = 0
```

### Parity Flag (PF)
The number of 1's in the result is `0`, which is even. Hence:

```text
PF = 1
```

### Auxiliary Carry Flag (AF)
There is a carry from bit 3 to bit 4. 
Hence:
```text
AF = 1
```

### Interrupt Flag (IF)
IF is not modified by the `ADD instruction`

---

# After `ADC`

Before `ADC`:
```text
AX = 0000 0000 0000 0000
CDF = 1
```

`ADC` performs `AX = AX + 0 + CF`
Therefore:
```text
AX = 0000 0000 0000 0000 + 0 + 1 
   = 0000 0000 0000 0001  
```

### Flags After `ADC`
|Flag | Meaning | Description |
|---|---|---|
| **CF** | Carry Flag | There is no carry out of the MSB. Hence: `CF = 0` |
| **ZF** | Zero Flag | The result is `1` hence `ZF = 0` |
| **SF** | Sign Flag | The MSB is `0` hence `SF = 0` |
| **PF** | Parity Flag | The result contains an odd number of 1's (one `1`) hence `PF = 0` |
| **OF** | Overflow Flag | There is no signed overflow, hence `OF = 0` |

