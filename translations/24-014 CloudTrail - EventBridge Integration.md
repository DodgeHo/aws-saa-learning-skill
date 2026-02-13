---
source: 24 - Monitoring & Logging\014 CloudTrail - EventBridge Integration_zh.srt
---

## 学习目标

- 理解如何将 CloudTrail 事件通过 EventBridge 实现实时检测与自动化响应的模式。 

## 重点速览

- 将 CloudTrail 事件路由到 EventBridge，可基于事件模式触发 Lambda、Step Functions 或自动化工作流，实现快速响应与补救。 

## 详细内容

- 集成流程：
  - 配置 CloudTrail 将管理事件发送到 CloudWatch Logs 或直接利用 EventBridge 的事件流（默认事件总线）。 
  - 在 EventBridge 中定义规则匹配特定 API 调用或事件源（例如未授权访问），并将目标设置为 Lambda 或 SQS 以执行自动化响应。 

- 实践建议：
  - 对高频事件设置率限制或聚合策略，避免触发泛滥的自动化；使用 Dead Letter 与重试策略保证可靠性。 

## 自测问题

- 描述一个使用 CloudTrail + EventBridge 自动中断未经授权 API 调用的高层流程。 
- 为什么需要为 EventBridge 规则添加输入转换（Input Transformer）？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
