This README explains how the `DIV` and `IDIV` instruction affect CPU flags.

---

## `div1.asm`

### Flags Set
- **Auxiliary Carry Flag (AF)**
- **Interrupt Flag (IF)**

---

## `div2.asm`

### Flags Set
- **Auxiliary Carry Flag (AF)**
- **Interrupt Flag (IF)**

---

## `div3.asm`
- **Auxiliary Carry Flag (AF)**
- **Interrupt Flag (IF)**

---

# Explanation

The `DIV` and `IDIV` instructions do not affect any of the status flags: `AF`, `CF`, `OF`, `PF`, `SF` and `ZF`. They are left in an **undefined** state.

> **Undefined** means that the processor does not guarantee what value the flag will have after the instruction.

---

## But why is AF flag still set to 1?
Since the value of AF is **undefined** after `DIV` and `IDIV`, the processor does not guarantee that it will preserve the previous value or change it to a particular value.

Therefore, after `DIV`, AF may happen to be:
```text
AF = 0
```

or:
```text
AF = 1
```

depending on the processor and circumstances.

---

## What about the Interrupt Flag (IF)?
The `DIV` instruction does not modify the Interrupt Flag (IF).

On normal x86 execution, IF is normally enabled `(IF = 1)` so that the processor can respond to maskable interrupts.