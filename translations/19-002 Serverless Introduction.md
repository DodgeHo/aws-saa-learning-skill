**学习目标**
- 理解“无服务器（Serverless）”的概念与典型组件
- 识别无服务器参考架构中的常见服务（Lambda、API Gateway、DynamoDB、Cognito、S3）

**重点速览**
- 无服务器并非没有服务器，而是无需管理底层服务器（按需托管）
- 无服务器架构常由 API Gateway、Lambda、DynamoDB、S3、Cognito、SNS/SQS 等服务组合而成
- 付费以使用量计费，具备自动扩展能力，适合事件驱动与按需计算场景

**详细内容**
“无服务器”强调的是托管与按需付费：开发者只需部署代码或功能，底层计算、数据库与消息服务由云提供商按需管理和扩缩。典型的无服务器参考架构示例：用户经由 CloudFront/S3 获取静态内容、通过 Cognito 完成认证、前端调用 API Gateway，API Gateway 触发 Lambda，Lambda 读写 DynamoDB；SNS、SQS、Kinesis、Aurora Serverless、Step Functions 与 Fargate 亦常出现在无服务器方案中。

无服务器的优点包括：免运维、按需计费、自动扩展与与其他托管服务的深度集成；但也需关注冷启动、运行时限制与供应商锁定等权衡。

**自测问题**
- 无服务器与传统自建服务器的主要区别是什么？
- 列出构成无服务器应用的三个核心 AWS 服务及其作用。
- 何时应考虑使用 Aurora Serverless 或 Fargate？
---
source: 19 - Serverless Overviews from a Solution Architect Perspective\002 Serverless Introduction_zh.srt
---

教师：好的, 现在我们来讨论一下什么是无服务器｡

因此, 无服务器是一种全新的技术｡ 

当您使用无服务器服务时,

您不必再管理服务器｡

所以, 这并不是说您不再拥有服务器,

而是您不再管理它们｡

您只需要部署代码,

最初, 您只需要部署它的功能｡

因此, 无服务器最初意味着功能即服务（FaaS）｡

但现在, 无服务器意味着更多｡ 

最初, 无服务器是由AWS

Lambda开创的, 我们将在本节中看到这一点,

但现在也包括了远程管理的任何内容｡

数据库､ 消息传递､ 存储,

只要您不调配服务器｡

因此, 无服务器并不意味着没有服务器,

它只是意味着您看不到它们,

或者您没有配置它们｡

因此, 如果我们深入了解无服务器的含义,

在AWS中, 我们有我们的用户,

他们将从我们的S3桶（作为网站或CloudFront +

S3提供）获得静态内容｡

然后我们会用cognito登录, 这是我们的用户将他们的身份存储的地方｡

它们将通过API网关调用REST

API, API网关将调用Lambda函数,

而Lambda函数将存储和检索DynamoDB中的数据｡

这只是一个例子｡ 

本节将专门介绍Lambda

DynamoDB､ API Gateway､

Cognito等相关知识｡

但是, 这只是为您提供一个无服务器应用程序的参考架构｡

在AWS中, 有Lambda DynamoDB､ Cognito､ API Gateway､

Amazon S3, 还有我们已经看到的东西, 如SNS和SQS,

是的, 我们没有为SQS和SNS管理任何服务器, 它可以自行扩展｡

因此, 这适合无服务器使用情形Kinesis

Data Firehose,

因为它同样基于您的吞吐量进行扩展,

您只需为所用资源付费,

而无需配置服务器, Aurora无服务器, 当Aurora数据库按需扩展时, 无需管理服务器､

步骤函数和fargate, 因为fargate是ECS的无服务器功能, 我们没有配置运行Docker容器所需的基础架构｡

希望这是对无服务器的简短介绍｡

下节课, 我们将从AWS lambda开始｡ 

这将是一个学习的内容很多,

但考试确实测试你对你的无服务器知识很重｡

那么我们开始吧｡ 

- （键敲击）
