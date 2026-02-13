---
source: 25 - Identity & Access\006 AWS IAM Identity Center_zh.srt
---

## 学习目标

- 了解 AWS IAM Identity Center（原 AWS SSO）的功能：集中身份源、单点登录与权限集中管理。 
- 掌握连接外部身份提供商（IdP）、配置权限集（Permission Sets）并在多个账户中委派访问的基本流程。 

## 重点速览

- Identity Center 提供统一的登录门户、集成 IdP（如 Okta、Azure AD）并通过 Permission Sets 在 Organizations 多账户环境中分发基于角色的访问。 
- Permission Sets 可包含 IAM 管理策略和基于会话的设置（如属性映射），便于集中治理与审计。 

## 详细内容

- 功能与部署：
  - 配置 Identity Center 时可选择内部目录或连接外部 SAML/OIDC IdP；在 Organizations 环境中为目标账户分配 Permission Sets。 
  - 用户通过门户选择角色并以临时凭证在目标账户中执行操作，简化跨账户访问管理。 

- 安全与治理：
  - 使用 SCIM 同步用户/组，定义最小权限的 Permission Sets 并结合 CloudTrail 审计登录与角色使用情况。 

## 自测问题

- 描述在 Organizations 环境中如何分配一个 Permission Set 给多个子账户。 
- 为什么使用 Identity Center 比单独为每个账户创建用户更安全/便捷？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
