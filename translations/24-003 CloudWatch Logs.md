---
source: 24 - Monitoring & Logging\003 CloudWatch Logs_zh.srt
---

## 学习目标

- 理解 Amazon CloudWatch Logs 的用途与基本概念：日志收集、存储、检索与分析。 
- 掌握日志组/日志流、Retention（保留期）、Metric Filter 与导出策略的使用场景。 

## 重点速览

- CloudWatch Logs 用于集中存储应用、系统与 AWS 服务产生的日志，支持检索、监控告警和长期归档到 S3。 
- 通过 Metric Filters 可以将日志模式转换为 CloudWatch 指标，用于告警与可视化。 

## 详细内容

- 组件与工作流：
  - 日志来源（CloudWatch Agent、CloudWatch Logs Agent、Lambda、VPC Flow Logs、服务端集成）将日志写入日志组（Log Group）和日志流（Log Stream）。
  - 配置保留期（Retention）控制日志在 CloudWatch 中的存储时间，或导出到 S3 做长期存档与审计。 

- 分析与告警：
  - 使用 Metric Filters 将关键日志事件转换为自定义指标，再配合 CloudWatch Alarm 实现基于日志的告警。 
  - CloudWatch Logs Insights 提供交互式查询语言用于日志聚合、筛选与可视化。 

## 自测问题

- 描述如何将 EC2 上的应用日志发送到 CloudWatch Logs 并为特定错误创建告警。 
- Metric Filter 的典型用途有哪些？如何把日志转换为指标？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
