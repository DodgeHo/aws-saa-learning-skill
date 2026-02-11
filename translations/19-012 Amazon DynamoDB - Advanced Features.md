---
source: 19 - Serverless Overviews from a Solution Architect Perspective\012 Amazon DynamoDB - Advanced Features_zh.srt
---

Stephane：那么让我们来讨论一下DynamoDB考试中可能出现的高级特性｡

第一个是DynamoDB加速器或DAX｡ 

因此, 这是一个完全托管､

高度可用且无缝的DynamoDB内存缓存｡

这个想法是, 如果你在DynamoDB表上有很多读操作,

那么你可以创建一个DAX集群, 通过缓存数据来解决读拥塞问题｡

使用DynamoDB DAX,

您可以获得缓存数据的微秒延迟｡

所以这是你在考试中必须注意的关键词｡

它不需要您更改任何应用程序逻辑,

因为DAX集群与现有的DynamoDB API兼容｡

所以你有你的DynamoDB表和你的应用程序,

你只需要创建一个由几个缓存节点组成的DAX集群,

连接到这个DAX集群｡

在后台, DAX集群连接到Amazon

DynamoDB表｡

缓存的默认TTL为五分钟, 但您可以更改此值｡

所以你可能会问我,

为什么我应该使用DAX而不是弹性缓存？

DAX位于DynamoDB的前面,

它将对单个对象缓存或查询以及扫描查询的缓存非常有帮助｡

但是, 如果你想存储聚合结果, 那么Amazon ElastiCache是一个很好的方法｡

因此, 如果您想存储在Amazon DynamoDB上完成的非常大的计算｡

所以它们不是彼此的替代品, 它们实际上是互补的｡

但大多数时候, 对于Amazon

DynamoDB之上的缓存解决方案, 它只会使用DynamoDB

Accelerator DAX｡

您还可以在DynamoDB之上执行流处理｡ 

这个想法是, 您希望拥有一个表上发生的所有修改的流｡

它会是创建､ 更新和删除｡ 

例如, 它的用例是实时响应DynamoDB表上的更改｡

例如, 每当用户表中有新用户时,

发送欢迎电子邮件｡

如果是这样, 您可能希望执行实时使用分析,

或者希望将数据插入派生表, 或者希望实现跨区域复制,

或者希望在DynamoDB表上进行任何更改时调用Lambda｡

DynamoDB上的两种流处理｡ 

你有DynamoDB Streams, 24小时保留,

消费者数量有限, 并且将与Lambda触发器一起使用｡

或者, 如果您想自己阅读它,

则有一种称为DynamoDB

Stream Kinesis Adapter的东西｡

或者, 您也可以选择将所有更改直接发送到Kinesis数据流｡

在这里, 您可以拥有长达一年的保留期, 您可以拥有更多的消费者,

并且您可以使用更多的方法来处理数据, 无论我们是否混合了Kinesis

Data Analytics,

Kinesis Data Firehose, Glue Streaming

ETL等功能｡

因此, 让我们看一下架构图, 以更好地理解DynamoDB

Streams｡

因此, 您的应用程序确实在DynamoDB表的顶部创建更新和删除操作,

该表将是DynamoDB Streams或Kinesis Data Streams｡

如果选择使用Kinesis数据流, 则可以使用Kinesis

Data Firehose｡

从这里, 您可以将数据发送到Amazon Redshift用于分析目的,

或者如果您想要归档一些数据, 则可以将数据发送到Amazon S3, 或者Amazon

OpenSearch在其上执行一些索引和一些搜索｡

或者, 如果您正在使用DynamoDB Streams,

则可以有一个处理层, 并且可以使用DynamoDB

KCL Adapter在EC2实例或Lambda函数上运行应用程序｡

然后, 在SNS上执行一些通知, 或者执行一些过滤和转换到另一个DynamoDB表中｡

或者使用处理层执行任何您想要的操作,

例如, 再次将数据发送到Amazon OpenSearch｡

所以我没有展示所有的可能性或者我们的架构｡

