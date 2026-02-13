---
source: 26 - Security & Compliance\008 SSM Parameter Store Overview_zh.srt
---

## 学习目标

- 理解 AWS Systems Manager Parameter Store 的用途：安全存储配置参数与明文/加密的秘密值。 

## 重点速览

- Parameter Store 支持明文参数和使用 KMS 加密的 SecureString 参数，适合存储配置项、连接字符串与轻量级密钥。 

## 详细内容

- 使用与集成：
  - 可通过 SDK/CLI/SSM Agent 读取参数，支持版本控制、标签与参数策略（访问控制）。
  - 对于敏感信息可使用 SecureString（KMS CMK）；对于复杂的密钥管理需求建议使用 Secrets Manager。 

## 自测问题

- 描述何时使用 Parameter Store 的 SecureString 而非 Secrets Manager。 
- 如何在 Lambda 中安全地读取 Parameter Store 中的加密参数？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
