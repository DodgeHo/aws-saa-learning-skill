---
source: 26 - Security & Compliance\011 AWS Secrets Manager - Overview_zh.srt
---

## 学习目标

- 了解 AWS Secrets Manager 的定位：托管凭证生命周期管理、自动轮换与安全存储。 

## 重点速览

- Secrets Manager 支持存储数据库凭证、API 密钥，并能自动轮换（配合 Lambda），适用于需要密钥轮换与审计的场景。 

## 详细内容

- 核心功能：
  - 安全存储凭证并使用 KMS 加密；支持版本与秘密轮换（Rotation）策略，轮换逻辑可自定义为 Lambda 函数。 
  - 与 RDS、Redshift 等服务集成简化凭证轮换流程，并提供审计日志以便合规检查。 

## 自测问题

- Secrets Manager 与 SSM Parameter Store 的主要区别是什么？何时选择 Secrets Manager？
- 描述 Secrets Manager 自动轮换的高层流程。 

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
