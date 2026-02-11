---
source: 26 - AWS Security & Encryption KMS, SSM Parameter Store, Shield, WAF\019 Amazon GuardDuty_zh.srt
---

旁白：现在让我们来谈谈Amazon GuardDuty｡ 

GuardDuty可帮助您进行智能威胁发现,

以保护您的AWS帐户｡

它是怎么做到的？

它具有机器学习算法, 执行异常检测并使用第三方数据来查找这些威胁｡

因此, 要启用它, 只需单击一下｡ 

你有30天的审判｡ 

您不需要安装任何软件｡ 

因此, GuardDuty将查看大量输入数据,

例如CloudTrail事件日志,

以查找不寻常的API调用或未经授权的部署｡

它将查看管理事件和数据事件｡

例如, 在管理端, 创建VPC子网事件等,

而在S3数据事件上, 例如, 获取对象, 列表对象,

删除对象等｡

然后, 对于VPC流量日志,

它将查看不寻常的互联网流量｡

它将查看不寻常的IP地址｡ 

DNS日志查看EC2实例, 在DNS查询中发送编码数据,

这意味着它们已被破坏, 并且可选功能允许您分析其他输入数据源, 例如EKS审计日志, RDS和Aurora登录事件,

EBS, Lambda和S3数据事件｡

因此, 我们还可以设置EventBridge规则,

以便在您有发现时自动通知｡

然后, 这些规则可以针对EventBridge可以针对的任何对象,

例如AWS､ Lambda或SNS主题｡

这也可能在考试中出现｡ 

GuardDuty是一个非常好的工具, 可以保护您免受加密货币攻击,

因为它有专门的搜索结果｡

因此, 它知道如何分析所有这些输入数据,

并发现存在加密货币攻击｡

总而言之, 在GuardDuty中,

我们有几个输入数据｡

我们有VPC流日志､ CloudTrail日志和DNS日志,

无论如何, 这些日志都将进入GuardDuty以及您可以启用的一些可选功能,

例如您的S3日志､ EBS卷､ Lambda网络活动､

RDS和Aurora登录活动以及您的EKS日志和运行时监控,

以及最有可能的, 随着时间的推移, 我不会在这里放出更多的功能, 因为你得到了可选功能的想法｡

因此, GuardDuty可以根据所有这些内容生成调查结果,

如果检测到这些调查结果, 则会在Amazon EventBridge中创建一个事件｡

因此, 从EventBridge,

由于规则, 我们可以触发自动化,

例如, 使用Lambda函数或发送通知,

例如, 使用SNS｡

这节课就到这里｡ 

希望你们喜欢, 下次课再见｡
