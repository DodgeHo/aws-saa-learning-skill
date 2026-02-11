---
source: 26 - AWS Security & Encryption KMS, SSM Parameter Store, Shield, WAF\016 Firewall Manager_zh.srt
---

教师：现在我们来讨论AWS防火墙管理器｡

因此, 这是一项用于管理AWS组织所有帐户中所有防火墙规则的服务｡

因此, 您可以同时管理多个帐户的规则｡

因此, 您可以设置安全策略,

而安全策略是一组通用的安全规则｡

这可能是Web应用程序防火墙规则, 因此他们将其应用于ALB､

API网关､ CloudFront等｡

或者它可以是Shield Advanced规则,

因此适用于您的ALB､ CLB､ NLB､ 弹性IP和CloudFront｡

它可以是标准化EC2､ 应用程序负载平衡器和VPC中ENI资源的安全组的安全策略｡

它也可以是VPC级别的AWS网络防火墙的规则｡

所以这是我们还没有看到的东西或您的亚马逊路线53解析DNS防火墙｡

因此, 防火墙管理器允许您在一个位置管理所有防火墙｡

策略是在区域级别创建的, 明白吗？

然后将它们应用于组织的所有帐户｡

最重要的是,

如果在您的组织中以某种方式为应用程序负载平衡器创建了WAF规则,

并且以某种方式创建了一个新的应用程序负载平衡器,

则防火墙管理器会自动将相同的规则应用于此新创建的ALB｡

这是防火墙管理器的一项功能｡ 

因此, 您可能会问自己：“WAF与Firewall

Manager和Shield之间有什么区别？

“嗯,

WAF､ Shield和Firewall

Manager可配合使用, 为您的帐户提供全面的保护｡

因此, 首先在WAF中定义Web ACL规则｡ 

如果您需要一次性保护, WAF将是您的正确选择｡

但是, 如果您希望跨多个帐户使用WAF, 并加快WAF配置和自动保护新资源,

则可以在Firewall Manager中管理WAF规则｡

防火墙管理器会自动将所有这些规则应用到您的所有帐户和所有资源｡

因此, 现在我们还提供了Shield

Advanced, 帮助您抵御DDoS攻击｡

它在WAF的基础上还具有其他功能, 例如来自Shield

Response Team的专门支持､ SRT､ 高级报告, 并且它还可以自动为您创建WAF规则｡

如果您容易受到频繁的DDoS攻击,

那么您绝对应该考虑购买Shield

Advanced｡

防火墙管理器还可以帮助您在所有帐户中部署Shield

Advanced, 希望您现在已经非常清楚两者之间的区别｡

我希望你们喜欢这节课,

下节课再见｡
