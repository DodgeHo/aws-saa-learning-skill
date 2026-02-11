---
source: 18 - Containers on AWS ECS, Fargate, ECR & EKS\009 Amazon ECR_zh.srt
---

解说员：好的, 让我们来简单介绍一下Amazon

ECR｡

Amazon ECR是Elastic

Container Registry的缩写, 用于存储和管理AWS上的Docker映像｡

到目前为止, 我们一直在使用在线存储库, 如Docker

hub, 但我们也可以在Amazon

ECR上存储我们自己的图像｡

实际上, ECR有两种选择｡ 

我们可以只为您的帐户或您自己的帐户（带有s）私下存储图像,

或者您可以使用公共存储库并发布到Amazon

ECR公共图库｡

现在ECR与亚马逊ECS完全集成,

这太棒了｡

而您的图像则在Amazon

S3的后台存储｡

因此, 您的ECR存储库可能包含不同的Docker映像,

然后是ECS群集｡

例如, ECS集群上的EC2实例可能需要拉取这些映像｡

为此, 我们将为EC2实例签署一个IAM角色,

此IAM角色将允许我们的实例提取Docker映像｡

因此, 对ECR的所有访问都受到IAM的保护｡

这包括, 如果您在ECR上出现权限错误,

请查看您的策略,

然后在您的EC2实例拉取容器后,

它们将在您的EC2实例上启动｡

这就是ECS和ECR如何协同工作｡

现在, Amazon

ECR非常棒,

因为除了作为存储库之外,

它还支持图像漏洞扫描､

版本控制､ 图像标记和图像生命周期｡

因此, 总的来说,

任何时候你看到存储Docker图像认为ECR,

这应该是你在考试｡

好吧, 我会的

希望你喜欢｡ 

我们下节课再见｡
