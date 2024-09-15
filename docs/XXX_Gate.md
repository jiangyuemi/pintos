# Gate Descriptors

>> 为了提供对不同权限级别代码段的受控访问，处理器提供了一组特殊的描述符，称为门描述符。门描述符有四种：

>> 任务门用于任务切换，将在第 6 章 "任务管理 "中讨论。陷阱和中断门是一种特殊的调用门，用于调用异常和中断处理程序。第 5 章 "中断和异常处理 "将对其进行介绍。本章只涉及调用门。

# Call Gates

```
|31                  16 |15 |14  13|12|11    8|7 5|4    0|
+--------------------------------------------------------+
|         Offset        | P |  DPL |0 | Type  |000|Param.|
+--------------------------------------------------------+

|32                   16|15                             0|
+--------------------------------------------------------+
|  Segment Selector     |           Offset               |
+--------------------------------------------------------+
```

>> 调用门有助于在不同权限级别之间进行受控的程序控制转移。它们通常只用于使用权限级别保护机制的操作系统或执行程序。调用门还可用于在 16 位和 32 位代码段之间传输程序控制，详见第 17.4 节 “在混合大小代码段之间传输控制”。在混合大小代码段之间传输控制权 "一节中所述。

>> The segment selector field in a call gate specifies the code segment to be accessed.

>> The offset field specifies the entry point in the code segment. This entry point is generally to the first instruction of a specific procedure.

>> The DPL field indicates the privilege level of the call gate, which in turn is the privilege level required to access the selected procedure through the gate.

>> The P flag indicates whether the call-gate descriptor is valid. (The presence of the code segment to which the gate points is indicated by the P flag in the code segment’s descriptor.) Note that the P flag in a gate descriptor is normally always set to 1. If it is set to 0, a not present (#NP) exception is generated when a program attempts to access the descriptor. The operating system can use the P flag for special purposes. For example, it could be used to track the number of times the gate is used. Here, the P flag is initially set to 0 causing a trap to the not-present exception handler. The exception handler then increments a counter and sets the P flag to 1, so that on returning from the handler, the gate descriptor will be valid.

>> The parameter count field indicates the number of parameters to copy from the calling procedures stack to the new stack if a stack switch occurs (see Section 4.8.5., “Stack Switching”). The parameter count specifies the number of words for 16-bit call gates and doublewords for 32-bit call gates.

>> 