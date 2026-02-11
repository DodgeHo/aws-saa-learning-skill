---
source: 16 - AWS Storage Extras\003 Architecture Snowball into Glacier_zh.srt
---

教师：所以这是一个很短的讲座,

围绕着考试中可能出现的一个场景｡

您希望让Snowball将数据直接导入Glacier,

但Snowball不能将数据直接导入Glacier｡

您的解决方案是首先使用AmazonS3,

然后创建一个生命周期策略, 将这些对象转换到AmazonGlacier｡

所以一旦你知道了, 事情就很简单了｡ 

Snowball将数据导入到Amazon

S3中, 由于S3的生命周期策略, 数据被转换到Amazon

Glacier中｡

这是考试时要记住的｡ 

我希望你们喜欢, 下节课再见｡
