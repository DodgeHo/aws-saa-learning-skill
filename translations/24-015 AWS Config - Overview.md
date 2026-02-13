---
source: 24 - Monitoring & Logging\015 AWS Config - Overview_zh.srt
---

## 学习目标

- 理解 AWS Config 的作用：持续评估资源配置、记录配置历史并支持合规性检查。 
- 掌握 Rules、Conformance Packs、Delivery Channel 与快照/历史查询的基本概念。 

## 重点速览

- AWS Config 记录资源配置变更并允许基于规则自动评估合规性；适合审计、合规与变更管理场景。 
- 可与 CloudWatch Events/EventBridge、Lambda 结合实现违反合规的自动化补救。 

## 详细内容

- 功能要点：
  - 通过 Recorder 记录选定范围内资源（或全账户）的配置快照与变更历史；Delivery Channel 将快照交付到 S3 与 SNS。 
  - Rules 支持托管或自定义规则来评估资源是否符合策略，Conformance Packs 聚合多条规则形成合规包。 

- 集成与实践：
  - 将违反规则的事件发送到 EventBridge 并触发 Lambda 以进行自动修复或通知；定期评估并审计配置变更。 

## 自测问题

- 描述如何使用 AWS Config 创建一条规则以确保 S3 桶不对外公开。 
- Conformance Pack 与单条 Rule 的区别是什么？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
