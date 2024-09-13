1. [IA32-v1]. IA-32 Intel Architecture Software Developer's Manual Volume 1: Basic Architecture. Basic 80x86 architecture and programming environment. Available via developer.intel.com. Section numbers in this document refer to revision 18.

2. IA32-VAIA-32 Intel® Architecture Software Developer’s Manual Volume 3: System Programming Guide  [IA32-v3a](https://www.scs.stanford.edu/nyu/04fa/lab/ia32/IA32-3.pdf#:~:text=IA-32%20Intel%C2%AE%20Architecture%20Software%20Developer%E2%80%99s%20Manual%20Volume%203:%20System%20Programming)


数据总线缓冲器 - 该模块通过充当缓冲器，在 8259 和 8085/8086 微处理器之间发挥中介作用。它接收来自 8085（例如）微处理器的控制字，并将其传输给 8259 微处理器的控制逻辑。8259 微处理器选择中断后（基于中断的优先级），会将所选中断的操作码和中断服务子例程的地址传输给其他相连的微处理器。数据总线缓冲器由 8 位组成，在框图中表示为 D0-D7。因此，一次最多可传输 8 位数据。


控制逻辑 - 它是 PIC 的中心，控制每个模块的运行。它的 INTR 引脚与其他微处理器相连，用于接收中断请求，INT 引脚用于输出。如果启用 8259，且其他微处理器的中断标志为高电平，则输出 INT 引脚的值为高电平，这样 8259 就会响应其他微处理器的请求。

中断请求寄存器（IRR）--存储所有请求中断服务的中断级别。

中断服务寄存器 (ISR) - 它存储当前正在执行的中断级别。

中断屏蔽寄存器（IMR）--它通过存储中断级别的屏蔽位来存储需要屏蔽的中断级别。

优先级解析器 - 它检查所有三个寄存器并设置中断的优先级，根据中断的优先级，在 ISR 寄存器中设置优先级最高的中断。此外，它还会重置 IRR 中已服务的中断级别。

级联缓冲器 - 为了提高中断处理能力，我们可以使用级联缓冲器进一步级联更多引脚。因此，在增加中断处理能力时，CSA 线路用于控制多个中断结构。