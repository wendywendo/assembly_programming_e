# 02.asm

In x86-64, the stack grows downwards, towards lower memory addresses.

The initial RSP value is `0x7fffffffd590`

## Program run

`call work`

This pushes the return address (address of instruction immediately after `call work`) onto the stack, that is, the address of `mov rax, 60`
The program then jumps onto the `work` function at line 10.

Why do we save the return address?
- When `work` finishes execution, the program needs to know where to go back to to continue executing.

RSP decreases by 8 bytes. Why?
- In x86-64, memory addresses are stored as 8-byte values, hence the return address is also 8 bytes.

- The new RSP value thus becomes: `0x7fffffffd588`


**Current stack:**

```text
    [ Return address of work function ]  <-- Top
```

---

`push rbp`

RBP already contains a value `0x0`. We don't want to lose that value, so we save it in the stack (decreases RSP by a further 8 bytes).

The new RSP value becomes `0x7fffffffd580`

The old value of `rbp` is thus the new top of the stack.

**Current stack:**

```text
    [ Saved old RBP                   ]  <-- Top
    [ Return address of work function ]
```

---

`mov rbp, rsp`

This copies the current value of `rsp` to `rbp`

**Why do we do this?** We want a fixed reference point for accessing our variables. RSP will change, we want to be able to go back to its previous value.

`RBP` thus becomes `0x7fffffffd580` (same value as `RSP`)

---

`sub rsp, 16`

We do this because we want space for 2 variables (each 8 bytes).

**Current stack:**

```text
    [ RSP - 16                        ]  <-- Top
    [ RSP - 8                         ]
    [ Saved old RBP                   ]  
    [ Return address of work function ]
```

`RBP` value does not change. `RSP` decreases by 16 to become `0x7fffffffd570`.

---

`mov qword [rbp - 8], 100`
`mov qword [rbp - 16], 200`

This moves the values 100 and 200 into the reserved spaces.

**Current stack:**

```text
    [ 200 (RSP - 16)                  ]  <-- Top
    [ 100 (RSP - 8)                   ]
    [ Saved old RBP                   ]  
    [ Return address of work function ]
```

---


`mov rax, [rbp - 8]`
`mov rbx, [rbp - 16]`
`nop`

The values of the variables and then moved into `rax` and `rbx`

`rax` becomes `100`. `rbx` becomes `200`.

---

### Cleaning up the stack

`mov rsp, rbp`

This line restores the previous value of `rsp` to point where it was before storing the local variables.

**Stack (before the line):**

```text
    [ 200 (RSP - 16)                  ]  <-- Top
    [ 100 (RSP - 8)                   ]
    [ Saved old RBP                   ]  
    [ Return address of work function ]
```

**Stack (after the line):**

```text
    [ Saved old RBP                   ]  <-- Top
    [ Return address of work function ]
```

`rbp` value was `0x7fffffffd580`.

The `rsp` value thus becomes `0x7fffffffd580` (+16)

---

`pop rbp`

We want to regain our previous `rbp` value in case it was useful to the program execution.

The line reads the value at the top of the stack and places it into `rbp`

`rsp` thus increases by 8 bytes to become: `0x7fffffffd588`

`rbp` regains its original value: `0x0`

**Current stack:**

```text
    [ Return address of work function ]  <-- Top
```

---

`ret`

It takes the return address from the top of the stack and uses it to continue execution from where the function was called.

The new `rsp` value becomes `0x7fffffffd590` (an increase of 8 bytes)

**Current stack:**

```text
    [   ]
```

Execution then continues at `mov rax, 60`

---

The program then exists:

`mov rax, 60`

`xor rdi, rdi`

`syscall`