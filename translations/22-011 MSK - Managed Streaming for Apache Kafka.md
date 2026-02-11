---
source: 22 - Data & Analytics\011 MSK - Managed Streaming for Apache Kafka_zh.srt
---

解说员：您将看到的另一个分析服务是Amazon

Managed Streaming for Apache Kafka,

也称为Amazon MSK｡

什么是卡夫卡？

卡夫卡是亚马逊运动的替代品｡ 

Kafka和Kinesis都允许您流式传输数据｡ 

因此, MSK是在AWS上获得完全托管的Kafka集群的能力｡

它还允许您动态创建､

更新和删除集群｡

MSK将为您创建和管理集群中的Kafka代理节点和Zookeeper代理节点,

您可以在VPC中跨多个AZ（最多三个）部署集群, 以实现高可用性｡

您还可以从常见的Kafka故障中自动恢复, 并且数据可以在EBS卷上存储任意长的时间｡

根据我的个人经验, 我知道设置Apache

Kafka非常困难, 事实上, 你只需点击一下, 然后在AWS上部署Kafka就很棒了, 这就是Amazon

MSK服务｡

因此, 除此之外, 您还可以选择使用MSK无服务器｡ 

您可以在MSK上运行Apache

Kafka, 但这一次您不配置服务器,

也不管理容量, MSK将自动为您配置资源和扩展､

计算和存储｡

那么, 阿帕奇·卡夫卡是什么呢？

Apache Kafka是一种数据流传输的方式,

Kafka集群由多个代理组成, 然后你会有生产者来生产数据, 所以他们必须从Kinesis､ IoT

RDS等地方接收数据, 然后他们会将数据直接发送到Kafka主题,

该主题将被完全复制到其他代理｡

现在, 这个卡夫卡主题有实时的数据流,

消费者将从主题中提取数据来消费数据本身, 然后你的消费者可以做任何他想做的事情,

处理数据或将数据发送到各种目的地,

如EMR､ S3､ SageMaker､

Kinesis和RDS｡

所以卡夫卡的想法是, 他和动理学很相似,

但也有不同之处要注意｡

那么, Kinesis数据流和Amazon

MSK之间有什么区别呢？

在Kinesis Data

Streams中, 您有1 MB的消息限制,

这是Amazon MSK中的默认值, 但您可以将其配置为更高的消息保留率｡

例如, 10兆字节｡ 

你可以在Kinesis数据流或MSK中有带碎片的数据流,

它被称为带分区的卡夫卡主题,

但概念有点相似｡

要缩放Kinesis数据流,

您需要进行碎片分割并缩小合并｡

但在Amazon MSK中要缩放一个主题,

只能添加分区｡

不能删除分区｡ 

您可以对Kinesis数据流进行动态加密,

然后对MSK进行纯文本或TLS动态加密｡

这两个群集的加密都存在风险,

在考试级别, 这就足够了｡

只是想让你知道, 有一些不同｡ 

此外, 对于Amazon MSK, 您可以将数据保留任意长的时间,

您可以保留一年以上, 只要您为底层EBS存储付费,

您就可以随时使用｡

因此, 要生产到MSK, 您需要创建一个卡夫卡生产者,

然后从MSK消费, 您有多种选择｡

第一个是使用Apache Flink的Kinesis数据分析｡

因此, 您需要一个Flink应用程序,

并让它直接从MSK集群中读取｡

您也可以使用Glue来执行流ETL作业, 它们由Apache

Spark Streaming提供支持｡

您可以使用Lambda函数直接将Amazon

MSK作为事件源, 或者您可以编写自己的Kafka消费者,

并使其在您希望的任何平台上运行,

例如, Amazon EC2实例､ ECS集群或EKS集群｡

一旦你知道了这一点,

你就知道了亚马逊MSK考试中需要知道的一切｡

我希望你们喜欢,

下节课再见.
