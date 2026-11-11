# 03.asm

In x86-64, the stack grows downwards, towards lower memory addresses.

The initial RSP value is `0x7fffffffd590`

## Program run

`mov rax, 10`

Moves the value `10` into `rax`

---

`call calculate`

The program calls the `calculate` function. This pushes the return address (address of instruction immediately after `call calculate`) onto the stack.

This thus decreases `rsp` by 8 bytes and the new `rsp` value becomes `0x7fffffffd588`

The program then jumps to the `calculate` function.

**Current stack:**

```text
    [ Return address of calculate function ]  <-- Top
```

---

`add rax, 5`

This adds `5` to the current value in `rax`.

Since `rax` initially contains `10`:

    `rax = 10 + 5 = 15`

`rax` thus becomes `15`.

---

`ret`

The instruction retrieves the return address from the top of the stack and thus returns to the instruction immediately after `call calculate`.

`rsp` thus increases by 8 bytes to `0x7fffffffd590` (its initial value)

