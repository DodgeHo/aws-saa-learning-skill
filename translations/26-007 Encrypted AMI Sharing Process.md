---
source: 26 - AWS Security & Encryption KMS, SSM Parameter Store, Shield, WAF\007 Encrypted AMI Sharing Process_zh.srt
---

教师：这是一个考试中可能出现的问题｡

这是与另一个帐户共享AMI的过程,

AMI已使用KMS密钥加密｡

因此, AMI位于您的源帐户中,

并使用您的KMS密钥进行加密｡

那么, 如何从帐户A中的AMI启动帐户B中的EC2实例呢？

因此, 首先必须使用启动权限修改AMI属性,

列表启动权限允许帐户B启动此AMI｡

因此, 实际上, 这就是您共享AMI的方式｡ 

您必须修改启动权限,

并将指定的目标添加到其帐户ID｡

然后, 您还需要为帐户B共享KMS密钥,

以便能够使用它｡

因此, 这通常是通过关键策略来完成的｡ 

然后, 在帐户B中, 您将创建一个IAM角色或IAM用户,

该角色或用户具有足够的权限来实际使用KMS密钥和AMI｡

因此, 您必须在KMS端拥有它, 访问Describekey

API调用､ ReEncrypted API调用､ CreateGrant和Decrypt

API调用｡

完成所有这些操作后, 您只需从该AMI启动一个EC2实例,

目标帐户也可以选择使用其拥有的KMS密钥（即在自己的帐户中拥有的密钥）重新加密所有内容, 从而重新加密卷｡

但现在, 您可以启动一个EC2实例｡ 

所以如果你理解了这个过程,

你就可以在考试中回答一个问题了｡

我希望你们喜欢, 下节课再见｡
