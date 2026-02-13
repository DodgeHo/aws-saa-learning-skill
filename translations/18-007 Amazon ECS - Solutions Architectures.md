**学习目标**
- 理解常见的 ECS 解决方案架构模式（事件驱动、定时任务、队列驱动）
- 掌握使用 EventBridge、SQS、ALB 与任务角色的集成方式

**重点速览**
- EventBridge 可触发 ECS 任务（事件驱动或定时调度）
- S3 + EventBridge + ECS 常用于处理上传对象并将结果写入 DynamoDB
- SQS 与 ECS 配合可实现队列驱动的可扩展消息处理，结合 ECS 服务自动缩放

**详细内容**
示例架构：
- S3 上传事件通过 EventBridge 触发 ECS 任务（Fargate），任务使用任务角色访问 S3、处理对象并将结果写入 DynamoDB，实现无服务器的数据处理流水线。
- 定时任务：EventBridge 定时规则每小时触发 ECS 任务用于批处理作业。
- 队列集成：应用将消息推送到 SQS 队列，ECS 服务从队列拉取并处理消息；结合服务自动缩放，可根据队列长度动态调整任务数量。

EventBridge 还可接收 ECS 任务生命周期事件（如任务停止），用于触发 SNS 通知或其他自动化响应。

**自测问题**
- 如何用 EventBridge 实现定时运行 ECS 任务？
- SQS 与 ECS 结合时如何保证处理能力随队列增长而扩展？
- 在事件驱动架构中，为什么需要为任务配置任务角色？
---
source: 18 - Containers on AWS ECS, Fargate, ECR & EKS\007 Amazon ECS - Solutions Architectures_zh.srt
---

讲师：现在, 我们来谈谈您可能会在Amazon

ECS中遇到的几种解决方案架构｡

第一个是由Event Bridge调用的ECS任务｡ 

例如, 假设我们有一个Amazon

ECS集群, 它由Fargate支持, 我们有S3存储桶｡

我们的用户将把对象上传到我们的S3存储桶中, 这些S3存储桶可以与Amazon

Event Bridge集成,

将所有事件发送到它｡

Amazon Event Bridge可以有一个规则来在旅途中运行ECS任务｡

现在, 当要创建ECS任务时,

它们将具有与之关联的ECS任务角色,

并且从任务本身它可以做的是它可以获取对象,

处理它, 然后将结果发送到Amazon DynamoDB｡

这要归功于我们有一个与之关联的ECS任务角色｡

因此, 在这里, 我们所做的是,

我们已经创建了一个无服务器架构来处理图像,

或处理对象, 使用Docker容器从您的S3桶｡

这就是在Fargate模式下使用Amazon Event

Bridge ECS, 以及ECS任务角色与Amazon

S3和Amazon DynamoDB进行通信｡

再次使用事件桥的另一个架构是使用事件桥调度｡

因此, 我们有一个由Fargate和Amazon

Event Bridge支持的Amazon ECS集群,

我们计划每1小时触发一次规则｡

现在, 这个规则将在Fargate中为我们运行ECS任务, 这意味着每隔1小时,

我们的Fargate集群中就会创建一个新任务,

该任务可以做任何我们想要的事情｡

例如, 我们可以创建一个可以访问Amazon

S3的ECS任务角色, 因此我们的任务, 我们的Docker容器,

我们的程序可以每隔1小时对Amazon

S3中的一些文件进行一些批处理｡

同样, 所有这些架构都是完全无服务器的｡ 

最后一个例子是使用ECS和SQS队列,

因此我们可以在ECS上有一个服务, 它有两个ECS任务,

消息被发送到SQS队列中,

服务本身从SQS队列中提取消息并处理它们｡

我们可以在此服务之上启用ECS服务自动扩展｡

这意味着, 例如, 我们的SQS队列中的消息越多,

我们将有更多的任务进入我们的ECS服务,

这要归功于自动伸缩｡

另一个集成是当您希望使用事件桥来实际拦截ECS集群中的事件时｡

例如, 假设您希望对退出的任务做出反应｡

在这种情况下, 在ECS集群中退出或启动的任何任务都可以作为事件桥中的事件触发,

它看起来像这样｡

例如, ECS任务状态更改为“已停止”和停止原因｡

然后从那里, 例如, 我们可以提醒SNS主题并向管理员发送电子邮件｡

因此, 底线是, Event Bridge确实允许您了解ECS集群中容器的生命周期｡

好了, 这节课就到这里｡ 

我希望你们喜欢, 我们下次课再见｡
