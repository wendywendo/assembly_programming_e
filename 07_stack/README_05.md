# 05.asm

**Initial RSP value**: `0x7fffffffd590`

## Program Run

`mov rax, 0x1122334455667788`

This moves the hexadecimal value `0x1122334455667788` into `rax`.

The new value in `rax` thus becomes `0x1122334455667788` or `1234605616436508552` in decimal.

---

`mov rbx, 0x1234`

This moves the hexadecimal value `0x1234` into `rbx`.

The new value in `rbx` thus becomes `0x1234` or `4660` in decimal.

---

`push rax`

This pushes the value in `rax` (`0x1122334455667788`) onto the stack.

`rsp` thus decreases by 8 bytes since `rax` is 8 bytes, to become `0x7fffffffd588`

**Current stack**

```text
    [ 0x1122334455667788 ]  <-- Top
```

---

`push rbx`

This pushes the value in `rbx` (`0x1234`) onto the stack.

`rsp` thus decreases by another 8 bytes to become `0x7fffffffd580`.

**Current stack**

```text
    [ 0x1234             ]  <-- Top
    [ 0x1122334455667788 ]
```

---

`pop rbx`

This retrieves the value at the top of the stack and places it into `rbx`.

`rbx` thus becomes `0x1234` (`4660` in decimal).

`rsp` then increases by 8 bytes to become `0x7fffffffd588`.

**Current stack**

```text
    [ 0x1122334455667788 ]  <-- Top
```

---

`pop rax`

This retrieves the value currently at the top of the stack and places it into `rax`.

`rax` thus becomes `0x1122334455667788` (`1234605616436508552` in decimal).

`rsp` then increases by a further 8 bytes to become `0x7fffffffd590`


After both values have been popped, `rsp` thus returns to its initial value.