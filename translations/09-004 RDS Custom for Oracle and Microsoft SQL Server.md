---
source: 09 - AWS Fundamentals RDS + Aurora + ElastiCache\004 RDS Custom for Oracle and Microsoft SQL Server_zh.srt
---

讲师：现在, 我们来做一个关于RDS自定义的简短讲座｡

因此, 我们知道, 使用RDS时, 我们无法访问任何底层操作系统或自定义,

但使用RDS Custom时, 我们实际上可以｡

RDS自定义适用于两种数据库类型, 即Oracle和Microsoft

SQL Server｡

借助RDS Custom, 我们可以访问操作系统和数据库定制｡

因此, 借助RDS, 我们仍然可以获得AWS中数据库的自动化设置､

操作和扩展的所有优势｡

但是, 通过RDS Custom选项（RDS

Custom的自定义部分）,

我们实际上可以访问底层数据库和操作系统｡

因此, 我们实际上可以配置内部设置､

安装补丁､ 启用本机功能, 并且可以使用SSH或SSM会话管理器访问RDS背后的底层EC2实例｡

这是我的EC2实例, 如果它使用Amazon

RDS Custom, 作为用户, 我们现在可以将自定义和SSH应用到它｡

要执行任何自定义, 建议停用自动化模式,

以便RDS在您执行自定义时不执行任何自动化､ 维护､

扩展或任何您想要的操作｡

另外, 因为您可能会破坏某些东西,

因为现在您可以访问底层EC2实例,

所以最好创建一个数据库快照,

否则您将无法从操作中恢复｡

总结一下, RDS与RDS自定义｡ 

RDS将管理您的整个数据库和操作系统｡

一切都由AWS管理, 您无需执行任何操作,

而RDS Custom仅适用于Oracle和Microsoft

SQL Server, 您实际上对底层操作系统和数据库具有完全的管理员访问权限｡

这节课就讲到这里, 希望你们喜欢,

下节课再见｡
