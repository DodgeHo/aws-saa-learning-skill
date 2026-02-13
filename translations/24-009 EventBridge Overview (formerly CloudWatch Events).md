---
source: 24 - Monitoring & Logging\009 EventBridge Overview_zh.srt
---

## 学习目标

- 理解 Amazon EventBridge 的事件总线模型、事件模式匹配与目标路由机制。 
- 掌握如何使用 EventBridge 将事件路由到 Lambda、Step Functions、SQS、SNS、Kinesis 等目标。 

## 重点速览

- EventBridge 提供强大的事件路由与模式匹配能力，支持自定义事件总线、SaaS 事件源与规则驱动的路由。 
- 常用于事件驱动架构、应用集成与解耦服务间通信。 

## 详细内容

- 核心概念：
  - 事件源（AWS 服务、SaaS、应用自发事件）、事件总线（default/custom/partner）与规则（pattern-based 过滤）。 
  - 规则匹配到目标（Lambda、Step Functions、SQS、SNS、Kinesis、API 等），并可重试或发送到 Dead Letter。 

- 进阶特性：
  - 支持输入转换（Input Transformer）、事件归档与重放，且可与 EventBridge Schemas 自动登记事件结构。 

## 自测问题

- 描述如何用 EventBridge 把 S3 的对象创建事件路由到 Lambda。 
- EventBridge 与 SNS 的主要差异是什么？何时使用哪一个？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
