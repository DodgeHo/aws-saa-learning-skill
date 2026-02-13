---
source: 24 - Monitoring & Logging\011 CloudWatch Insights and Operational Visibility_zh.srt
---

## 学习目标

- 理解 CloudWatch Logs Insights 与 CloudWatch Contributor Insights 的用途，用于日志级别分析与运行态可视化。 
- 掌握使用 Insights 进行查询、构建仪表盘与发现热点（高频错误、延迟原因）的基本方法。 

## 重点速览

- Logs Insights 提供交互式查询语言用于快速定位问题；Contributor Insights 用于识别对指标影响最大的维度（例如最慢的实例或最多错误的客户端）。 
- 可将 Insights 查询结果嵌入仪表盘或定期导出用于报告与报警。 

## 详细内容

- Logs Insights 用法：
  - 使用内置函数聚合、统计和可视化日志数据（如 `stats count() by bin(1m)`），便于定位事件高发时段和异常模式。 

- Contributor Insights：
  - 聚合日志或指标，识别对某项指标贡献最大的 top-N 项（例如哪个 IP 或哪个用户造成最多错误）。 

- 运维实践：
  - 将关键查询保存为仪表盘小组件或 CloudWatch Alarm 的数据源，配合自动化响应提升 MTTR。 

## 自测问题

- 写出一个 Logs Insights 查询以计算过去 30 分钟内每分钟的请求错误率。 
- Contributor Insights 与 Logs Insights 的侧重点有何不同？何时使用哪一个？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
