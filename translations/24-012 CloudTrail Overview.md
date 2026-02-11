---
source: 24 - AWS Monitoring & Audit CloudWatch, CloudTrail & Config\012 CloudTrail Overview_zh.srt
---

解说员：现在我们来谈谈CloudTrail｡ 

因此, CloudTrail是一种为您的AWS帐户获取治理合规性和审计的方法｡

默认情况下启用CloudTrail｡ 

这将允许您通过控制台､ SDK､ CLI和AWS上的其他服务获取AWS帐户内的所有事件和API调用的历史记录,

所有这些日志都将显示在CloudTrail中｡

现在, 您可以做的是, 您也可以将这些日志从CloudTrail放入CloudWatch

Logs或Amazon S3｡

如果您想将所有区域中累积的所有这些事件历史记录累积到一个特定的存储区（例如S3存储区）中,

则可以创建要应用于所有区域或单个区域的跟踪｡

例如, 当我们使用CloudTrail时,

我们会说有人在AWS中删除了一些东西｡

例如, 假设一个EC2实例被终止,

你想找出是谁干的？

好吧, 答案是查看CloudTrail,

因为CloudTrail将在其中包含该API调用, 并且能够深入了解它并了解谁在何时做了什么｡

因此, 总结一下, CloudTrail位于中间,

SDK､ CLI或控制台甚至IAM用户和IAM角色或其他服务的操作都将在CloudTrail控制台中｡

我们可以查看它来检查和审计发生了什么｡ 

如果你想拥有超过90天的所有事件, 那么我们可以将它们发送到CloudWatch日志中,

或者我们可以将它们发送到S3存储桶中｡

所以让我对CloudTrail深入一点｡ 

所以我们有三种类型的事件, 你可以在CloudTrail中看到｡

第一个称为管理事件,

这些事件表示对AWS帐户中的资源执行的操作｡

例如, 每当有人配置安全性时, 他们将使用名为IAM

AttachRolePolicy的API调用｡

这将出现在CloudTrail中｡ 

如果您创建了子网, 也会显示此信息｡ 

如果您设置了日志记录, 则默认情况下会显示此信息｡ 

任何修改您的资源或iOS帐户的内容都将显示在CloudTrail中｡

默认情况下, 无论发生什么,

都将跟踪配置为记录管理事件｡

您可以区分两种管理事件｡ 

您拥有不修改资源的读取事件｡ 

例如, 有人列出了IAM中的所有用户,

或者列出了EC2中的所有EC2实例, 诸如此类｡

您可以将它们与可能修改资源的写入事件分开｡

例如, 有人删除或试图删除DynamoDB表｡

显然, 写事件可能更重要,

因为它们可能会破坏您的AWS基础设施｡

而读取事件只是为了获取仍然非常重要的信息,

但可能破坏性较小｡

然后是数据事件｡ 

因此, 它们是独立的, 默认情况下不会记录数据事件,

因为它们是高容量操作｡

什么是数据事件？

您有Amazon S3对象级别的活动, 例如GetObject､

DeleteObject､ PutObject｡

正如您所看到的,

这些情况在S3铲斗上经常发生｡

这就是为什么默认情况下它们不会被记录,

并且您可以选择再次分离读取和写入事件｡

因此, 读取事件将是GetObject, 而右事件将是DeleteObject或PutObject｡

CloudTrail中的另一种事件是AWS

Lambda函数执行活动｡

因此, 无论何时有人使用Invoke API,

您都可以了解Lambda函数被调用的次数｡

同样, 如果你的Lambda函数被执行了很多次,

这可能是非常高的容量｡

CloudTrail中的第三种事件称为CloudTrail

Insights事件｡

因此, 我将在下一张幻灯片中详细介绍CloudTrail

Insights｡

现在让我们来谈谈CloudTrail Insights｡ 

因此, 当我们在所有类型的服务中有如此多的管理事件,

并且在您的帐户中有如此多的API快速发生时, 很难理解什么看起来很奇怪,

什么看起来不寻常, 什么看起来不寻常｡

这就是CloudTrail Insights的用武之地｡ 

因此, 使用CloudTrail Insights,

您必须启用它, 并且必须支付费用, 它将分析您的事件并尝试检测您帐户中的异常活动｡

例如, 在准确的资源调配､ 达到服务限制､

AWS IAM操作的突发､ 定期维护活动的间隙等方面｡

因此, 它的工作方式是CloudTrail将分析正常管理活动的外观以创建基线,

然后它将不断分析任何正确类型的事件｡

因此, 每当有东西被改变或试图被改变时,

就可以检测到不寻常的模式｡

因此, 很简单, 管理事件将由CloudTrail Insights持续分析,

如果检测到某些情况, CloudTrail Insights将生成Insights Event｡

因此这些异常, 这些洞察事件将出现在CloudTrail控制台中｡

如果你愿意, 它们也会被发送到亚马逊行业, 以及一个EventBridge事件｡

因此, 在CloudWatch中, 如果您需要在这些CloudTrail

Insights之上自动化, 例如发送电子邮件,

将生成事件｡

这就是CloudTrail Insights背后的想法｡ 

最后, 让我们谈谈CloudTrail事件保留｡ 

因此, 默认情况下, 事件在CloudTrail中存储90天,

然后将其删除, 但有时您可能希望将事件存储更长时间,

以防您想要返回到一年前发生的事件以进行审计｡

因此, 要将事件保存在此期间之外,

您必须将它们记录到S3｡

所以把它们发送到S3, 然后你会用雅典娜来分析它们｡

因此, 非常简单, 您的所有管理事件, 数据事件和洞察事件都将进入CloudTrail

90天, 保留期｡

然后, 您将这些记录到S3存储桶中,

以便长期保留｡

当你准备好分析它们的时候,

你可以使用Athena服务,

这是一个无服务器的服务, 在S3中查询数据,

找到事件, 好的, 希望你们喜欢这节课,

下次课再见｡
