---
source: 26 - AWS Security & Encryption KMS, SSM Parameter Store, Shield, WAF\011 AWS Secrets Manager - Overview_zh.srt
---

教师：现在我们来讨论一个非常简单的服务,

称为AWS Secrets Manager｡

这是一种较新的服务, 用于存储机密,

它将与SSM参数存储区不同, 因为在Secrets

Manager上, 您可以强制每隔X天轮换一次机密,

因此您可以获得更好的机密管理计划｡

最重要的是, 在Secrets

Manager中, 您可以强制和自动生成循环中的机密｡

为此, 你必须定义一个Lambda函数,

它将生成新的秘密｡

而且, Secrets Manager确实很好地与AWS上的不同服务集成在一起｡

我刚刚向大家展示了Amazon RDS,

例如MySQL､ PostgreSQL､ SQL或Aurora｡

但是AWS还有其他服务, 其他数据库,

它们与Secrets Manager集成在一起｡

这意味着进入您的数据库的用户名和密码直接存储在Secrets

Manager中, 并且可以循环使用等等｡

现在, 可以使用KMS服务对机密进行加密｡ 

所以在考试中, 任何时候你看到Secrets,

或者RDS的集成, 或者Aurora的Secrets,

都要考虑一下Secrets Manager｡

还有一个特性我们需要了解,

那就是多区域Secrets的概念｡

因此, 这个想法是, 你可以复制你的秘密跨多个AWS地区和秘密管理器服务将保持读者与主要的秘密同步｡

所以这里有两个区域｡ 

我们在主区域中创建一个Secret,

然后将其作为同一个Secret复制到辅助区域中｡

我们为什么要这么做？

嗯, 很多事情｡ 

第一, 如果美国东部1出现问题, 您可以将副本Secret提升为独立的Secret｡

由于Secret可以跨地区复制,

因此您可以构建多个地区的应用程序｡

您还可以有灾难恢复策略, 或者如果您有一个RDS数据库,

也要从一个区域复制到下一个区域, 那么您可以使用相同的密码来访问相应区域中的相应RDS数据库｡

这节课就讲到这里｡ 

我希望你们喜欢, 下节课再见｡
