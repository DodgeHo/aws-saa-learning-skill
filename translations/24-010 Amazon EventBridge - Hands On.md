---
source: 24 - Monitoring & Logging\010 Amazon EventBridge - Hands On_zh.srt
---

## 学习目标

- 通过实操创建 EventBridge 规则，将特定事件路由到 Lambda 并验证处理流程。 

## 重点速览

- Hands-on 包括：创建自定义事件、配置规则匹配、设置目标（Lambda）、以及测试与查看事件记录。 

## 详细内容

- 实操步骤（高层）：
  - 在控制台或通过 AWS CLI 发送一个自定义事件到自定义事件总线（`aws events put-events`）。
  - 在 EventBridge 中创建规则（定义事件模式或使用简单匹配），将规则的目标设置为 Lambda 函数或 SQS。 
  - 在 Lambda 中实现简单处理逻辑并观察 CloudWatch Logs 确认事件到达与处理。 

- 注意事项：
  - 规则的模式需要精确匹配字段，调试时可先使用广泛匹配再逐步收紧；配置 Dead Letter 或重试以提高可靠性。 

## 自测问题

- 写出一个 `aws events put-events` 示例将自定义 event 数据发送到自定义事件总线。 
- 在调试规则匹配失败时，应检查哪些常见问题？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
