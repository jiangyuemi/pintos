## thread_start 讲解
```
首先初始化了一个信号量:idle_started 并且设置其值为0
然后thread_create(idle)创建了一个idle线程,main线程中进行了seg_down(idle_started)此时main->status = block,shedule之后运行idle线程,唤醒main线程,main->status = ready 并且加入 ready_list,
最后idle线程block,shedule main thread continue excute
```