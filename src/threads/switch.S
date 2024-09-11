#include "threads/switch.h"

#### struct thread *switch_threads (struct thread *cur,
####                                struct thread *next)
####
#### Switches from cur, which must be the running thread, to next,
#### which must also be running switch_threads(), returning cur in
#### next's context.
####
#### This function works by assuming that the thread we're switching
#### into is also running switch_threads().  Thus, all it has to do is
#### preserve a few registers on the stack, then switch stacks and
#### restore the registers.  As part of switching stacks we record the
#### current stack pointer in CUR's thread structure.


#
# +---------------------------------+ 4KB
# |               aux               | Passed in funtion thread_create
# |            function             | Passed in funtion thread_create
# |            eip (NULL)           | kernel_thread_frame
# |      addr to kernel_thread      | switch_entry_frame
# |               next              | Before "call   c00213f8 <switch_threads>" we had pushed the 
# |               cur               |
# |      addr to switch_entry       |  We can find the val of <switch_entry> in ../build/kernel.asm
# |               ebx               |
# |               ebp               |
# |               esi               |
# |               edi               | switch_threads_frame
# +---------------------------------+ The $esp point to here after pushl those regs
#

.globl switch_threads
.func switch_threads
switch_threads:

	pushl %ebx    							# Save caller's register state.
	pushl %ebp    							# Note that the SVR4 ABI allows us to destroy %eax, %ecx, %edx,
	pushl %esi    							# but requires us to preserve %ebx, %ebp, %esi, %edi.  See
	pushl %edi    							# [SysV-ABI-386] pages 3-11 and 3-12 for details.

.globl thread_stack_ofs
	mov thread_stack_ofs, %edx                 # Get offsetof(struct thread, stack).

	movl SWITCH_CUR(%esp), %eax                # Save the current $esp to cur's TCB.stack.
	movl %esp, (%eax,%edx,1)                   # $esp points the end of switch_threads_frame now


	movl SWITCH_NEXT(%esp), %ecx               # We restore the next's $esp from it's TCB.stack.
	movl (%ecx,%edx,1), %esp                   # We can say switch has completed now, the "cur" thread 
	                                           # stay here without returning.

	popl %edi                 # Restore caller's register state.
	popl %esi                 # We recover the thread next's regs
	popl %ebp                 # from its own stack.
	popl %ebx								  # (in fact we can say "current")
        ret                 # now, we return to switch_entry()
.endfunc

.globl switch_entry
.func switch_entry
switch_entry:
	addl $8, %esp            # Discard switch_threads() arguments.

	pushl %eax               # Call thread_schedule_tail(prev).
.globl thread_schedule_tail
	call thread_schedule_tail
	addl $4, %esp

	ret                      # Start thread proper.   to kernel_thread
.endfunc
