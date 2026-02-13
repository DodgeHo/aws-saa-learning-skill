---
source: 25 - Identity & Access\001 Organizations - Overview_zh.srt
---

## 学习目标

- 理解 AWS Organizations 的目的与核心概念：组织单元（OU）、账户管理、策略（SCP）与集中计费。 
- 掌握如何使用 Organizations 管理多账户安全边界与策略继承模型。 

## 重点速览

- Organizations 提供集中化的账户管理与策略控制（Service Control Policies, SCP），便于实现治理、合规与成本分摊。 
- OU 提供分组与策略边界；SCP 限制权限范围（deny-first），不会直接授予权限，只限制可执行的 API。 

## 详细内容

- 组织结构与管理：
  - 组织由根（root）与下属 OU 组成，账户可以直接挂在 OU 或根下；管理员账户（management account）负责账单与根管理。 
  - SCP 应用于 OU/账户来限制该范围内所有主体（包括 IAM identity）的可用动作，配合 IAM 策略实现细粒度访问控制。 

- 常见实践：
  - 使用 SCP 强制实施必须的安全约束（如禁止公开 S3、禁用某些区域），在 OU 级别分离环境（prod/stage/dev）。 
  - 开启深入账单与成本中心标签，结合 AWS Cost Explorer 进行成本分摊与报表。 

## 自测问题

- 描述 SCP 与 IAM 策略的不同点与交互规则（例如 deny 优先）。 
- 如果要在所有子账户禁止公开 S3，你会如何在 Organizations 中实现？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
