#ifndef THREADS_SWITCH_H
#define THREADS_SWITCH_H

#ifndef __ASSEMBLER__
/** switch_thread()'s stack frame. */
struct switch_threads_frame 
  {
    uint32_t edi;               /**<  0: Saved %edi. */
    uint32_t esi;               /**<  4: Saved %esi. */
    uint32_t ebp;               /**<  8: Saved %ebp. */
    uint32_t ebx;               /**< 12: Saved %ebx. */
    void (*eip) (void);         /**< 16: Return address. */
    struct thread *cur;         /**< 20: switch_threads()'s CUR argument. */
    struct thread *next;        /**< 24: switch_threads()'s NEXT argument. */
  };

/** 
 * @brief switch from one Thread(cur) to another Thread(next)
 * 
 * @note - Save registers on the stack.
 * @note - Save current stack pointer to current `struct thread`\'s `stack` member.
 * @note - Restores the new `thread`\'s `stack` into the CPU\'s stack pointer.
 * @note - Restores registers from the stack, and returns.
 * 
 * @param[in]  cur  Current thread, must be the running thread
 * @param[in]  next Thread will switch to, running switch_threads() 
 * 
 * @return returning `cur` in `next`\'s context
 * 
 * @retval return a point to a TCB
 * 
 * @warning - The `cur` thread must be the running thread.
 * @warning - The `next` thread must also be running `switch_threads()`.
 * 
 * 
 * This function works by assuming that the thread we're switching
 *          into is also running switch_threads(). Thus, all it has to do is
 *          preserve a few registers on the stack.
 * 
 * @todo what meaning the return ?
 * @todo understand the thread switch (think about xv6)
 * @todo in switch_threads, care about the regs: movl SWITCH_CUR(%esp), %eax
 *       because it is the return regs.
*/
struct thread *switch_threads (struct thread *cur,
                               struct thread *next);

/** Stack frame for switch_entry(). */
struct switch_entry_frame {
  void (*eip) (void);
};

void switch_entry (void); // code in switch.S

/** Pops the CUR and NEXT arguments off the stack, for use in
   initializing threads. */
void switch_thunk (void);
#endif

/** Offsets used by switch.S. */
#define SWITCH_CUR      20
#define SWITCH_NEXT     24

#endif /**< threads/switch.h */
