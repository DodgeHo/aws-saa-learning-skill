---
source: 26 - Security & Compliance\010 SSM Parameter Store Hands On (AWS Lambda)_zh.srt
---

## 学习目标

- 演示如何在 Lambda 中安全访问 Parameter Store 的加密参数与最佳实践（权限最小化、缓存）。 

## 重点速览

- Hands-on 涵盖：在 Lambda 执行角色中授予 `ssm:GetParameter` 与对应 KMS `Decrypt` 权限，并通过 SDK 读取带解密参数。 

## 详细内容

- 实操要点：
  - 在 Lambda 的执行角色中附加策略，允许读取特定参数路径并为 KMS CMK 授予 `kms:Decrypt` 权限。 
  - 在函数中使用 AWS SDK（例如 `ssm.getParameter({ Name, WithDecryption: true })`）并实现本地缓存以减少调用与延迟。 
  - 注意冷启动与权限最小化：避免将太宽泛的 KMS 权限附加到角色。 

## 自测问题

- 在 Lambda 中读取 SecureString 时，需要为执行角色额外配置哪些权限？
- 为什么建议在应用层缓存参数，而不是每次调用都请求 Parameter Store？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
