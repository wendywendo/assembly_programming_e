This README explains how the `SUB` and `SBB` instruction affect CPU flags.

## `sub1.asm`

### Flags set:
- **Carry Flag (CF)**
- **Parity Flag (PF)**
- **Sign Flag (SF)**
- **Interrupt Flag (IF)**

### Calculation

```text
50  = 0011 0010
80  = 0101 0000
      ---------
sub = 1110 0010 (-30)
```

### Why are the flags set?

#### 1. Carry Flag (CF)
For subtraction, CF indicates a borrow.

Since 50 is less than 80, a borrow was needed.

Therefore:

```text
CF = 1
```

#### 2. Parity Flag (PF)
The number of 1's in the result is `4`, which is even, hence:

```text
PF = 1
```

#### 3. Sign Flag (SF)
The leftmost bit (bit 7) is set to `1`.

Hence:

```text
SF = 1
```

### Why are the other flags cleared?

#### 1. Overflow Flag (OF)
OF checks for **signed overflow**.

For an 8-bit signed number, the range is from `-128 to +127`.

Since the result, `-30`, is within the signed 8-bit range:

```text
OF = 0
```

#### 2. Zero Flag (ZF)

The result, `1110 0010` is not zero.

Therefore:

```text
ZF = 0
```

#### 3. Auxiliary Carry Flag (AF)
There is no borrow needed from bit 3 to bit 4. 

Hence:

```text
AF = 0
```

---

## `sub2.asm`

### Flags set:
- **Carry Flag (CF)**
- **Parity Flag (PF)**
- **Sign Flag (SF)**
- **Interrupt Flag (IF)**


### Calculation

```text
1000 = 0000 0011 1110 1000
2000 = 0000 0111 1101 0000
       -------------------
sub  = 1111 1100 0001 1000 (-1000)
```

### Why are the flags set?

#### 1. Carry Flag (CF)
CF indicates a borrow.

Since `1000 < 2000`, a borrow is required.

Therefore:

```text
CF = 1
```

#### 2. Parity Flag (PF)

**Important:** PF only checks the **lowest 8 bits**, not all 16 bits.

Since the number of 1's in the lower 8 bits are `2`, which is even:

```text
PF = 1
```

#### 3. Sign Flag (SF)
The MSB in the result is `1`, hence:

```text
SF = 1
```

### Why are other flags cleared?

#### 1. Overflow Flag (OF)
OF checks for a **signed overflow**.

A signed 16-bit number can hold `-32678 to +32767`.

Since the result is `-1000`, it fits within the range.

Therefore:

```text
OF = 0
```

#### 2. Zero Flag (ZF)
The result is not zero.

Therefore:

```text
ZF = 0
```


#### 3. Auxiliary Carry Flag (AF)
There is no borrow needed from bit 3 to 4. 

Therefore:

```text
AF = 0
```

---

## `sub3.asm`

## After SUB

### Flags set
- **Carry Flag (CF)**
- **Parity Flag (PF)**
- **Auxiliary Carry Flag (AF)**
- **Sign Flag (SF)**
- **Interrupt Flag (IF)**

### Calculation

```text
  0000 0000 0000 0000
- 0000 0000 0000 0001
---------------------
  1111 1111 1111 1111 (-1)
```

### Why are the flags set?

#### 1. Carry Flag (CF)

Since `0 < 1`, a borrow was needed.

Hence:

```text
CF = 1
```

#### 2. Sign Flag (SF)
The left most bit (MSB) of the result is `1`. 

Therefore:

```text
SF = 1
```

#### 3. Parity Flag (PF)
PF only checks the lowest 8 bits, not all 16 bits.

Since the number of 1's in the lower 8 bits are 8, which is even:

```text
PF = 1
```

#### 4. Auxiliary Carry Flag (AF)
There is a borrow from bit 3 to bit 4 (lower nibble).

Hence:

```text
AF = 1
```

### Why are some flags cleared?

#### 1. Zero Flag (ZF)
The result is not 0, hence:

```text
ZF = 0
```

#### 2. Overflow Flag (OF)
The result, `-1`.

The signed 16-bit range is `-128 to +127`.

Since `-1` is within this range, there is no signed overflow.

Therefore:

```text
OF = 0
```

--- 


## After SBB

The instruction is:

```asm
sbb ax, 0
```

SBB calculates:

```text
AX = AX - 0 - CF
```

Since `CF = 1`:

```text
  1111 1111 1111 1111
- 0000 0000 0000 0001
---------------------
= 1111 1111 1111 1110 (-2)
```

### Flags after SBB

#### Sign Flag (SF) 
The left-most bit is `1`.

```text
SF = 1
```

#### Zero Flag (ZF) 

The result is not zero.

```text
ZF = 0
```

#### Carry Flag (CF) 
There is no borrow required.

```text
CF = 0
```

#### Overflow Flag (OF) 
The result is `-2` which fits within the signed 16-bit range: `-32768 to +32767`.

Therefore:

```text
OF = 0
```

#### Parity Flag (PF)
PF checks only the lowest 8 bits: `1111 1110`.

The lower 8 bits has 7 ones, which is odd.

Therefore:

```text
PF = 0
```

#### Auxiliary Flag (AF) 
No borrow is needed from bit 3 to bit 4.

Therefore:

```text
AF = 0
```

---

## What about the Interrupt Flag (IF)?
The `SUB` and `SBB` instruction does not modify the Interrupt Flag.

On normal x86 execution, IF is normally enabled `(IF = 1)` so that the processor can respond to maskable interrupts.