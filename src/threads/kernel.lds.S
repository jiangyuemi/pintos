#include "threads/loader.h"

OUTPUT_FORMAT("elf32-i386") /* 指定格式 */
OUTPUT_ARCH("i386")         /* 指定架构 */

ENTRY(start)			/* 指定入口点, 即程序第一条被执行的指令所在之处 */

SECTIONS
{
  _start = LOADER_PHYS_BASE + LOADER_KERN_BASE; //内核基地址
  . = _start + SIZEOF_HEADERS;  // 单独一个'.'表示当前位置 预留ELF头的空间

  /* Kernel starts with code, followed by read-only data and writable data. */

  .text : { 
    *(.start) *(.text) 
    } = 0x90; // 未初始化空间填充为0x90
  
  .rodata : {
    *(.rodata) *(.rodata.*); 
    . = ALIGN(0x1000); 
    _end_kernel_text = .;
  }

  .data : { 
    *(.data) 
	  _signature = .;
    LONG(0xaa55aa55)
  }

  _start_bss = .; // 设置BSS(zero-initialized data)段开始的位置
  .bss : {
    *(.bss) 
  }
  _end_bss = .;   //设置bss段结束的位置
  _end = .;  // 设置内核结束的位置

  ASSERT (_end - _start <= 512K, "Kernel image is too big.")
}
