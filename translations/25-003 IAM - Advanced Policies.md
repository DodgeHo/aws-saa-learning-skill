---
source: 25 - Identity & Access\003 IAM - Advanced Policies_zh.srt
---

## 学习目标

- 掌握 IAM 策略的高级用法：策略条件（Condition）、策略模拟（Policy Simulator）、基于标签的访问控制（ABAC）与委托角色的最佳实践。 

## 重点速览

- 高级 IAM 策略常包括使用 `Condition` 限制来源 IP、MFA 或资源标签；ABAC 使用标签简化大规模策略管理。 
- 使用角色委托（assume-role）结合最小权限原则与短期凭证实现安全的跨账户/服务访问。 

## 详细内容

- 策略条件与场景：
  - 常见 condition keys 包括 `aws:SourceIp`, `aws:MultiFactorAuthPresent`, `aws:RequestTag`, `aws:PrincipalTag` 等，用于构造细粒度访问规则。 
  - ABAC（基于标签的访问控制）通过在资源与主体上使用一致标签来减少策略数量，适用于动态环境。 

- 策略测试与治理：
  - 使用 IAM Policy Simulator 模拟策略效果与交互（SCP + IAM + resource-based policy），并结合 CloudTrail 审计真实调用。 
  - 设计时注意 deny 优先规则、显式 deny 与隐式 deny 的区别，避免策略互相覆盖导致意外拒绝。 

## 自测问题

- 写出一个使用 `aws:SourceIp` 条件限制只允许来自公司内网 IP 的策略示例思路。 
- 描述 ABAC 的优点与潜在风险。 

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
