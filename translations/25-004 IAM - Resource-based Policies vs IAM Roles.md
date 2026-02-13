---
source: 25 - Identity & Access\004 IAM - Resource-based Policies vs IAM Roles_zh.srt
---

## 学习目标

- 分辨资源基策略（resource-based policy）与基于身份的策略（IAM policy/role）的适用场景与交互方式。 

## 重点速览

- 资源基策略附着在资源上（如 S3 Bucket Policy），可直接授权跨账户主体访问；IAM Role/Policy 则附着在身份上并通过 AssumeRole 授权。 
- 两者可组合使用以实现更灵活的跨账户与跨服务访问控制。 

## 详细内容

- 区别与配合：
  - 资源基策略：资源所有者在资源上声明允许哪些主体执行何种操作，常用于跨账户访问（S3、KMS、SNS 等支持资源基策略）。 
  - IAM 角色/策略：身份（用户/角色）拥有政策以授权其动作，跨账户访问通常通过角色委托（assume-role）并授予短期凭证。 
  - 当同时存在 resource-based policy 与 IAM policy 时，最终决策基于逻辑合并（显式 deny 优先）。

- 使用建议：
  - 对于需要允许外部账户访问的资源，优先使用资源基策略并结合最小权限原则；对于服务间临时访问使用角色与 STS。 

## 自测问题

- 举例说明在何种场景下应使用 S3 Bucket Policy（资源基策略），而非仅使用 IAM Role。 
- 当资源基策略与 IAM 策略冲突时，哪种规则优先？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
