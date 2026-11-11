# 06.asm

**Initial `esp` value**: `0xffffc6f0`

Each register in this program (`eax` and `ebx`) is 32 bits in size (4 bytes). Therefore, each PUSH decreases `esp` by 4 bytes while each POP increases it by 4 bytes.

## Program run

`mov eax, 0x11223344`

This moves the hexadecimal value `0x11223344` into `eax`

`eax` thus becomes `0x11223344` or `287454020` in decimal.

---

`mov ebx, 0x1234`

This moves the hexadecimal value `0x1234` into `ebx`

The new value in `ebx` thus becomes `0x1234` or `4660` in decimal.

`push eax`

This pushes the value in `eax` (`0x11223344`) onto the stack.

`esp` thus decreases by 4 bytes to become `0xffffc6ec`.

**Current stack**

```text
    [ 0x11223344 ]  <-- Top
```

---

`push ebx`

This pushes the value in `ebx` (`0x1234`) onto the stack.

`esp` thus decreases by 4 bytes to become `0xffffc6e8`.

**Current stack**

```text
    [ 0x1234     ]  <-- Top
    [ 0x11223344 ]
```

---

`pop ebx`

This retrieves the value at the top of the stack and places it into `ebx`

`ebx` thus becomes `0x1234` or `4660` (in decimal)

`esp` then increases by 4 bytes to become `0xffffc6ec`.

**Current stack**

```text
    [ 0x11223344 ]  <-- Top
```

---

`pop eax`

This retrieves the value at the top of the stack and places it into `eax`

`eax` thus becomes `0x112233344` or `287454020` (in decimal)

`esp` then increases by another 4 bytes to become `0xffffc6f0`, which is the same as its initial value.