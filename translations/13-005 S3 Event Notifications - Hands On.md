---
source: 13 - Advanced Amazon S3\005 S3 Event Notifications - Hands On_zh.srt
---

# S3 事件通知 - 实操步骤（示例）

## 学习目标
- 能在控制台为 Bucket 创建事件通知并验证消息流向 SQS/SNS/Lambda
- 了解如何为目标资源配置访问策略以允许 S3 发送事件

## 重点速览
- 可以直接将事件发送到 SQS、SNS、Lambda，或启用 EventBridge 集成以转发到更多目的地
- 目标（SQS/SNS/Lambda）需要资源级访问策略以授权来自 S3 的写入或调用

## 实操流程（示例：S3 → SQS）
1. 创建或打开目标 Bucket，进入 `Properties` → `Event notifications`
2. 可选：启用 EventBridge 集成以捕获所有 Bucket 事件
3. 创建事件通知（示例名：`DemoEventNotification`），选择事件类型（如 ObjectCreated）并设置前缀/后缀过滤（可选）
4. 目标选择 SQS：在 SQS 中创建队列（示例名：`DemoS3Notification`）
5. 在 SQS 队列的访问策略中添加允许来自该 S3 Bucket 的写入权限（或使用策略生成器生成语句并保存）
6. 返回 S3 保存通知规则；上传测试对象（如 `coffee.jpg`），检查 SQS 是否收到包含 `eventName: ObjectCreated:Put` 的消息

## 自测问题
- 在将事件发送到 SQS 前，为什么需要修改 SQS 的访问策略？
- 如果不想直接把事件发送到 SQS，应如何使用 EventBridge 扩展处理？
