---
source: 25 - Identity & Access\002 Organizations - Hands On_zh.srt
---

## 学习目标

- 通过实操创建 Organization、配置 OU、应用 SCP 并观察策略对成员账户的影响。 

## 重点速览

- Hands-on 包括：创建组织、建立 OU（如 prod/dev）、创建并应用 SCP（如禁止公开 S3），以及验证策略生效。 

## 详细内容

- 实操步骤（高层）：
  - 在管理账户中启用 Organizations 并创建 OU 结构（例如 /Production, /Development）。
  - 创建示例子账户并将其置于相应 OU 中；编写并关联一个阻止 S3 公共访问的 SCP 到 OU。 
  - 使用子账户登录（或假设角色）验证在子账户中尝试执行被 SCP 阻止的操作时会被拒绝。 

- 注意事项：
  - SCP 是边界限制；仅在与 IAM 策略结合时才能生效；测试时使用最小权限和日志审计（CloudTrail）以确认限制行为。 

## 自测问题

- Hands-on 中，如何验证 SCP 对已有资源的影响？
- 为什么在 Organizations 中仍需使用 IAM 策略？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
