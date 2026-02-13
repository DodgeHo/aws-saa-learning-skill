---
source: 19 - Serverless Overviews from a Solution Architect Perspective\016 Amazon Cognito Overview_zh.srt
---

讲师：现在我们来谈谈亚马逊Cognito｡ 

它的目标是给用户一个身份来与Web和移动应用程序交互｡

因此, 这些用户通常不在我们的AWS账户之内, 因此我们将其命名为Cognito,

因为它为用户提供了一个我们还不知道的身份｡

因此, 我们在Cognito中有两种子服务｡ 

我们有Cognito用户池,

它为应用程序用户提供了登录功能,

并与API网关和应用程序负载平衡器进行了很好的集成｡

我们有Cognito身份池,

以前称为联合身份｡

这实际上是为注册了应用程序的用户提供临时AWS凭据,

以便他们可以直接访问AWS的一些资源｡

## 学习目标

- 理解 Amazon Cognito 的定位及两大子服务：Cognito 用户池（User Pools）和身份池（Identity Pools / Federated Identities）。
- 掌握用户池如何为 Web/移动应用提供认证并与 API Gateway/ALB 集成的基本流程。
- 理解身份池如何将登录令牌交换为临时 AWS 凭证，从而允许客户端直接访问 S3、DynamoDB 等资源。
- 识别在细粒度权限（如 DynamoDB 行级安全）中使用 Cognito 的常见做法。

## 重点速览

- Cognito 面向外部应用用户（非 IAM 用户），提供认证与临时授权功能。
- 用户池（User Pool）：用户注册、登录、验证、MFA、社交登录，常与 API Gateway/ALB 配合做身份验证。
- 身份池（Identity Pool）：把来自用户池或第三方身份提供商的令牌换为临时 AWS 凭证，供客户端直接访问 AWS 资源。
- 可以在身份池中映射 IAM 角色并通过策略条件（例如 Cognito identity ID）实现细粒度权限控制。

## 详细内容

- 服务定位：
	- Cognito 为 Web 与移动应用提供用户身份管理，适用于“在 AWS 账号外”的大量终端用户场景（如数百或更多移动用户）。

- 两个子服务对比：
	- 用户池（User Pools）：一个无服务器的用户数据库，支持用户名/邮箱+密码、密码重置、邮箱/电话验证、多因素认证（MFA）、社交登录（Facebook/Google）和 SAML/OIDC 集成。典型流程：客户端向用户池登录获取 JWT，然后把该令牌发送给 API Gateway，API Gateway 验证令牌并将经验证的用户信息传给后端 Lambda/服务。
	- 身份池（Identity Pools / Federated Identities）：接受来自 User Pool 或第三方身份提供商的令牌，将其交换为受 IAM 策略约束的临时 AWS 凭证，使客户端可以直接访问 S3、DynamoDB 等服务，而无需通过 API Gateway/ALB。

- 集成示例及流程：
	- API Gateway + User Pool：客户端登录 -> 获取 JWT -> 调用 API Gateway 并携带令牌 -> API Gateway 验证 -> 后端（Lambda）收到用户身份信息。
	- ALB + User Pool：ALB 配置使用 Cognito 验证请求，验证通过后将用户标识附加到 header 传递给后端服务。
	- Identity Pool 用例：移动/网页应用登录（User Pool / 社交登录 / SAML/OIDC）-> 将令牌发给 Identity Pool -> Identity Pool 校验并颁发临时凭证 -> 客户端使用临时凭证直接访问 AWS 资源。

- 权限细化与实践：
	- 在 Identity Pool 中可以为不同用户分配不同 IAM 角色，或设置默认角色给来宾/已验证用户。
	- 通过在分配给临时凭证的 IAM 策略中使用条件（如要求 DynamoDB 主键等于 Cognito identity ID），可实现基于用户 ID 的行级安全。

- 注意事项：
	- Cognito 功能丰富但复杂，架构/考试层面只需掌握高层概念与典型集成场景（认证 vs 授权、User Pool vs Identity Pool）。
	- 选择 User Pool 或 Identity Pool 时，根据是否需要直接访问 AWS 资源来决定。

## 自测问题

- Cognito 的用户池和身份池有什么区别？分别适用于哪些场景？
- 客户端想直接访问 S3 应使用 Cognito 的哪个功能？简述完整流程。
- 如何利用 Cognito 实现对 DynamoDB 的行级访问控制？
- 当 API Gateway 使用 Cognito 验证时，后端 Lambda 如何获取用户信息？
- 在设计移动应用认证方案时，应该如何选择使用 User Pool、Identity Pool 与第三方登录？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）

