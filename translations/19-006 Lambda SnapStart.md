---
source: 19 - Serverless Overviews from a Solution Architect Perspective\006 Lambda SnapStart_zh.srt
---

讲师：现在, 我们来谈谈Lambda SnapStart｡ 

因此, 这是Lambda的一个功能,

可以帮助您将Lambda函数的性能提高10倍,

而无需为在Java 11或更高版本上运行的Lambda函数付出额外的成本｡

所以让我们来了解如何和为什么｡ 

所以Lambda调用有几个生命周期阶段｡ 

如果SnapStart已禁用,

并且您再次记住了在Java上运行的Lambda函数, 则无论何时调用Lambda函数,

Java代码都将被初始化, 然后被调用,

然后将关闭｡

但启用SnapStart后,

将从预初始化状态调用该函数｡

这意味着, 没有从头开始的函数初始化｡

因此, 当您启用SnapStart时,

将再次调用运行Java的Lambda函数, 但该函数已预初始化｡

因此, 在Java中可以持续很长时间的初始化阶段已经消失了｡

然后直接进入调用阶段和关闭阶段｡

所以这是一个完全免费的功能,

它是如何工作的？

每当你发布一个新的Lambda版本时, Lambda都会初始化你的函数｡

所以这个初始化阶段将提前完成｡ 

然后将拍摄初始化函数的内存和磁盘状态的快照｡

最后, 此快照将被锁定以进行低延迟访问,

这将允许您的功能具有所谓的SnapStart,

即快速启动｡

这节课就到这里｡ 

希望你们喜欢, 下次课再见｡
