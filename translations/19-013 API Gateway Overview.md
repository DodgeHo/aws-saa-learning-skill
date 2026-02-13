---
source: 19 - Serverless Overviews from a Solution Architect Perspective\013 API Gateway Overview_zh.srt
---

**学习目标**
- 理解 Amazon API Gateway 的角色与常见集成（Lambda、HTTP、AWS 服务）
- 区分端点类型（边缘优化、区域、私有）与常见安全/发布模式

**重点速览**
- API Gateway 提供托管的 API 层，支持 REST、HTTP 与 WebSocket API，并与 Lambda、Kinesis、SQS 等集成
- 端点类型：边缘优化（通过 CloudFront 提速面向全球）、区域（同一区域访问）与私有（仅 VPC 内部访问）
- 支持身份验证、使用计划、速率限制、缓存、请求/响应验证与 OpenAPI 导入导出

**详细内容**
API Gateway 是将客户端流量安全地暴露给后台服务（如 Lambda、HTTP endpoint 或其他 AWS 服务）的托管层。它带来的功能包括身份验证与授权（IAM、Cognito、Lambda authorizer）、API Keys 与使用计划以做速率限制、响应缓存以降低后端负载、以及在 API 生命周期中管理版本与阶段（dev/test/prod）。

集成场景示例：通过 API Gateway 将客户端请求发送到 Kinesis Data Streams、启动 Step Functions、或代理到内部负载均衡器；在设计时可基于访问模式选择端点类型与缓存/安全策略。

**自测问题**
- API Gateway 有哪三种端点类型？每种适用场景是什么？
- 如何在 API Gateway 中实现请求速率限制与配额？
- 当需要暴露内部服务但只允许 VPC 内访问，应选择哪个端点类型？
