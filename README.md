# x64 assembly write-up


#### Registers
#### Sections
#### Flags
#### Functions & Variables
#### System Calls (syscalls)
#### Instructions
#### Indexing
#### Calling Conventions
#### GOT, PLT, GDT
#### OpCodes



### what're registers?

### my definition: temporary variables within the CPU


### Registers are special, high-speed storage area within the CPU. They are temporary memory like RAM. They are responsible for all arithmetic calculations. Some registers do not perform arithmetic operations and are used for other things like storing addresses, etc.

#### RAX	| Accumulator	
#### RBX	| Base	
#### RCX	| Counter	
#### RDX	| Data	
#### RSI	| Source	
#### RDI	| Destination	
#### RBP	| Base pointer	
#### RSP	| Stack pointer	
#### R8-R15	| New registers

----

# Sections
### my definition: an assembly program is divided into 3 sections, .text, .data and .bss .text is where the code goes, .data is where most "variables" are initialized (this data will not change during run time), .bss is where the variables go that change during runtime 
#### section .text
#### The text section is used for keeping the actual code. This section must begin with the declaration global _start, which tells the kernel where the program execution begins.


#### section .data
#### The data section is used for declaring initialized data or constants. This data does not change at runtime. You can declare various constant values, file names, or buffer size, etc., in this section.


#### section .bss
#### The bss section is used for declaring variables.

---

# rFlags
###my definition: rFlags(flags) basically smaller registers that hold a boolean value typically these are used to return 

###Bit(s)	| Label	| Description
#### 0	| CF	| Carry Flag
  
----

#### 1	| 1	| Reserved
    
----


#### 2	| PF	| Parity Flag
  
----

#### 3	| 0	| Reserved
  
----

#### 4	| AF	| Auxiliary Carry Flag
  
----

#### 5	| 0	| Reserved
  
----

#### 6	| ZF	| Zero Flag
  
----

#### 7	| SF	| Sign Flag
  
----

#### 8	| TF	| Trap Flag
  
----

#### 9	| IF	| Interrupt Enable Flag
  
----

#### 10	| DF	| Direction Flag
  
----

#### 11	| OF	| Overflow Flag
  
----

#### 12-13	| IOPL	| I/O Privilege Level
  
----

#### 14	| NT	| Nested Task
  
----

#### 15	| 0	| Reserved
  
----

#### 16	| RF	| Resume Flag
  
----

#### 17	| VM	| Virtual-8086 Mode
  
----

#### 18	| AC	| Alignment Check / Access Control
  
----

#### 19	| VIF	| Virtual Interrupt Flag
  
----

#### 20	| VIP	| Virtual Interrupt Pending
  
----

#### 21	| ID	| ID Flag
  
----

#### 22-63	| 0	| Reserved

---

# Functions & Variables
# Functions & Variables
- ### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Functions
```nasm
; functions in assembly are called labels typically
global _start

section .text
    _start:       
        call exit 
        
    exit:
        mov RAX, 1 
        mov RBX, 0 
        syscall   
```
- ### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Variables
```nasm
section .data                              
    variable db "this is a variable", 0x00  
```

---

# System Calls (syscalls)
## What is a system call?
+ A system call is a service requested by the kernel (requested by the program)
+ a fast system call is used to instruct the CPU to add a Procedure/Task Gate Descriptor in either the Global Descriptor Table (GDT) or a Local Descriptor Table (LDT) in order to transition to a lower privilege level (aka user mode to kernel mode).
+ Syscalls are always handled by the RAX(ax) register
+ All syscalls take arguments:
  (V ABI) rdi, rsi, rdx, rcx, r9, r10, stack
    + To see a list of system calls please visit: https://syscalls.w3challs.com/?arch=x86
    + Wiki on syscalls: https://en.wikipedia.org/wiki/System_call
```nasm
; example
section .text
    global _start
    _start:
        mov RAX, 60 
        mov RBX, 0 
        syscall    
```

---
# Instructions

### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) mov & lea
```nasm
- mov = copies data from one place to another
    example: mov RAX, 1 ; moves the 1 into the RAX register

- lea = ( Load Effective Address ) the 'lea' instruction loads a memory address into another space
    example: lea RAX, some_variable ; loading the memory address of 'some_variable' into the RAX register
```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) db, dw, dd, dq & dt
```nasm
- db = bytes are allocated by define bytes ( Define Byte, 1 byte )
    example: variable_name db "Define Bytes!" ; making a variable and 'defining bytes' with the data "Define Bytes!"

-----------------------------------------------------------------------------

- dw = words are allocated by define words ( Define Word, allocates 2 bytes )
    example: message dw "Define Word!" ; making a variable and 'defining words' with the data "Define Word!"

-----------------------------------------------------------------------------

- dd = define double word ( allocates 4 bytes )
    example: variable dd "Define Double Word!" ; making a variable and 'defining double word' with the data "Define Double Word!"

-----------------------------------------------------------------------------

- dq = define quadword ( allocates 8 bytes ) 
    example: variable dq "define quadword!" ; making a variable and 'defining quad-word' with the data "define quadword!"

-----------------------------------------------------------------------------

- dt = Define Ten Bytes ( allocates 10 bytes )
    example: variable dq "define ten-bytes!" ; making a variable and 'defining ten bytes' with the data "define ten-bytes!"

```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) equ
```nasm
- equ = assigns absolute or relocatable values to symbols
    example:
    section .data
        variable_name db "hello world", 0x0a, 0x00 ; setting a variable with the bytes 'hello world' with a new line and terminator after
        length equ $ - variable_name
```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) cmp
```nasm
- cmp = compares 2 values and sets background flags to either 1 or 0 depending on the outcome
    example: 
global _start
    section .text
    _start:
        mov RAX, 1  ; moving the value +1 into RAX
        cmp RAX, 0  ; comparing RAX to 0, since we know that RAX has +1 in it than we know that the result of the comparison is 0 (false)
```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) call & jmp
```nasm
- call = call & jmp are essentially the same however when call & ret are used together the program
returns to the origanal control flow
    example:
global _start

section .data
        msg db "hello world", 0x0a, 0x00
        length equ $ - msg

section .text
        _start:
                call write    
                call exit     
        write:
                mov RAX, 4     
                mov RBX, 1      
                mov RCX, msg    
                mov RDX, length 
                syscall         
                ret            

        exit:
                mov RAX, 1 
                mov RBX, 0 
                syscall    
                
-------------------------------------------------------------------

- jmp  = preforms an uncoditional jump, transfers the flow of execution by changing the instruction pointer.
    example:
        _start:
            jmp exit    
        
        exit:
            mov RAX, 1 
            mov RBX, 0  
            syscall     
        

```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) leave, enter & ret
```nasm
- leave = moves RBP into RSP and pops RBP off the stack
    Equivalent_to:
        mov RSP, RBP 
        pop RBP       
        
-------------------------------------------------------------------

- enter = pushes RBP onto the stack then copies data within RSP to RBP
    Equivalent_to:
        push RBP      
        mov RBP, RSP  
        
-------------------------------------------------------------------

- ret = Transfers program control to a return address located on the top of the stack
    example:
global _start

section .data
        msg db "hello world", 0x0a, 0x00 
        length equ $ - msg                

section .text
        _start:
                call write  
                call exit     
        write:
                mov RAX, 4      
                mov RBX, 1      
                mov RCX, msg    
                mov RDX, length 
                syscall         
                ret             

        exit:
                mov RAX, 1 
                mov RBX, 0
                syscall   
```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) push & pop ( stack operations )
```nasm
- push = increments ESP by 4(bytes) then places its contents onto the top of the stack where ESP will now point to
    example:
        push RAX      ; push RAX on the stack
        push [RBX]    ; push the 4 bytes at RBX onto the stack

- pop = It first removes the 4(bytes) ESP points to into the specified register or memory location (and then increments ESP by 4)
    example:
        pop RDI     ; pop the top of the stack into EDI
        pop [RBX]   ; pop the top of the stack into memory at the 4 bytes starting at RBX
```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+)  nop & int
```nasm
- nop = no operation, when the instruction pointer (EIP) points to this instruction it simply does nothing until the next instruction is hit.
    example:
        _start:
            nop         ; instruction pointer reads this and does nothing
            nop         ; instruction pointer reads this and does nothing
            mov RAX, 1  ; sys_exit system call 
            mov RBX, 0  ; exit status: 0
            syscall     ; interrupt and invoke a sys-call
--------------------------------------------------------------------------
- int = interrupt, interrupts the program and notifies the kernel
    example:
        mov RAX, 1 ; sys_exit system call
        mov RBX, 0 ; exit status : 0
        syscall   ; interrupt and invoke a sys-call

```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) xor, or, not, test & and (logical instructions)
- xor = exclusive or, bitwise comparison operator
    - XOR is reversable meaning 0x8C ^ 0x2C = 0xA0 and 0x8C ^ 0xA0 = 0x2C
    - xor is a cheap way to encrypt data with a password
    - if the two arguments are the same the output is 0
    - if the two arguments are different the output is 1
    - more on xoring: https://ctf101.org/cryptography/what-is-xor
    - examples:
      ````
        bit1  bit2  equals
         0      0     0
         1      1     0
         1      0     1
         0      1     1
      ````
        - ![alt text](https://i.imgur.com/zHA07QB.png)
        - ![alt text](https://i.imgur.com/B3kGS7E.png)
        - ````nasm
          xor RAX, RAX  ; RAX now equals 0
          ````
---------------------------------------------------------------
- or = the or instruction is used for supporting logical expression by performing bitwise or operation
    - the or instruction is similiar to the xor instruction however it's inclusive un-like the xor instruction
      
    - example:
```nasm
section .text
   global _start 

_start:
   mov    RAX, 5             ; getting 5 in the al
   mov    RBX, 3             ; getting 3 in the bl
   or     RAX, RBX           ; or al and bl registers, result should be 7
   add    RAX, byte '0'      ; converting decimal to ascii

   mov    [result],  RAX    ; move the value of RAX into the first byte of 'result'
   mov    RAX, 4            ; sys_write
   mov    RBX, 1            ; stdout i/o
   mov    RCX, result       ; bytes to write ( to stdout )
   mov    RDX, 1            ; bytes to read
   syscall                  ; interrupt and invoke a sys-call
    
outprog:
   mov rax, 1  ; system call number (sys_exit)
   mov rbx, 0  ; exit status : 0
   syscall     ; interrupt and invoke sys-call

section    .bss
    result resb 1   ; reserving a byte for the variable 'result'
```
---
- not = Performs a bitwise NOT operation (each 1 is set to 0, and each 0 is set to 1) on the destination operand and stores the result in the destination operand location
    - not operation reverses the bits in an operand
    - the operand could be either in a register or in the memory
    - to read more: 
        - https://stackoverflow.com/questions/13597094/implementing-assembly-logical-not-instruction
        - https://x86.puri.sm/html/file_module_x86_id_218.html
        - https://stackoverflow.com/questions/50726304/simple-example-of-not-instruction-in-x86-asm
---
- test = computes the bit-wise logical AND of first operand and the second operand and sets the SF, ZF, and PF status flags according to the result. The result is then discarded
    -  more: https://c9x.me/x86/html/file_module_x86_id_315.html
    -  example:
```nasm
    _start:
        test RCX, RCX    ; set ZF to 1 if RCX == 0
        je _start        ; jump if ZF == 1
        test RCX, RCX    ; set ZF to 1 if RCX == 0
        jne _start       ; jump if ZF != 1
        test RAX, RAX    ; set SF to 1 if rax < 0 (negative)
        js error         ; jump if SF == 1
```
---
- and = it does 32 separate/independent boolean and operations, one for each bit position. (true if both inputs are true, otherwise false.)
    - example:
        - The two numbers are stored in RBX and RCX, the final result obtained after AND operation goes to the RBX register.
```nasm
_start:
    mov RBX, 3527
    mov RCX, 2968
    and RBX, RCX
```    

## Arithmetic Operations
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) add & sub
```nasm
- add = this is going to preform an addition equation
    example: 
        add RAX, 5  ; adds +5 to RAX

- sub = this is going to preform a subtraction equation
    example:
        sub RAX, 5  ; subtracting -5 from RAX 
```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) dec & inc
```nasm
- dec = adds +1 to the destination while preserving the state of the carry flag (CF)
    example:
        dec RAX    ; decrement RAX by -1
        
- inc = subtracts -1 from the destination while preserving the carry flag (CF)
    example:
        inc RAX    ; increment RAX by +1
```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) adc & sbb
```nasm
- adc = this instruction is just like the add instruction, however it also adds the value of the CF flag
    example:
        adc RAX, 5  ; add 5 plus whatever is in CF to RAX
- sbb = this instruction is just like the sub instruction however you also minus the value of the CF flag
    example:
        sbb RAX, 5  ; subtract 5 plus whatever is in CF from RAX
```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) mul, div, imul, idiv & neg
```nasm
- Signed binary integers Signed integers are numbers with a + or - sign
- Signed integers must be sign-extended before division takes place
- signed int:    -32768 to +32767
- unsigned int:  0 to 65535

-------------------------------------------------------------------

- imul = (signed integer multiply) basically the same as the mul instruction but to signed numbers
    example:
        mov RAX, -2      ; placing -2 in RAX
        mov RBX, -100    ; placing -100 in RBX
        imul RBX         ; RBX * RAX = 50 (RAX=50)

-------------------------------------------------------------------

- idiv = (signed integer division)
    example:
        mov RAX, -2    ; moving -2 in RAX
        mov RBX, -100  ; moving -100 in RBX
        idiv RBX       ; RBX / RAX = 50 (RAX=50)

-------------------------------------------------------------------

- mul = (unsigned multiply) this will preform a multiplication equation & apply the output to the RAX register
    example:
        mov RAX, 2      ; placing +2 in RAX
        mov RBX, 100    ; placing +100 in RBX
        mul RBX         ; RBX * RAX = 50 (RAX=50)

-------------------------------------------------------------------

- div = (unsigned divide) this will preform a division equation & apply the output to the RAX register
    example:
        mov RAX, 2      ; placing +2 in RAX
        mov RBX, 100    ; placing +100 in RBX
        div RBX         ; RBX / RAX = 50 (RBX=50)

-------------------------------------------------------------------

- neg = this will make the register negative, or if it is negative it'll make it positive.
    example:
        mov RAX, 50 ; moves +50 into RAX
        neg RAX     ; makes 50 from RAX into -50 so the value of RAX is now equal to -50
-------------------------------------------------------------------
```

