---
source: 24 - Monitoring & Logging\013 CloudTrail Hands On_zh.srt
---

## 学习目标

- 实操配置 CloudTrail、将日志交付至 S3 与 CloudWatch Logs，并演练基于事件的自动响应（EventBridge + Lambda）。 

## 重点速览

- Hands-on 包括：创建 Trail、启用数据事件（S3）、配置 CloudWatch Logs 导出、并使用 EventBridge 触发 Lambda。 

## 详细内容

- 实操步骤（高层）：
  - 在 CloudTrail 控制台创建 Trail，选择将日志写入指定的 S3 存储桶，并启用跨区域复制（若需要）。 
  - 启用数据事件以记录 S3 对象级操作（GetObject、PutObject），并将 CloudTrail 事件流到 CloudWatch Logs 以便实时查询。 
  - 使用 EventBridge 规则捕获特定 API 调用并触发 Lambda 执行响应动作（如标签、通知或权限收紧脚本）。 

- 注意事项：
  - S3 存储桶权限、日志加密与生命周期（归档）设置，以及对 CloudTrail 日志访问的最小权限控制应优先配置。 

## 自测问题

- 在 Hands-on 中，如何配置一个规则以在检测到未授权的 `CreateBucket` 操作时触发通知？
- 为什么启用数据事件会显著增加日志量？应如何管理成本？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
