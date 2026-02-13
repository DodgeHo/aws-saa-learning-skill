---
source: 19 - Serverless Overviews from a Solution Architect Perspective\009 RDS - Invoking Lambda & Event Notifications_zh.srt
---

**学习目标**
- 理解 RDS 与 Lambda 的两种交互模式：数据库触发 Lambda（数据事件）与 RDS 事件通知（实例级事件）

**重点速览**
- RDS（部分引擎如 Aurora / PostgreSQL）可在数据库层触发 Lambda，用于响应数据层事件（插入/更新）
- RDS 事件通知（实例状态、快照等）通过 SNS / EventBridge 发送，不包含数据库内具体数据变更
- 网络与权限配置（VPC、IAM）对数据库触发 Lambda 的可用性至关重要

**详细内容**
两种模式说明：
1) 数据驱动触发：某些 RDS 引擎支持在数据库内配置触发器或扩展，将事件直接调用 Lambda（如在插入时触发业务处理）。这要求网络与权限配置允许从数据库到 Lambda 的调用路径（VPC、NAT、VPC 端点或适当的网络连通性），并确保调用方具备执行 Lambda 的 IAM 权限。
2) RDS 事件通知：用于通知实例级别的变化（如快照、故障、故障转移、参数组更改），这些事件可发送到 SNS 或 EventBridge，再由其转发到 SQS、Lambda 等目标，但不包含表内的数据变更。

使用建议：当需要对数据变更做实时处理（例如发送欢迎邮件、复制到其他系统）时，可使用数据库触发 Lambda；当仅需监控实例状态时，使用 RDS 事件通知更合适。

**自测问题**
- RDS 数据触发 Lambda 与 RDS 事件通知的本质区别是什么？
- 为使 RDS 调用 Lambda 能工作，需要配置哪些网络与权限项？
- 若只需监听实例备份或故障，应使用哪种机制？
