#  INTERRUPT DESCRIPTOR TABLE (IDT)

```
The interrupt descriptor table (IDT) associates each exception or interrupt vector with a gate descriptor for the procedure or task used to service the associated exception or interrupt. Like the GDT and LDTs, the IDT is an array of 8-byte descriptors (in protected mode). Unlike the GDT, the first entry of the IDT may contain a descriptor. To form an index into the IDT, the processor scales the exception or interrupt vector by eight (the number of bytes in a gate descriptor). Because there are only 256 interrupt or exception vectors, the IDT need not contain more than 256 descriptors. It can contain fewer than 256 descriptors, because descriptors are required only for the interrupt and exception vectors that may occur. All empty descriptor slots in the IDT should have the present flag for the descriptor set to 0.

The base addresses of the IDT should be aligned on an 8-byte boundary to maximize performance of cache line fills. The limit value is expressed in bytes and is added to the base address to get the address of the last valid byte. A limit value of 0 results in exactly 1 valid byte. Because IDT entries are always eight bytes long, the limit should always be one less than an integral multiple of eight (that is, 8N – 1).

The IDT may reside anywhere in the linear address space. As shown in Figure 5-1, the processor locates the IDT using the IDTR register. This register holds both a 32-bit base address and 16-bit limit for the IDT.

The LIDT (load IDT register) and SIDT (store IDT register) instructions load and store the contents of the IDTR register, respectively. The LIDT instruction loads the IDTR register with the base address and limit held in a memory operand. This instruction can be executed only when the CPL is 0. It normally is used by the initialization code of an operating system when creating an IDT. An operating system also may use it to change from one IDT to another. The SIDT instruction copies the base and limit value stored in IDTR to memory. This instruction can be executed at any privilege level. 

If a vector references a descriptor beyond the limit of the IDT, a general-protection exception (#GP) is generated
```

中断描述符表（IDT）将每个异常或中断向量与用于处理相关异常或中断的过程或任务的门描述符关联起来。与 GDT 和 LDT 一样，IDT 也是一个 8 字节描述符数组（在保护模式下）。与 GDT 不同，IDT 的第一个条目可能包含一个描述符。为了形成 IDT 的索引，处理器会将异常或中断向量按 8（门描述符的字节数）的比例放大。由于只有 256 个中断或异常向量，因此 IDT 包含的描述符不必超过 256 个。它可以包含少于 256 个描述符，因为只有可能发生的中断和异常向量才需要描述符。IDT 中的所有空描述符槽应将描述符的存在标志设置为 0。

IDT 的基地址应按 8 字节边界对齐，以最大限度地提高缓存行填充的性能。限值以字节为单位，并与基地址相加，得到最后一个有效字节的地址。限值为 0 时，正好是 1 个有效字节。由于 IDT 条目长度总是 8 个字节，因此限值应始终小于 8 的整数倍（即 8N - 1）。

IDT 可以位于线性地址空间的任何位置。如图 5-1 所示，处理器使用 IDTR 寄存器定位 IDT。该寄存器包含 IDT 的 32 位基址和 16 位限制。

LIDT（加载 IDT 寄存器）和 SIDT（存储 IDT 寄存器）指令分别加载和存储 IDTR 寄存器的内容。LIDT 指令使用内存操作数中的基地址和限值加载 IDTR 寄存器。该指令只能在 CPL 为 0 时执行，通常由操作系统的初始化代码在创建 IDT 时使用。操作系统也可使用它从一个 IDT 切换到另一个 IDT。SIDT 指令将 IDTR 中存储的基准值和限值复制到内存中。该指令可在任何权限级别执行。

如果矢量引用的描述符超出了 IDT 的限制，就会产生一般保护异常 (#GP)

# IDT DESCRIPTORS

```
The IDT may contain any of three kinds of gate descriptors:
 • Task-gate descriptor
 • Interrupt-gate descriptor
 • Trap-gate descriptor

Figure 5-2 shows the formats for the task-gate, interrupt-gate, and trap-gate descriptors. The format of a task gate used in an IDT is the same as that of a task gate used in the GDT or an LDT (see Section 6.2.4., “Task-Gate Descriptor”). The task gate contains the segment selector for a TSS for an exception and/or interrupt handler task.

Interrupt and trap gates are very similar to call gates (see Section 4.8.3., “Call Gates”). They contain a far pointer (segment selector and offset) that the processor uses to transfer program execution to a handler procedure in an exception- or interrupt-handler code segment. These gates differ in the way the processor handles the IF flag in the EFLAGS register (see Section 5.12.1.2., “Flag Usage By Exception- or Interrupt-Handler Procedure”).
```

图 5-2 显示了task-gate、interrupt-gate和trap-gate描述符的格式。IDT 中使用的任务门格式与 GDT 或 LDT 中使用的任务门格式相同（参见第 6.2.4 节 “任务门描述符”）。任务门包含异常和/或中断处理程序任务 TSS 的段选择器。

中断门和陷阱门与调用门非常相似（参见第 4.8.3 节 “调用门”）。它们包含一个远指针（代码段选择器和偏移量），处理器使用该指针将程序执行转移到异常或中断处理程序代码段中的处理程序。将程序执行转移到异常或中断处理程序代码段中的处理程序。这些 门的不同之处在于处理器处理 EFLAGS 寄存器中 IF 标志的方式（参见第 5.12.1.2 节。5.12.1.2 节 “异常或中断处理程序的标志使用”）。