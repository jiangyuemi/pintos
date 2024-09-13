## thread_start 讲解
```
首先初始化了一个信号量:idle_started 并且设置其值为0
然后thread_create(idle)创建了一个idle线程,main线程中进行了seg_down(idle_started)此时main->status = block,shedule之后运行idle线程,唤醒main线程,main->status = ready 并且加入 ready_list,
最后idle线程block,shedule main thread continue excute
```

```
外中断是硬件设备中断,例如时钟中断，磁盘控制器中断，键盘中断等
内中断指的是内部异常产生的中断,例如除零错误,page fault等
软中断就是指令产生的中断,例如系统调用
IF标志位控制是否响应外中断,所以前面说的关闭中断指的是外中断
```