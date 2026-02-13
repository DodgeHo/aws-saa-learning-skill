---
source: 20 - Serverless Solution Architecture Discussions\002 Serverless Website MyBlog.com_zh.srt
---


## 学习目标

- 理解如何用无服务器方式托管全球静态网站（S3 + CloudFront + OAC）。
- 掌握将无服务器静态服务与动态 API（API Gateway + Lambda + DynamoDB）混合的常见模式与触发器（S3 事件、DynamoDB Stream）。
- 学会用 S3 + Lambda 生成缩略图和用 SES 发送用户欢迎邮件的典型事件驱动流程。

## 重点速览

- 静态内容托管：将网站静态文件存放在 S3，使用 CloudFront 在全球分发并缓存内容。
- 安全与访问：使用 Origin Access Control（OAC）或存储桶策略限制直接访问，仅允许 CloudFront 读取 S3。
- 事件驱动扩展：上传触发 Lambda（生成缩略图）、DynamoDB Stream 触发 Lambda（发送欢迎邮件 via SES）、S3 可触发 SQS/SNS/Lambda。

## 详细内容

- 内容分发：
	- 静态站点（大量读取、少量写入）适合 S3 + CloudFront，边缘缓存显著降低延迟与成本。 
	- 使用 OAC/存储桶策略确保 S3 对外不可直接访问，仅 CloudFront 可读取。 

- 动态功能：
	- 需要少量动态 API 的路径使用 API Gateway -> Lambda -> DynamoDB（或 DAX 缓存）实现。 
	- 对全球访问优化可考虑 DynamoDB 全局表以减少跨区延迟。 

- 事件流与自动化：
	- 用户订阅写入 DynamoDB，可启用 DynamoDB Stream 调用 Lambda，由 Lambda 使用 SES 发送欢迎邮件（Lambda 需 IAM 权限）。
	- 用户上传图片到 S3 可触发 Lambda 生成缩略图，缩略图可保存到另一个桶或同一桶的不同前缀；S3 同时可触发 SQS/SNS 用于更复杂流程。 

- 成本与架构权衡：
	- 静态资源借助 CloudFront 边缘缓存可大幅减少源服务器和带宽成本。 
	- 动态功能保持无服务器实现以便按需扩展并降低运维成本。 

## 自测问题

- 描述如何用 S3 + CloudFront + OAC 安全地托管一个全球静态网站。 
- 当用户上传图片后，需要生成缩略图并通知系统其它组件，应该如何设计事件流？写出关键触发器和服务。 
- 说明如何利用 DynamoDB Stream 和 Lambda 实现用户欢迎邮件流（包括所需 IAM 权限）。

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
