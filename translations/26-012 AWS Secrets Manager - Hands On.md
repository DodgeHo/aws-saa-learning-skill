---
source: 26 - Security & Compliance\012 AWS Secrets Manager - Hands On_zh.srt
---

## 学习目标

- 通过实操在 Secrets Manager 中创建秘密、为其配置自动轮换并演示通过 SDK 安全读取。 

## 重点速览

- Hands-on 包含：使用控制台/CLI 创建 secret、配置轮换（Lambda），并在应用中使用 SDK 获取凭证。 

## 详细内容

- 实操步骤（高层）：
  - 创建 Secret：在控制台输入凭证并选择 KMS CMK；记录 Secret ARN。 
  - 配置自动轮换：选择或创建轮换 Lambda，定义轮换逻辑（创建新凭证、验证并切换）。 
  - 在应用中通过 SDK（GetSecretValue）读取秘密，注意处理版本与缓存策略。 

## 自测问题

- 描述配置 Secrets Manager 自动轮换时需要实现的 Lambda 逻辑要点。 
- 为何应用应缓存 Secrets Manager 返回的秘密？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
