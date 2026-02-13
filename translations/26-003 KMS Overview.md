---
source: 26 - Security & Compliance\003 KMS Overview_zh.srt
---

## 学习目标

- 了解 AWS KMS（Key Management Service）的作用、密钥类型（CMK）与访问控制模型。 
- 掌握 KMS 用于数据加密、跨账户/跨区域密钥使用与审计的基本操作。 

## 重点速览

- KMS 提供集中化的密钥管理、加密操作与审计（CloudTrail）；支持对称与非对称 CMK、别名与密钥策略。 

## 详细内容

- 关键特性：
  - CMK（客户主密钥）用于加密数据密钥（DEK）或直接加密数据；KMS 提供加密/解密和签名验证 API。 
  - 密钥策略与 IAM 共同决定哪个主体能使用或管理密钥；启用密钥轮换与 CloudTrail 审计密钥使用。 
  - 集成：KMS 与 S3、EBS、RDS、Secrets Manager、ACM 等服务深度集成以简化加密。 

## 自测问题

- 描述 KMS CMK 与数据密钥（DEK）的关系与典型使用流程。 
- 如何限制跨账户使用 KMS 密钥？列出至少一种方法。 

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
