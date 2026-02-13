---
source: 13 - Advanced Amazon S3\004 S3 Event Notifications_zh.srt
---

# S3 事件通知（Event Notifications）概览

## 学习目标
- 理解 S3 事件的类型与常见处理目标
- 掌握配置 S3 事件时的权限与集成注意点

## 重点速览
- S3 事件包括对象创建、删除、恢复、复制等，可配置过滤器（前缀/后缀）
- 常见目标：SNS、SQS、Lambda；也可将事件发送到 Amazon EventBridge 做更复杂的路由与重放
- 目标资源通常需要资源策略（SNS/SQS/Lambda）以授权 S3 发送事件，而非给 S3 一个 IAM 角色

## 详细内容
- 用例示例：上传图片自动触发生成缩略图（S3 → SQS → Worker / Lambda）
- 交付特性：通常几秒内到达目标，但在高负载下可能延迟到数十秒或更久
- 权限模型：在 SNS/SQS/Lambda 上设置资源访问策略，允许 S3 发送事件；EventBridge 可捕获所有 S3 事件并转发到更多目的地
- EventBridge 优势：高级过滤（基于元数据、对象大小、名称等）、事件存档与重放、更可靠的投递选项

## 自测问题
- S3 事件可以发送到哪些服务？为什么这些目标需要资源策略？
- 使用 EventBridge 相比直接发送到 SQS/SNS 的主要优势是什么？
