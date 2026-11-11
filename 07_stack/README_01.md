# 01.asm

In x86-64:
- Stack grows downwards, towards lower memory addresses.
- `rsp` stores the address of the current top of the stack.

Each register used in the following is 64 bits in size (8 bytes), Therefore, each `PUSH` decreases `rsp` by 8 bytes, while each `POP` increases it by 8 bytes.

**Initial `rsp` value**: `0x7fffffffd590`

## Program run

`mov rax, 100`

This moves the value `100` into the register `rax`.

---

`mov rbx, 200`

This moves the value `200` into the register `rbx`.

The values of `rax` and `rbx` thus become `100` and `200` respectively.

---

`push rax`

This instruction pushes the value in `rax` (100) onto the stack. `rsp` decreases by 8 bytes to become `0x7fffffffd588`.

---

`push rbx`

This instruction pushes the value in `rbx` (200) onto the stack. `rsp` decreases by 8 bytes to become `0x7fffffffd580`

Stack thus looks like this:

```text
    [ 200 ]  <-- Top
    [ 100 ]
```

---

`pop rcx`

This removes the value at the top of the stack (200) and places it into `rcx`, thus:

rcx = 200

`rsp` increases by 8 bytes since the stack is popped. The new `rsp` value becomes `0x7fffffffd588`.

**Current stack:**

```text
    [ 100 ]  <-- Top
```

---

`pop rdx`

This removes the value at the top of the stack and places it into `rdx`, thus:

rdx = 100

`rsp` increases by 8 bytes since the stack is popped. The new `rsp` value becomes `0x7fffffffd590`

