---
source: 28 - Disaster Recovery & Migrations\004 RDS & Aurora Migrations_zh.srt
---

老师：这是一个很短的讲座,

不幸的是, 你必须为考试而学习, 也许是为了一个问题｡

这是一种迁移到Aurora MySQL的方法｡ 

因此, 如果您有一个RDS数据库,

并希望将其移动到Aurora MySQL中,

第一个选项是从RDS MySQL数据库中创建数据库快照, 然后将此快照恢复为MySQL

Aurora数据库｡

您可能会有一些停机时间,

因为在迁移到Aurora之前,

您必须停止第一个MySQL数据库上的操作｡

第二个选项是更连续的, 它是在RDS

MySQL之上使用和创建Amazon Aurora Read副本｡

所以这确实是一种可能｡ 

一旦副本延迟为零, 这意味着一旦Aurora副本完全赶上MySQL,

您就可以将其提升到自己的数据库集群中｡

现在, 这可能比数据库快照选项花费更多的时间,

并且由于可能与此复制关联的网络成本而花费一些资金｡

另一个选项是, 如果您有一个在RDS外部的MySQL数据库,

则可以使用Percona XtraBackup实用程序对其进行备份｡

这将创建一个备份文件, 您将其放在Amazon S3中,

然后Amazon Aurora提供了一个选项,

可以直接将此备份文件导入新的Aurora

MySQL DB集群｡

如您所知, 它仅支持Percona

XtraBackup实用程序｡

另一种选择是使用MySQL Dump实用程序对MySQL数据库运行它,

您可以将其输出通过管道传输到现有的Amazon Aurora数据库中｡

所以这需要很多时间,

而且这不能利用亚马逊S3｡

最后一个选项是使用Amazon DMS,

如果两个数据库都已启动并运行,

可以在两个数据库之间进行连续复制｡

我们对PostgreSQL做了同样的过程,

所以对RDS来说, 它非常相似｡

您有两种选择：使用恢复为Amazon Aurora数据库的数据库快照,

或者创建PostgreSQL的Amazon

Aurora读取副本以获得读取副本, 然后等到复制延迟为零时将其提升到自己的数据库集群中｡

如果您要将外部PostgreSQL数据库迁移到Aurora,

您可以创建它的备份,

然后将备份放入Amazon S3,

然后使用AWS S3 Aurora扩展导入数据, 这将创建一个新的数据库｡

最后, 您可以使用DMS从PostgreSQL连续迁移到Amazon

Aurora｡

好吧, 我会的 这节课到此为止｡ 

我希望你们喜欢它, 我们下节课再见｡
