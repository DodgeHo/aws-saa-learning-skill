---
source: 24 - AWS Monitoring & Audit CloudWatch, CloudTrail & Config\014 CloudTrail - EventBridge Integration_zh.srt
---

讲师：您需要了解的一个非常重要的文化集成是使用Amazon

EventBridge拦截任何API调用｡

假设您希望在用户使用DeleteTable

API调用删除DynamoDB中的表时收到SNS通知｡

因此, 每当我们在AWS中进行API调用时, 如您所知,

API调用本身将记录在CloudTrail中｡

这适用于任何API调用｡ 

但是, 所有这些API调用最终也将在Amazon EventBridge中作为事件结束｡

因此, 我们可以查找非常具体的删除表API调用,

并创建一个规则｡

这个规则将有一个目标,

目标是Amazon SNS, 因此,

我们可以创建警报｡

- ：那么让我再举几个例子来说明如何集成Amazon

Eventbridge和CloudTrail｡

例如, 您希望在用户在您的帐户中担任某个角色时得到通知｡

因此, AssumeRole是IAM服务中的一个API,

因此将由CloudTrail记录｡

然后使用EventBridge集成,

我们可以将消息触发为SNS主题｡

类似地, 我们还可以拦截API调用,

例如, 更改安全组入站规则｡

因此, Security Group调用称为AuthorizeSecurityGroupIngress,

它是一个EC2 API调用｡

因此, CloudTrail将再次记录这些信息,

然后它们将出现在EventBridge中,

然后我们可以在SNS中触发通知｡

因此, 正如您所看到的, 可能性是无限的,

但是现在您对如何利用集成有了一些想法｡

希望你们喜欢,

我们下次课再见｡
