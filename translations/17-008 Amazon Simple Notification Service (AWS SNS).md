```markdown
**学习目标**

- 理解 Amazon SNS 的发布/订阅（Pub/Sub）模型与典型用途。
- 掌握 SNS 与 SQS、Lambda、HTTP(S)、电子邮件、SMS 等目标的集成场景与安全要点。

**重点速览**

- SNS 用于广播通知：生产者发布到主题，主题将消息分发给多个订阅者（批量广播）。
- 支持多种订阅端点：SQS、Lambda、HTTP(S)、电子邮件、SMS、移动 push；支持消息过滤与 FIFO（有序 & 去重）的主题。

**详细内容**

- 工作流程：创建主题（Topic）→ 创建订阅（Subscription）→ 生产者调用 Publish 发送消息。订阅者可接收主题中所有匹配的消息，或通过订阅过滤策略接收子集。
- 特性与整合：
  - 扇出（Fan-out）：SNS 将单条消息投递到多个 SQS 队列或其他端点，适合多消费者并行处理相同事件。
  - 集成：常与 CloudWatch、Auto Scaling、S3 事件等 AWS 服务联动；可将消息送入 Kinesis Data Firehose 以持久化到 S3/Redshift/OpenSearch。
  - FIFO 支持：SNS FIFO 主题可保证顺序与一次性投递，但订阅者须为 SQS FIFO 队列，吞吐受限。
  - 安全：支持 TLS/HTTPS、传输加密及 KMS 静态加密；访问控制通过 IAM 与主题资源策略管理，支持跨账户发布/订阅。

**自测问题**

1. 描述 SNS 扇出模式的基本流程，并举一例适用场景。
2. SNS FIFO 与普通 SNS 的主要区别是什么？何时选择 FIFO？

```
