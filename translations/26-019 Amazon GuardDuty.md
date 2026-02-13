---
source: 26 - Security & Compliance\019 Amazon GuardDuty_zh.srt
---

## 学习目标

- 理解 Amazon GuardDuty 的目的：基于威胁情报与异常检测提供持续的威胁监控与告警。 

## 重点速览

- GuardDuty 自动分析 VPC Flow Logs、CloudTrail 管理事件与 DNS 日志以发现可疑行为（异常登录、异常流量、恶意 IP 通信）。 

## 详细内容

- 功能与集成：
  - 启用 GuardDuty 后会持续产生发现（Findings），可通过 Console、CloudWatch 或 EventBridge 触发自动化响应（例如隔离实例）。 
  - 支持跨账户集中视图（Organization），并能与 AWS Security Hub、S3、Lambda 集成用于后续处理与告警。 

## 自测问题

- GuardDuty 如何利用多种日志源来识别潜在威胁？
- 在检测到异常实例活动后，如何自动化隔离该实例？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
