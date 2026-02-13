---
source: 08 - High Availability and Scalability ELB & ASG\014 Elastic Load Balancer - Connection Draining_zh.srt
---

# 连接清空/注销延迟

## 学习目标
- 理解连接清空的目的
- 记住名称与配置范围

## 重点速览
- CLB 叫 Connection Draining
- ALB/NLB 叫 Deregistration Delay
- 默认 300 秒，可设置 1-3600 秒

## 详细内容
当实例被注销或不健康时：
- 现有连接继续完成
- 不再接收新连接

配置建议：
- 请求很短：可设较低值（如 30 秒）
- 请求很长：需设较高值以避免中断

设置为 `0` 表示禁用该功能。

## 自测问题
- 为什么需要连接清空？
- 低延迟与长连接场景应如何设置？
