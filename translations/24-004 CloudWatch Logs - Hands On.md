---
source: 24 - Monitoring & Logging\004 CloudWatch Logs - Hands On_zh.srt
---

## 学习目标

- 通过实操将应用日志发送到 CloudWatch Logs，并使用 Logs Insights 进行查询与可视化。 

## 重点速览

- Hands-on 包含：安装/配置 CloudWatch Agent、创建日志组、运行示例日志并用 Logs Insights 查询。 

## 详细内容

- 实操步骤（高层）：
  - 在 EC2/服务器上安装 CloudWatch Agent 并配置 `logs` 部分指向目标日志文件与日志组。 
  - 产生测试日志（包含 INFO/ERROR），在 CloudWatch 控制台中确认日志流和日志事件。 
  - 使用 CloudWatch Logs Insights 编写查询（如 `fields @timestamp, @message | filter @message like /ERROR/ | sort @timestamp desc | limit 20`）验证并筛选错误事件。 

- 注意事项：
  - 本地时区与日志时间戳、Agent 权限（IAM role/policy）以及日志保留策略需提前配置。 

## 自测问题

- 写出一个 Logs Insights 查询以统计过去 1 小时内每分钟的错误数。 
- 在实操中，如果看不到日志流，常见排查步骤有哪些？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
