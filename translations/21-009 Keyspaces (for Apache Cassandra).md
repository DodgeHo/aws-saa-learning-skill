---
source: 21 - Databases in AWS\009 Keyspaces (for Apache Cassandra)_zh.srt
---

教师：现在我们来谈谈Amazon Keyspaces,

Keyspaces是AWS上的一个托管Apache Cassandra｡

Cassandra是一个开源的NoSQL分布式数据库, 因此,

通过Keyspaces,

你可以直接在云上由AWS管理Cassandra｡

因此, 它将是一种无服务器类型的服务,

具有可扩展性和高可用性,

完全由AWS管理, 并将根据应用程序的流量自动缩放表｡

表的数据将在多个AZ中复制三次,

为了在Keyspace上执行查询,

您将使用Cassandra查询语言（CQL）｡

因此, 在任何规模下,

您都可以获得单位数毫秒的延迟, 并且每秒可以处理数千个请求｡

需要注意两种容量模式, 这与DynamoDB类似,

即按需模式和带自动扩展功能的调配模式,

这些与DynamoDB实际上是相同的｡

您可以获得加密功能､ 备份､ 长达35天的时间点恢复,

因此, 使用案例将是存储物联网设备信息､ 时间序列数据, 一般来说,

从考试的角度来看, 只要您看到Apache Cassandra, 您只需想到Amazon Keyspaces, 就可以完成了｡

好了, 这节课就讲到这里,

希望你们喜欢, 我们下节课再见｡
