---
source: 11 - Classic Solutions Architecture Discussions\006 Beanstalk Overview_zh.srt
---

教练：好的, 现在我们来谈谈弹性豆茎｡

## 学习目标
- 理解 Elastic Beanstalk 的定位与价值
- 掌握 Beanstalk 的核心概念
- 区分 Web 层与 Worker 层模式

## 重点速览
- Beanstalk 是托管式部署平台
- 复用 EC2/ASG/ELB/RDS 等组件
- 支持多语言与多环境

## 详细内容
为什么需要 Beanstalk：
- 大多数 Web 应用架构相似，重复搭建成本高
- 开发者希望专注于代码而不是基础设施

Beanstalk 做什么：
- 自动创建并管理 EC2、ASG、ELB、RDS
- 处理容量、扩展、健康检查、实例配置
- 服务本身免费，仅付底层资源费

核心概念：
- Application：应用的集合
- Version：应用代码的一个版本
- Environment：运行某个版本的一组资源

层类型：
- Web 环境：ELB + ASG + EC2
- Worker 环境：SQS + EC2 Worker
- 可组合，Web 环境可推消息到 Worker

部署模式：
- 单实例：适合开发，使用弹性 IP
- 负载均衡：适合生产，支持多 AZ 和扩展

## 自测问题
- Beanstalk 与手工搭建 ELB/ASG 的差异是什么？
- Worker 环境如何实现扩展？
