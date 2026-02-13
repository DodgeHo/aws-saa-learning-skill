---
source: 25 - Identity & Access\005 IAM - Policy Evaluation Logic_zh.srt
---

## 学习目标

- 理解 IAM 策略评估逻辑：允许（Allow）、显式拒绝（Deny）、隐式拒绝（Implicit Deny）以及策略合并规则。 
- 掌握如何分析复杂的多策略场景（SCP + IAM + Resource policy + Session policies）。 

## 重点速览

- 策略评估遵循：显式 Deny 优先；若无显式 Deny，且至少有一个显式 Allow，则允许；否则隐式 Deny。 
- 实际访问控制是所有相关策略的合并结果，包括 SCP、身份策略、资源策略和权限边界。 

## 详细内容

- 策略合并示例：
  - 当用户的 IAM 策略允许某操作，但其所在 OU 的 SCP 显式禁止该操作，最终访问被拒绝（SCP 限制边界）。
  - 权限边界（Permissions Boundary）限制角色/用户能获得的最大权限范围，即使 IAM 策略包含更广权限也会被边界约束。 

- 调试建议：
  - 使用 IAM Policy Simulator 与 CloudTrail 日志来定位拒绝的根因；检查 session policies（如 STS 临时凭证）与权限边界。 

## 自测问题

- 解释显式 Deny、隐式 Deny 与权限边界的差异。 
- 如果用户无法执行某 API，应检查哪些策略与日志？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
