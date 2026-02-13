---
source: 24 - Monitoring & Logging\012 CloudTrail Overview_zh.srt
---

## 学习目标

- 理解 AWS CloudTrail 的用途：记录账户内的 API 调用与管理事件以便审计与合规。 
- 掌握 CloudTrail 的日志交付、事件类型（管理事件 vs 数据事件）与跨区域/跨账户整合策略。 

## 重点速览

- CloudTrail 自动记录对 AWS API 的调用（控制面操作），可配置记录 S3/API 数据事件以满足更细粒度审计。 
- 支持将日志交付到 S3、发送至 CloudWatch Logs 或通过 EventBridge 实现实时响应。 

## 详细内容

- 事件类型与作用：
  - 管理事件：记录控制平面操作（如 CreateBucket、RunInstances）；数据事件：记录对特定资源的数据访问（如 S3 对象读取）。 
  - 可配置 Trail 来跨区域收集事件并集中存储到 S3，便于长期审计和取证分析。 

- 集成与自动化：
  - 将 CloudTrail 日志发送到 CloudWatch Logs 便于实时分析与基于事件的告警；通过 EventBridge 可触发自动化流程（如阻断、告警）。 

## 自测问题

- 描述 CloudTrail 管理事件与数据事件的区别与常见使用场景。 
- 如何将 CloudTrail 日志用于检测未经授权的 API 调用？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
