---
source: 08 - High Availability and Scalability ELB & ASG\015 Auto Scaling Groups (ASG) Overview_zh.srt
---

# Auto Scaling 组（ASG）概览

## 学习目标
- 理解 ASG 的作用与核心参数
- 了解 ASG 与负载均衡的配合
- 知道 ASG 与 CloudWatch 告警的关系

## 重点速览
- ASG 用于水平扩展（加/减实例）
- 需设置最小、期望、最大容量
- 不健康实例会被自动替换

## 详细内容
ASG 用于根据负载自动调整 EC2 实例数量：
- **横向扩展**：负载高时增加实例
- **缩容**：负载低时减少实例

核心参数：
- **Min**：最小实例数
- **Desired**：期望实例数
- **Max**：最大实例数

与 ELB 配合：
- 新实例自动注册到负载均衡器
- ELB 健康检查可触发 ASG 替换不健康实例

启动模板包含：AMI、实例类型、用户数据、EBS、安全组、IAM 角色、子网等。

与 CloudWatch 告警：
- 基于指标（如 CPU）触发扩展/缩容策略

## 自测问题
- ASG 的三种容量参数分别代表什么？
- 为什么 ASG 和 ELB 是常见组合？
