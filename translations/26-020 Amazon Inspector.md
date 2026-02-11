---
source: 26 - AWS Security & Encryption KMS, SSM Parameter Store, Shield, WAF\020 Amazon Inspector_zh.srt
---

教师：现在我们来谈谈亚马逊检查员｡ 

因此, Amazon Inspector是一项服务,

它允许您对一些事情运行自动化安全评估｡

首先, 在E2实例上｡ 

您将在EC2实例上利用Systems Manager代理,

Amazon Inspector将开始评估该E2实例的安全性｡

它将针对意外的网络访问进行分析,

并分析运行中的操作系统是否存在已知漏洞｡

这是连续进行的｡ 

然后, 我们也有亚马逊检查器为您的容器图像推到亚马逊ECR｡

例如, 您的Docker图像｡ 

因此, 当您的容器映像被推送到Amazon

ECR时, Amazon Inspector将针对已知漏洞对它们进行分析｡

我们还有Amazon Inspector用于Lambda函数｡ 

因此, Lambda函数在部署时,

将由Inspector再次分析函数代码和包依赖项中的软件漏洞｡

此评估在部署功能时进行｡

因此, 一旦Amazon Inspector完成其工作,

它就可以将其发现报告到AWS

Security Hub, 并将这些发现和事件发送到Amazon EventBridge｡

这为您提供了一种集中查看基础架构上运行的漏洞的方法,

并且通过EventBridge, 您可以运行某种自动化｡

那么亚马逊检查员会评估什么呢？

您必须记住, Inspector仅适用于您正在运行的EC2实例､

Amazon ECR上的容器映像和Lambda函数｡

而且它只会在需要时对基础架构进行持续扫描｡

它将查看漏洞数据库CVE,

以查找EC2､ ECR和Lambda的软件包漏洞｡

它将检查Amazon

EC2上的网络可达性, 如果CVE的数据库更新,

则Amazon Inspector将自动再次运行, 以确保再次测试所有基础架构｡

每次运行时, 都会将一个风险分值与所有漏洞相关联,

以确定优先级｡

这就是亚马逊检查员｡ 

我希望你们喜欢, 我们下节课再见｡
