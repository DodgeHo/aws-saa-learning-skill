---
source: 17 - Decoupling applications SQS, SNS, Kinesis, Active MQ\014 Kinesis Data Firehose Overview_zh.srt
---

教师：现在让我们来了解一项新的服务, 它是Kinesis

Data Firehose｡

因此, 这是一项非常有用的服务, 可以从生产者获取数据,

生产者可以是我们在Kinesis Data Streams中看到的所有内容, 因此应用程序､

客户端､ SDK或Kinesis代理都可以生成Kinesis Data Firehose｡

而且Kinesis数据流也可以生成Kinesis数据消防水管｡

Amazon CloudWatch云计算和事件可以生成Kinesis

Data Firehose｡

所有这些应用程序都会将记录发送到Kinesis

Data Firehose｡

然后Kinesis Data

Firehose可以选择使用Lambda函数转换数据｡

但这是可选的｡ 

一旦数据被转换, 可选地,

然后它可以批量写入目标｡

因此Kinesis Data Firehose从源获取数据｡ 

通常最常见的是Kinesis数据流｡ 

它会将这些数据写入目的地, 而无需您编写任何类型的代码,

因为Kinesis Data

Firehose知道如何写入数据｡

因此, Kinesis Data Firehose有三种目的地｡

排名第一的类别是AWS目的地,

您需要记住它们｡

首先是Amazon S3｡ 

因此, 您可以将所有数据写入Amazon S3｡ 

第二个是Amazon Redshift,

它是一个仓库数据库｡

为此, 它首先将数据写入Amazon S3, 然后Kinesis Data

Firehose将发出COPY命令｡

这个COPY命令将数据从Amazon

S3复制到Amazon Redshift｡

AWS上的最后一个目标是Amazon

OpenSearch｡

还有一些第三方合作伙伴的目的地｡ 

因此, Kinesis Data Firehose可以将数据发送到Datadog,

Splunk, New Relic, MongoDB｡

随着时间的推移, 这个列表会越来越大｡ 

所以如果有新的合作伙伴, 我不会更新这个｡ 

但您要知道, Kinesis Data

Firehose可以向一些合作伙伴发送数据｡

最后, 如果您有自己的API和HTTP端点, 则可以将数据从Kinesis

Data Firehose发送到自定义目标｡

好吧

因此, 一旦数据被发送到所有这些目的地, 您有两个选择｡

您还可以将所有数据发送到S3存储桶中作为备份,

或者将未能写入这些目标的数据发送到失败的S3存储桶中｡

总而言之, Kinesis Data

Firehose是一项完全托管的服务｡

因此, 没有管理, 自动扩展, 并且它是无服务器的｡

没有服务器需要管理｡ 

您可以将数据发送到AWS目的地, 如Redshift､

Amazon S3和OpenSearch;第三方合作伙伴,

如Splunk､ MongoDB､ Datadog､ New Relic等;和自定义目的地到任何HTTP端点｡

你只需要为通过Firehose的数据付费｡

这是一个很好的数据压缩模型｡ 

它几乎是实时的｡ 

为什么？为什么？

嗯, 因为我们将数据从Firehose批量写入目的地｡

因此, 对于非完整批处理, 将有60秒的最小延迟｡

或者你需要等待,

直到你有至少一个兆字节的数据在一个时间发送数据到目的地, 这使得它成为一个近实时服务,

而不是实时服务｡

它支持多种数据格式､

转换､ 转换和压缩｡

如果需要, 您可以使用Lambda编写自己的数据转换｡

最后, 您可以将所有失败或所有数据发送到备份S3存储桶中｡

因此, 考试中出现的一个问题通常是了解何时使用Kinesis

Data Streams和Kinesis

Data Firehose的区别｡

所以如果你仔细观察的话应该很容易｡ 

但让我们总结一下｡ 

Kinesis Data Streams是用于大规模摄取数据的流服务｡

你可以为你的生产者和消费者编写自己的定制代码｡

这是实时的

200毫秒或70毫秒｡ 

你自己管理扩展｡ 

你可以进行分片分割和分片合并来增加规模和吞吐量｡

您还将为您提供的容量付费｡

Kinesis数据流中的数据存储时间可以为1至365天｡

这允许多个消费者从同一个流访问,

并且还支持重播功能｡

Kinesis Data Firehose是一种摄取服务,

可将数据流传输到S3､ Redshift､ OpenSearch､

第三方或自定义HTTP｡

它是完全管理的, 没有服务要管理｡ 

它几乎是实时的｡ 

所以请记住, “近实时”是你需要在考试问题中看到的一个关键词｡

有自动缩放,

所以你不必担心它｡

而且你只需要为通过Kinesis

Data Firehose的东西付费｡

没有数据存储, 因此无法重播Kinesis

Data Firehose中的数据｡

所以, 是的, 它不支持重播功能｡ 

以上就是Kinesis Data Firehose的概述｡ 

我希望这是有意义的｡ 

下次课见｡
