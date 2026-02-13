---
source: 25 - Identity & Access\009 AWS Control Tower_zh.srt
---

## 学习目标

- 理解 AWS Control Tower 的目标：为多账户环境提供快速启动的治理基线、OU 工厂与可重复部署的账户设置。 
- 掌握 Control Tower 提供的 Guardrails、Landing Zone 模型与与 Organizations 的协同方式。 

## 重点速览

- Control Tower 提供预置的最佳实践蓝图（Landing Zone），包含账户工厂、默认 OU、预定义 Guardrails（强制或建议）。 
- 适合想快速搭建多账户治理与合规基线的组织，底层依赖 Organizations、AWS Config、CloudTrail 等服务。 

## 详细内容

- 主要功能：
  - Account Factory 自动化创建托管账户并应用标准配置；Guardrails（基于 Config 规则）用于实施合规与安全策略。 
  - Control Tower 提供 Dashboard 与事件中心用于监控合规态势与账户生命期管理。 

- 适用与限制：
  - 适合中大型组织快速建立治理基线，但对高度定制化需求可能需额外集成与扩展；迁移已有组织需谨慎规划。 

## 自测问题

- 描述 Control Tower 中 Guardrails 的作用与两类（mandatory vs strongly recommended）区别。 
- 说明使用 Control Tower 快速建立 Landing Zone 的基本步骤。 

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
