**学习目标**
- 理解 Amazon EKS 的定位与 Kubernetes 基本概念
- 掌握 EKS 的节点类型与数据存储选项

**重点速览**
- Amazon EKS 是 AWS 的托管 Kubernetes 服务，支持 EC2 与 Fargate 启动模式
- 可使用托管节点组（Managed）、自管理节点或 Fargate，无需或少量运维节点
- 存储通过 CSI 驱动挂载，常见选项包含 EBS、EFS、FSx 等；EFS 可与 Fargate 配合使用

**详细内容**
Kubernetes 是开源容器编排平台，使用 Pod 模型管理容器。Amazon EKS 提供托管控制平面并支持多种节点部署方式：
- 托管节点组（Managed Node Group）：AWS 帮助创建并维护节点（基于 EC2 与 ASG）
- 自管理节点：用户自行创建与注册节点，适合高度自定义场景
- Fargate：无服务器模式，不需管理节点，适合简化运维

存储方面需定义 StorageClass 并使用 CSI 驱动以支持 EBS、EFS（跨 AZ 共享，且可与 Fargate 配合）与 FSx。EKS 适合已有 Kubernetes 经验或需要多云/可移植性的团队。

**自测问题**
- EKS 与 ECS 在适用场景上有何不同？
- EKS 支持哪几类节点部署方式？
- 哪种存储可以在 Fargate 模式下使用？
---
source: 18 - Containers on AWS ECS, Fargate, ECR & EKS\010 Amazon EKS - Overview_zh.srt
---

教师：那么, 让我们来谈谈在AWS上运行容器的另一种方法,

这就是使用Amazon EKS｡

因此, Amazon EKS代表亚马逊弹性Kubernetes服务｡ 

因此, 正如名称所示, 这是一种在AWS上启动和管理Kubernetes集群的方法｡

那么, 什么是Kubernetes？

这是你在屏幕右上角看到的蓝色标志｡

Kubernetes是一个开源系统,

用于自动部署､ 扩展和管理容器化的应用程序（通常是Docker）｡

因此, 它是ECS的替代方案, ECS的目标与ECS类似,

都是运行容器, 但API却截然不同｡

其理念是ECS绝对不是开源的｡ 

而Kubernetes是开源的,

被许多不同的云提供商使用, 这给了你某种标准化｡

因此, EKS支持两种启动模式, 同样是EC2启动模式（如果您希望部署像EC2实例这样的工作者模式）,

或者Fargate模式（如果您希望在EKS集群中部署无服务器容器）｡

因此, 使用EKS的用例是：您的公司已经在内部使用Kubernetes,

或者已经在另一个云中使用Kubernetes,

或者他们只是想使用Kubernetes

API, 并且他们想使用AWS来管理Kubernetes集群, 那么他们将使用Amazon EKS｡

因此, 从考试的角度来看, Kubernetes是云不可知论者,

它可以用于任何云, 如Azure､ Google

Cloud等｡

这意味着, 如果您尝试在云或容器之间迁移,

使用Amazon EKS可能是一个简单得多的解决方案｡

从图表上看, 这就是它的样子｡ 

因此, 我们有一个VPC, 3个AZ分为公共子网和专用子网｡

因此, 您可以创建EKS工作节点,

例如EC2实例, 其中每个节点都将运行EKS

Pod｡

它们与ECS任务非常相似, 但从命名的角度来看,

任何时候你看到pod, 它都与Amazon

Kubernetes有关, 好吗？

我们有EKS Pod, 它们在EKS节点上运行, 因此这些节点可以由自动缩放组管理｡

现在, 与ECS非常类似, 如果您希望公开EKS服务和Kubernetes服务,

我们可以设置一个专用负载平衡器, 或一个公共负载平衡器来与Web通信｡

因此, 让我们总结一下Amazon

EKS中存在的不同节点类型｡

您可以使用管理节点组,

AWS将创建和管理节点, 因此您可以使用EC2实例｡

这些节点是自动缩放组的一部分,

由EKS服务本身管理｡

您还可以支持按需和现场实例｡ 

您还可以根据需要选择自我管理节点,

也就是说, 如果您希望进行更多自定义和控制,

也可以这样做｡

因此, 在这种情况下, 您需要自己创建节点,

然后将它们注册到EKS集群, 然后将自己的节点作为ASG的一部分进行管理｡

您仍然可以为此使用预构建的Amazon EKS Optimized

AMI, 这可以节省一些时间,

或者您也可以构建自己的AMI, 这会更加复杂｡

这也支持On-Demand和Spot实例｡ 

最后, 如果你不想看到任何节点, 那么Amazon

EKS, 就像我告诉你的, 支持Fargate模式,

在这种模式下, 不需要维护,

也不需要管理任何节点, 你可以在Amazon EKS上运行容器｡

现在, 您可以将数据卷附加到Amazon EKS集群｡ 

为此, 您需要在EKS群集上指定StorageClass清单,

这将利用所谓的容器存储接口（CSI兼容驱动程序）｡

所以考试时要注意的关键词｡ 

您可以支持Amazon EBS,

也可以支持Amazon EFS, 这是唯一一种可以与Fargate配合使用的存储类｡

您拥有适用于Lustre的Amazon

FSx和适用于NetApp ONTAP的Amazon FSx｡

这就是亚马逊EKS｡ 

我希望你们喜欢它, 我们下节课再见｡
