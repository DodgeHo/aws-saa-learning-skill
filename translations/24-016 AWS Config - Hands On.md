---
source: 24 - Monitoring & Logging\016 AWS Config - Hands On_zh.srt
---

## 学习目标

- 实操配置 AWS Config Recorder、创建 Rule 并对违规触发自动化（EventBridge + Lambda）。 

## 重点速览

- Hands-on 包括：启动配置记录器、创建托管 Rule（如 S3 公共访问检测）、以及将违规事件路由到 Lambda 补救或通知。 

## 详细内容

- 实操步骤（高层）：
  - 在 AWS Config 控制台启用 Recorder，选择需要记录的资源类型并配置 Delivery Channel（S3 + SNS）。
  - 选择或创建 Rule（AWS 管理的规则或自定义 Lambda-backed Rule），运行评估并查看合规性报告。 
  - 配置 EventBridge 规则将非合规事件发送到 Lambda 自动执行修复或发送告警。 

- 注意事项：
  - 确保 Recorder IAM role 有权限读取资源元数据与写入 S3；为自动修复设置严格权限与审计。 

## 自测问题

- 在 Hands-on 中，如何验证一条 Rule 的触发与自动修复执行成功？
- Recorders 的交付渠道（Delivery Channel）包含哪些目标？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
