---
source: 24 - AWS Monitoring & Audit CloudWatch, CloudTrail & Config\003 CloudWatch Logs_zh.srt
---

教师：那么, 现在让我们来谈谈CloudWatch日志｡ 

因此, CloudWatch Logs是在AWS中存储应用程序日志的理想位置｡

为此, 您必须首先定义日志组｡ 

它们可以是您想要的任何名称,

但通常它们代表您的一个应用程序｡

然后, 在日志组中, 您将拥有多个日志流,

它们表示应用程序中的日志实例,

或作为集群一部分的特定日志文件或特定容器｡

然后定义日志过期策略｡ 

因此, 您可以无限期地保留日志, 使其永不过期,

也可以选择使其在1天到10年之间的任何时间过期｡

也可以将您的CloudWatch日志发送到不同的目的地｡

例如, 将它们批量导出到Amazon S3或将它们流式传输到Kinesis

Data Streams､ Kinesis Data Firehose､

AWS Lambda､ Amazon OpenSearch｡

默认情况下, 所有日志都是加密的,

如果需要, 您可以使用自己的密钥设置自己的基于KMS的加密｡

那么, 现在什么样的日志数据进入CloudWatch日志？

现在, 哪些类型的日志可以进入CloudWatch日志？

我们可以使用SDK或CloudWatch Logs Agent或CloudWatch

Unified Agent发送日志｡

现在, CloudWatch统一代理将日志发送到CloudWatch,

因此CloudWatch日志代理现在有点不推荐使用｡

您有Elastic Beanstalk, 它用于将日志从应用程序直接收集到CloudWatch中｡

ECS会将日志直接从容器发送到CloudWatch｡

Lambda将从函数本身发送日志｡ 

VPC流日志将发送特定于您的VPC元数据网络流量的日志｡

API网关将向API网关发出的所有请求发送到CloudWatch日志中｡

CloudTrail, 您可以根据过滤器直接发送日志｡

Route53将记录对其服务进行的所有DNS查询｡

那么, 如果您想查询CloudWatch Logs中的日志呢？

为此, 您可以使用CloudWatch Logs Insights｡ 

因此, 它是CloudWatch Logs中的查询功能,

允许您编写查询｡

您指定要应用查询的时间段,

然后自动获得可视化结果｡

此外, 您还可以查看创建此可视化的特定日志行｡

此可视化也可以作为结果导出或添加到仪表板,

以便能够随时重新运行它｡

因此, 这非常方便, 这将允许您在CloudWatch

Logs中搜索和分析日志数据｡

因此, CloudWatch Logs

Insights控制台提供了许多简单的查询｡

例如, 您可以找到最近的25个事件, 或者您可以查看日志中有多少事件发生异常或错误,

或者您可以查找特定的IP等等｡

因此, 它提供了一种专门构建的查询语言｡ 

允许您构建查询的所有字段都会从CloudWatch日志中自动检测到,

然后您可以根据条件进行筛选｡

您可以计算聚合统计信息､

对事件进行排序､ 限制事件数量等等｡

因此, 正如我所说, 您可以保存查询并将其添加到CloudWatch仪表板｡

您还可以一次查询多个日志组,

即使它们位于不同的帐户中｡

请记住, CloudWatch Logs Insights是一个查询引擎,

而不是实时引擎｡

因此, 当您运行查询时,

它将只查询历史数据｡

如前所述, CloudWatch日志可以导出到多个目的地｡

第一个是Amazon S3｡ 

因此, 这是一个批量导出, 将所有日志发送到Amazon

S3, 此导出可能需要长达12个小时才能完成｡

启动此导出的API调用称为CreateExportTask｡

因为这是批输出, 所以不是实时或接近实时的｡

相反, 您必须使用CloudWatch Logs订阅｡ 

因此, 这些允许您获得这些日志事件的实时流,

并且您可以进行处理和分析｡

因此, 您可以将此数据发送到多个位置, 例如Kinesis Data

Streams､ Kinesis Data Firehose或Lambda｡

您还可以指定一个订阅筛选器, 以说明您希望将哪种日志事件传递到目标｡

因此, 订阅过滤器可以将数据发送到Kinesis数据流｡

例如, 如果您想使用与Kinesis

Data Firehose､

Kinesis Data Analytics或Amazon EC2或Lambda的集成,

这将是一个很好的选择｡

您也可以直接将其发送到Kinesis Data Firehose｡ 

从那里, 您可以以近乎实时的方式将其发送到Amazon

S3, 或者例如OpenSearch Service,

或者您有Lambda｡

因此, 您可以编写自己的自定义Lambda函数,

也可以使用托管Lambda函数将数据实时发送到OpenSearch

Service｡

最重要的是, 由于这些订阅过滤器,

您可以将来自不同CloudWatch日志的数据聚合到不同帐户和不同区域,

并将其聚合到一个共同的目标, 例如特定帐户中的Kinesis数据流｡

然后是Kinesis Data Firehose｡ 

然后以近乎实时的方式进入Amazon S3｡ 

所以这是非常可能的,

这是一种执行日志聚合的方法｡

因此, 这是如何工作的本质是,

你必须使用所谓的目的地｡

因此, 假设您有一个发件人帐户和收件人帐户｡

因此, 您创建了一个CloudWatch日志订阅过滤器,

然后将其发送到订阅目的地, 这是接收者帐户中Kinesis数据流的虚拟表示｡

然后附加一个目标访问策略,

以允许第一个帐户将数据实际发送到此目标｡

然后, 在收件人帐户中创建IAM角色,

该角色有权将记录发送到Kinesis数据流中,

并确保第一个帐户可以承担此角色｡

当你有了所有这些东西,

那么你就有可能将数据从一个帐户中的CloudWatch日志发送到另一个帐户中的目的地｡

这节课就到这里｡ 

我希望你们喜欢, 我们下次课再见｡
