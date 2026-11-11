# 04.asm

In 32-bit x86, the stack grows downwards, towards lower memory addresses.

The initial `esp` value is `0xffffc710`

Each 32-bit value occupies 4bytes. Therefore, when popping or pushing, we adjust `esp` by 4 bytes.

## Program run

`call work`

This pushes the return address (address of instruction immediately after `call work`) onto the stack, that is, the address of `mov eax, 1`

`esp` thus decreases by 4 bytes to become `0xffffc70c`.

The program then jumps onto the `work` function.

**Why do we save the return address?**
- When `work` finishes execution, the program needs to know where to go back to to continue executing.

**Current stack:**

```text
    [ Return address of work function ]  <-- Top
```

---

`push ebp`

`ebp` already contains a value `0x0`. We don't want to lose that value, so we save it on the stack (decreases ESP by a further 4 bytes).

The new `esp` value becomes `0xffffc708`

The old value of `ebp` is thus the new top of the stack.

**Current stack:**

```text
    [ Saved old EBP                   ]  <-- Top
    [ Return address of work function ]
```

---

`mov ebp, esp`

This copies the current value of `esp` to `ebp`

`ebp` thus becomes `0xffffc708` (same value as `esp`)

**Why do we do this?** We want a fixed reference point for accessing our local variables. `esp` will change, we want to be able to go back to its previous value.

---

`sub esp, 8`

We do this because we want space for 2 variables (each 4 bytes).

`esp` decreases by 8 to become `0xffffc700`.

`ebp` value does not change. 

**Current stack:**

```text
    [ ESP - 8                         ]  <-- Top 
    [ ESP - 4                         ]
    [ Saved old RBP                   ]  
    [ Return address of work function ]
```

---

`mov dword [ebp - 4], 100`
`mov dword [ebp - 8], 200`

These move the values 100 and 200 into the reserved spaces.

- [ebp - 4] stores 100
- [ebp - 8] stores 200

**Current stack:**

```text
    [ 200 (EBP - 8)                   ]  <-- Top (ESP)
    [ 100 (EBP - 4)                   ]
    [ Saved old EBP                   ]  <-- EBP
    [ Return address of work function ]
```

---

`mov eax, [ebp - 4]`
`mov ebx, [ebp - 8]`
`nop`

The values of the variables are then moved into `eax` and `ebx`

`eax` becomes `100`. `ebx` becomes `200`.

---

### Cleaning up the stack

`mov esp, ebp`

This restores the previous value of `esp` to the point where it was before allocating the local variables.

`ebp` value was `0xffffc708`.

The `esp` value thus becomes `0xffffc708` (+8)

**Stack (before instruction):**

```text
    [ 200 (ESP - 8)                   ]  <-- Top
    [ 100 (ESP - 4)                   ]
    [ Saved old EBP                   ]  
    [ Return address of work function ]
```

**Stack (after instruction):**

```text
    [ Saved old EBP                   ]  <-- Top
    [ Return address of work function ]
```

---

`pop ebp`

We want to regain our previous `ebp` value in case it was useful to the program execution.

The line reads the value at the top of the stack and places it into `ebp`

`esp` thus increases by 4 bytes to become: `0xffffc70c`

`ebp` regains its original value: `0x0`

**Current stack:**

```text
    [ Return address of work function ]  <-- Top
```

---

`ret`

It takes the return address from the top of the stack and uses it to continue execution from where the function was called.

The new `esp` value increases by 4 bytes to become `0xffffc710`.

The return address is thus no longer part of the stack.

---

Execution then resumes at `mov eax, 1`

The program executes:

`mov eax, 1` ;
`xor ebx, ebx` ;
`int 0x80`