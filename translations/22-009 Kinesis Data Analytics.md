---
source: 22 - Data & Analytics\009 Kinesis Data Analytics_zh.srt
---

讲师：现在我们来谈谈Kinesis数据分析｡

它有两种口味｡ 

第一个是SQL应用程序, 第二个是Apache

Flink｡

我们先来谈谈第一种, 即适用于SQL应用程序的Kinesis

Data Analytics｡

所以它坐在中心｡ 

它能够读取的两个数据源是Kinesis Data

Streams和Kinesis Data Firehose｡

因此, 您可以从其中的任何一个中读取,

然后您可以应用SQL语句来执行实时分析｡

您还可以通过引用Amazon S3存储桶中的一些引用数据来连接它们｡

例如, 这将允许您实时丰富数据｡

然后, 您可以将数据发送到不同的目的地,

其中有两个｡

第一个是Kinesis数据流｡ 

因此, 您可以从Kinesis

Data Analytics实时查询中创建一个流, 也可以直接将其发送到Kinesis

Data Firehose中, 每个都有自己的用例｡

如果您直接发送到Kinesis Data Firehose,

则可以发送到Amazon S3､ Amazon Redshift或Amazon

OpenSearch或任何其他Firehose目的地｡

而如果您将其发送到Kinesis数据流中,

则可以使用AWS Lambda或您在EC2实例上运行的任何应用程序对该数据流进行实时处理｡

请记住这个图表, 这是Kinesis

Data Analytics for SQL Applications｡

现在, 如果我们进入细节, 正如我所说的,

这两个来源只是Kinesis数据流和Firehose｡

您可以使用Amazon S3中的数据进行丰富｡ 

这是一个完全托管的服务,

您不需要配置任何服务器｡

有自动缩放, 你实际上支付通过Kinesis

Data Analytics的任何东西｡

在输出方面, 正如我所说, 你可以进入Kinesis

Data Streams或Kinesis

Data Firehose｡

用例将是进行时间序列分析､

实时仪表板或实时指标｡

这就是第一种Kinesis数据分析｡ 

Kinesis Data Analytics for Apache Flink｡ 

因此, 正如名称所示,

您可以在服务上实际使用Apache Flink｡

因此, 如果您使用Flink,

您可以使用Java､

Scala甚至SQL编写应用程序来处理和分析流数据｡

所以你可能会说, “好吧,

这是一回事, 不是吗, 从以前？ 但事实并非如此

所以Flink是你需要编写代码的特殊应用程序｡ 

它允许您实际上可以在Kinesis Data Analytics上专用的集群上运行这些Flink应用程序｡

但这都是幕后的事｡ 

使用Apache Flink, 您可以从两个主要的数据源读取数据,

您可以从Kinesis Data Streams或Amazon

MSK读取数据｡

因此, 使用此服务, 您可以在AWS上的托管集群上运行任何Flink应用程序｡

这个想法是Flink将比标准SQL强大得多｡

因此, 如果您需要高级查询功能,

或从其他服务（如Kinesis

Data Streams或Amazon MSK）读取流数据, 则您可以使用此服务｡

因此, 通过此服务,

您可以自动配置计算资源､

并行计算和自动扩展｡

您可以获得应用程序备份, 它们被实现为检查点和快照｡

您可以使用任何Apache Flink编程功能｡ 

正如你所知道的, 使用Flink, 你只能从Kinesis数据流和亚马逊MSK中读取｡

您无法读取Kinesis Data Firehose｡ 

如果您需要在Kinesis Data Firehose上阅读并进行实时分析,

则必须使用Kinesis Data Analytics for

SQL｡

好了, 这节课就到这里了｡ 

希望你喜欢｡ 

下次课见｡
