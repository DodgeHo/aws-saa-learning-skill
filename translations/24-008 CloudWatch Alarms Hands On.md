---
source: 24 - Monitoring & Logging\008 CloudWatch Alarms Hands On_zh.srt
---

## 学习目标

- 实操创建基于指标与基于日志的 CloudWatch Alarm，并配置通知（SNS）与自动化动作（Lambda/Auto Scaling）。 

## 重点速览

- Hands-on 内容包含：选择指标或 Metric Filter、建立告警阈值、配置 SNS 订阅与动作触发流程。 

## 详细内容

- 实操步骤（高层）：
  - 在 CloudWatch 控制台选择指标（如 CPUUtilization）或先建立 Metric Filter 将日志模式转换为指标。 
  - 创建 Alarm，设置阈值、评估周期与操作，配置 SNS Topic 并订阅电子邮件或触发 Lambda。 
  - 验证告警触发与撤销流程，观察通知到达与自动化动作执行情况。 

- 注意事项：
  - 评估窗口与数据点数设置会影响告警灵敏度；对基于日志的告警要考虑 Metric Filter 的延迟。 

## 自测问题

- 写出创建一个“平均 CPU > 80% 持续 5 分钟”的 Alarm 所需的关键参数。 
- 在基于日志的告警中，为什么需要考虑 Metric Filter 的延迟影响？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
