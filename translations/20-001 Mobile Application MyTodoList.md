---
source: 20 - Serverless Solution Architecture Discussions\001 Mobile Application MyTodoList_zh.srt
---

## 学习目标

- 理解用于移动应用的经典无服务器架构模式（API Gateway + Lambda + DynamoDB）。
- 掌握如何使用 Amazon Cognito + STS 为客户端颁发临时凭证以访问 S3。
- 学会用 DAX 与 API Gateway 缓存来提高读取吞吐量并降低成本。

## 重点速览

- 应用架构：客户端 -> API Gateway -> Lambda -> DynamoDB（后端），并可选使用 S3 存储用户文件。
- 认证与授权：使用 Cognito 登录，交换临时凭证（STS）让客户端安全访问 S3 或其他 AWS 资源。
- 性能优化：对读密集型场景使用 DynamoDB DAX 缓存或在 API Gateway 层启用响应缓存以降低读取成本。

## 详细内容

- 需求概述：MyTodoList 为移动应用，需公开 HTTPS REST API、采用无服务器设计、允许用户访问各自在 S3 的文件夹，并提供可扩展、高读吞吐量的数据库层。

- 核心组件：
	- API Gateway：暴露 HTTPS endpoint，接收客户端请求并进行身份验证（与 Cognito 集成）。
	- Lambda：无服务器后端处理业务逻辑，读写 DynamoDB。 
	- DynamoDB：无服务器 NoSQL 存储，适合高并发、低延迟读写场景。 
	- Cognito + STS：客户端经 Cognito 登录后由 Cognito/STS 发放临时凭证，允许客户端直接访问 S3（避免在设备上存储长期 AWS 凭据）。

- 缓存策略：
	- DynamoDB DAX：在读多写少场景将读取缓存到 DAX，显著减少 DynamoDB 的读取容量消耗。 
	- API Gateway 缓存：对可缓存的 API 路由启用缓存，减少 Lambda 调用和成本。 

- 典型扩展与成本考虑：
	- 随用户增长可水平扩展 Lambda 与 DynamoDB（按需或预配+自动扩展模式）。
	- 使用缓存（DAX / API Gateway）可在提升性能的同时降低总体成本，尤其是读取吞吐高且数据较稳定时。

## 自测问题

- 描述一个移动应用如何安全地让客户端直接访问 S3 上的用户文件（列出关键组件与流程）。
- 在读密集但写少的 Todo 应用中，如何降低 DynamoDB 的读取成本？列出两种策略。 
- 为什么不要在移动客户端中保存长期 AWS 用户凭据？应该怎么做替代？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
