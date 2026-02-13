---
source: 24 - Monitoring & Logging\006 CloudWatch Agent & CloudWatch Logs Agent_zh.srt
---

## 学习目标

- 理解 CloudWatch Agent 与 CloudWatch Logs Agent 的差异与各自适用场景。 
- 掌握基本配置要点（metrics collection、logs section、IAM 权限与系统依赖）。 

## 重点速览

- CloudWatch Agent 支持系统级指标（CPU、内存、磁盘、日志）与自定义指标；旧版 CloudWatch Logs Agent 专注日志发送。 
- 推荐使用 CloudWatch Agent（统一收集指标与日志），通过 JSON 配置集中管理。 

## 详细内容

- 功能比较：
  - CloudWatch Agent（统一）：可收集系统指标、应用日志并发送到 CloudWatch Metrics/Logs，支持多平台。 
  - CloudWatch Logs Agent（旧版）：仅推送日志，现逐步被 CloudWatch Agent 取代。 

- 配置要点：
  - 使用 `amazon-cloudwatch-agent-config-wizard` 或手动编写 JSON 配置，定义要收集的日志文件路径、metric dimension 与采样频率。 
  - 需要实例 IAM role（或 IAM user）具备 `CloudWatchAgentServerPolicy` 与 `CloudWatchLogsFullAccess` 等最低权限。 

## 自测问题

- 如果需要同时收集系统指标与应用日志，应选择哪个 Agent？为什么？
- 列出配置 CloudWatch Agent 收集自定义日志的关键字段。 

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