### resb, resw, resd, resq & rest  ( Declaring Uninitialized Data )
```nasm
( resb, resw, resd, resq & rest are for the .bss code section, they declare uninitialised storage space )

- resb = reserve a byte
    example:
        section .bss
            variable resb 55    ; reserve 55 bytes into the variable 'variable'
            
----------------------------------------------------------------------------------
- resw = reserve a word
    example:
        section .bss
            variable resw  1   ; reserve one word
            
----------------------------------------------------------------------------------
- resd = reserve a doubleword
    example:
        section .bss
            variable resd 54   ; reserve 54 double words
----------------------------------------------------------------------------------
- resq = reserve a quadword
    example:
        section .bss
            variable resq 7  ; reserve 7 quad-words

----------------------------------------------------------------------------------
- rest = reserve a ten bytes
    example:
        section .bss
            variable rest 5  ; reserve 5 ten bytes
```

## Conditional Jumps
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) jl, jg, jz & je
```nasm
- jl = jump if less than
    example:
        _start:
            mov RAX, 100  ; move 100 into RAX
            cmp RAX, 4    ; compare RAX to 4 background flag will be set to 0 since the result is false
            jl _start     ; jump to start and make an infinite loop basically 

-------------------------------------------------------------------

- jg = jump if greater than
    example:
        _start:
            mov RAX, 100  ; place 100 into the RAX register
            cmp RAX, 150  ; compare RAX to 150 since the result is greater than a background flag will be set to 0
            jg _start     ; jump to _start since the result of the 'cmp' instruction was greater than

-------------------------------------------------------------------

- jz = jump if zero
    example:
        _start:
            mov RAX, 0  ; move zero into RAX
            cmp RAX, 0  ; compare RAX to zero, since RAX=0 the background flag is true
            jz _start   ; jump to _start since RAX=0

-------------------------------------------------------------------

- je = jump if equal to
    example:
        _start:
            mov RAX, 50   ; move +50 into RAX 
            cmp RAX, 50   ; compare RAX to +50
            je _start     ; jump to _start since RAX=50 and we compared it to 50

-------------------------------------------------------------------

```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) jne, jge, jle, jnz 
```nasm
- jne = jump if not equal to
    example:
        _start:
            mov RAX, 133  ; place +133 into RAX
            cmp RAX, 50   ; compare RAX to 50
            jne _start    ; jump to _start since the comparison proved not equal to

-------------------------------------------------------------------

- jge = jump if greater than or equal to
    example:
        _start:
            mov RAX, 144   ; place +144 into RAX
            cmp RAX, 200   ; compare RAX to 200
            jge _start     ; jump since the comparison proved larger than

-------------------------------------------------------------------

- jle = jump if less than or equal to
    example:
        _start:
            mov RAX, 50  ; move +50 into RAX
            cmp RAX, 50  ; compare RAX to 45
            jle _start   ; jump to _start since RAX=50 

-------------------------------------------------------------------

- jnz = not equal to zero
    example:
        _start:
            mov RAX, 33  ; move +33 into RAX
            cmp RAX, 0   ; compare RAX to 0
            jnz _start   ; jump to _start since RAX is not 0
```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) jo & jno
```nasm
- flags affected: OF ( overflow flag )
-------------------------------------------------------------------
- jo = jump if an overflow occurs
- jno = jump if no overflow occurs
```
### ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) js & jns
```nasm
- js = this conditional jump will occur if the jump is signed
- jns = this conditional jump will occur  if the jump is not signed
```
---


