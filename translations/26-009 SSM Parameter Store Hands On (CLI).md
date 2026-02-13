---
source: 26 - Security & Compliance\009 SSM Parameter Store Hands On (CLI)_zh.srt
---

## 学习目标

- 通过 CLI 实操创建、加密与读取 Parameter Store 参数，并设置访问权限演示。 

## 重点速览

- Hands-on 包括：使用 `aws ssm put-parameter` 创建 PlainText 与 SecureString 参数，使用 `get-parameter` 读取并查看版本。 

## 详细内容

- 实操步骤（CLI）：
  - 创建参数（明文）：`aws ssm put-parameter --name /my/app/config --value "value" --type String`。 
  - 创建加密参数：`aws ssm put-parameter --name /my/app/secret --value "secret" --type SecureString --key-id alias/my-kms-key`。 
  - 读取参数：`aws ssm get-parameter --name /my/app/secret --with-decryption`（需具备 KMS 解密权限）。 
  - 设置 IAM 策略，限制哪些角色/用户可读取或写入特定参数路径。 

## 自测问题

- 写出创建 SecureString 参数并读取的 CLI 命令示例。 
- 如果读取 SecureString 报错权限不足，应检查哪些 IAM/KMS 权限？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
