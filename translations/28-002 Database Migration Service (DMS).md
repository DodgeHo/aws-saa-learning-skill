---
source: 28 - Disaster Recovery & Migrations\002 Database Migration Service (DMS)_zh.srt
---

讲师：假设您想要将数据库从本地系统迁移到AWS云｡

在这种情况下, 您应该使用DMS或数据库迁移服务｡

它是一种快速安全的数据库服务, 允许您将数据库从内部部署迁移到AWS,

但最酷的是它具有弹性和自我修复能力｡

在迁移的同时,

源数据库仍然可用｡

它支持多种类型的引擎, 例如从Oracle到Oracle或从Postgres到Postgres的同构迁移,

以及异构迁移｡

例如, 如果您想从Microsoft

SQL Server一直迁移到Aurora,

并且它支持使用CDC（即变更数据捕获）进行连续数据复制｡

最后, 要使用DMS,

您需要创建一个EC2实例, 该EC2实例将为您执行复制任务｡

所以很简单, 您的源数据库可能是内部部署的,

然后您正在运行一个具有DMS软件的EC2实例,

它将连续地从源数据库中提取数据,

并将其放入目标数据库中｡

所以问题是来源和目标是什么？

你不需要记住所有的, 但重要的是要看到的,

只是为了理解DMS背后的概念｡

因此, 源可以是本地数据库或基于EC2实例的数据库,

例如Oracle､ Microsoft

SQL Server､ MySQL､ MariaDB､ PostgreSQL､

MongoDB､ SAP和DB2｡

它也可以是Azure数据库, 例如Azure SQL数据库｡ 

它可以是Amazon RDS, 包括Aurora在内的任何数据库｡ 

它可以是Amazon S3和DocumentDB｡ 

在目标方面, 我们也有不同的选择｡

我们有本地和EC2实例数据库｡ 

所以我们可以有Oracle, Microsoft SQL Server, MySQL,

MariaDB, PostgreSQL, SAP｡

我们也可以在Amazon RDS上拥有任何数据库｡ 

我们可以有Redshift, DynamoDB, Amazon

S3, 开源服务, Kinesis Data Streams, Apache

Kafka, DocumentDB和Amazon Neptune, 以及Redis和Babelfish｡

当然, 您不需要记住所有这些,

但总体思路是, DMS可以帮助您获取数据库,

例如, 内部部署数据库, 并将其放置､

导出和迁移到目标上, 即AWS提供的任何数据库｡

如果你理解了这一点,

那么你就有了DMS背后的一般思想｡

那么, 如果源数据库和目标数据库没有相同的引擎会怎样呢？

然后, 您需要使用称为AWS SCT的模式转换工具,

它将数据库模式从一个引擎转换到另一个引擎｡

例如, 如果您正在使用OLTP, 我们可以从SQL Server或Oracle迁移到MySQL,

PostgreSQL或Aurora｡

正如您在左侧看到的, 数据库引擎与右侧的不同,

但您也可以转换为分析流程,

例如Teradata或Oracle,

一直到Amazon Redshift｡

因此, 这里的想法是, 源数据库与目标数据库具有不同的引擎｡

在中间, 我们有DMS,

但它现在也运行SCT, 或模式转换工具｡

在考试中需要知道的是,

如果要迁移相同的数据库引擎, 则不需要使用SCT｡

因此, 如果您正在执行本地PostgreSQL到RDS PostgreSQL,

它是相同的数据库代理, 它是PostgreSQL｡

因此, 你不会使用SCT｡ 

但是如果你正在做一些事情, 比如Oracle到Postgres,

那么你就需要使用SCT｡

正如您所知, 数据库代理是PostgreSQL,

但RDS只是我们用来运行此数据库引擎的平台｡

那么, 如何为DMS设置连续复制呢？

例如, 您的企业数据中心将Oracle数据库作为源,

将Amazon RDS数据库作为目标｡

我们可以看到,

我们有两种不同类型的数据库｡

因此, 在这种情况下, 我们必须使用SCT, 否则它将无法工作｡

模式转换工具｡ 

因此, 我们设置了一个安装了AWS SCT的服务器,

我们可以在本地设置它,

这是最佳实践, 然后我们将模式转换到运行MySQL的Amazon

RDS数据库中｡

然后, 我们可以设置一个DMS复制实例,

该实例将执行完全加载和更改数据捕获CDC, 以进行连续复制｡

因此, 它将通过读取本地数据库､

源Oracle数据库并将数据插入到您的私有子网中来执行数据迁移｡

就是这样 这就是所有你需要知道的DMS｡ 

这是数据库迁移服务｡ 

请记住, 无论何时您要从两种不同类型的数据库进行迁移,

都需要使用SCT｡

对于DMS, 有多AZ部署｡ 

因此, 当您有了这个备份副本时,

您在一个AZ中有一个DMS复制实例, 然后您可以将该实例同步复制到另一个AZ中,

这将是一个备用复制副本｡

因此, 使用这种方法的好处当然是可以恢复特定可用区中的故障,

而且还可以提供数据冗余,

消除IO冻结并最大限度地减少延迟峰值｡

这节课就到这里｡ 

希望你们喜欢, 下次课再见｡