当然, 您可以让EC22实例从Kinesis

Data Streams读取｡

您可以在Kinesis Data Streams之上拥有Kinesis

Data Analytics等, 以及许多许多转换｡

但是, 您现在已经知道了足够多的信息,

可以确定在正确的时间什么是正确的架构｡

DynamoDB也有全局表的概念｡ 

因此, 一个全局表当然是一个将在多个区域中复制的表｡

所以你可以在美国东部1号和AP东南2号各有一张桌子｡

并且在表之间存在双向复制｡ 

这意味着您可以写入US-East-1和AP-Southeast-2中的表｡

因此, 全局表的想法是使DynamoDB在多个区域中以低延迟访问｡

而且它是主动-主动复制｡ 

这意味着您的应用程序可以读写任何特定区域中的表｡

要启用全局表, 您必须首先启用DynamoDB

Streams, 因为这是跨区域复制表的底层基础架构｡

DynamoDB还有一个名为Time To Live或TTL的特性｡ 

这个想法是你想在过期时间戳之后自动删除项目｡

所以你有你的表, SessionData,

然后你将有一个最后的属性ExpTime,

这是你的TTL, 它有一个时间戳｡

这个想法是你要定义一个TTL｡ 

只要Epoch时间戳中的当前时间超过ExpTime列,

它就会自动使项目过期, 并最终通过删除过程将其删除｡

所以这个想法是, 数据表中的项目将在一段时间后被删除｡

因此, 这方面的用例将是通过仅保留最新的项目来存储数据,

或者通过例如在两年后删除数据来遵守监管义务｡

另一个在考试中非常常见的用例是Web会话处理｡

所以用户会登录到你的网站, 然后会有一个会话｡

您可以将会话保留在一个中心位置,

例如DynamoDB两个小时｡

您可以在那里设置会话数据,

任何类型的应用程序都可以访问它｡

在某个时刻, 两个小时后,

如果它还没有被更新,

那么它将过期并从这个表中移走｡

您还可以使用DynamoDB进行灾难恢复｡ 

那么, 您的备份选项是什么？

您可以使用时间点恢复（PITR）进行连续备份｡

所以它是可选启用的,

但你可以在过去的35天内使用它｡

然后, 如果您启用它,

您可以在备份窗口内的任何时间执行时间点恢复｡

如果你碰巧做了一个恢复,

那么它将创建一个新表｡

如果您希望进行长期备份,

则可以使用按需备份,

这些备份将一直保留到您显式删除它们为止｡

执行这些类型的备份不会影响DynamoDB表的性能或延迟｡

如果你想更好地管理你的备份,

你可以使用AWS备份服务,

这将使你能够为你的备份等制定生命周期策略｡

此外, 还可以跨区域复制备份以进行灾难恢复｡

同样, 如果您要恢复其中一个备份,

它将创建一个新表｡

现在, 让我们讨论一下DynamoDB和Amazon

S3之间的集成｡

因此您可以像这样将表导出到S3｡ 

为此, 您必须启用时间点恢复, 并将DynamoDB表导出到S3中｡

例如, 如果您想要执行一些查询, 例如使用Amazon

Athena引擎｡

因此, 您可以在过去35天内的任何时间点导出,

因为您已启用连续备份｡

并且在导出时,

这不会影响表的读取容量或性能｡

因此, 您可以通过首先通过Amazon

S3导出, 在DynamoDB之上执行数据分析｡

您还可以使用它来保留快照以进行审计, 或者执行任何类型的大型转换,

例如, 在将数据导入回新的DynamoDB表之前, 可能需要对数据进行任何ETL｡

导出的格式可以是DynamoDB JSON或ION格式｡

同样, 您可以导入到Amazon S3｡ 

因此, 您可以从S3导出为CSV､ JSON或ION格式, 并返回到新的DynamoDB表中｡

这不会消耗任何写容量, 它将创建一个新表｡

如果有任何导入错误, 它们将记录在CloudWatch日志中｡

这就是DynamoDB｡  希望你喜欢｡ 

我们下节课再见｡