# Calling Conventions
- What are calling conventions?
    + you could say, calling conventions are the way syscalls take arguments
    + any leftover arguments are pushed onto the stack in reverse order, as in cdecl
    + to read more: https://en.wikipedia.org/wiki/X86_calling_conventions
---
# GOT, PLT & GDT  (tables in memory)
```
- GOT = (Global Offset Table), this is the actual table of offsets as filled in by the linker for external symbols
- PLT = (Procedure Linkage Table), used to call external functions whose address isn't known in the time of linking
- GDT = (Global Descriptor Table) Every 8-byte entry in the GDT is a descriptor, but these descriptors can be references not only to memory segments but also to Task State Segment
```

---
# OpCodes
- Whats an OpCode?
  + OpCodes are simply the byte-code representation of instructions example:
    - inc = 0x40
    - dec = 0x48
  + Wiki: https://en.wikipedia.org/wiki/Opcode
  + list of OpCodes: http://xxeo.com/single-byte-or-small-x86-opcodes

---

# Indexing
```nasm
global _start

section .text
    _start:
        add RSP, 5               ; adding 5 bytes into the ESP register
        mov [RSP],   byte 'H'    ; moving 'H' into index position 0, in the RSP register
        mov [RSP+1], byte 'e'    ; moving 'e' into index position 1, in the RSP register
        mov [RSP+2], byte 'l'    ; moving 'l' into index position 2, in the RSP register
        mov [RSP+3], byte 'l'    ; moving 'l' into index position 3, in the RSP register
        mov [RSP+4], byte 'o'    ; moving 'o' into index position 4, in the RSP register

        mov RAX, 4             ; sys_write system call
        mov RBX, 1             ; setting 1 as the file descriptor
        mov RCX, RSP           ; bytes to write to stdout
        mov RDX, 5             ; number of bytes the string to write is
        syscall                ; interrupt and invoke a system call

        mov RAX, 60 ; sys_exit
        mov RBX, 0 ; exit status
        syscall   ; interrupt and invoke sys-call
```

---
