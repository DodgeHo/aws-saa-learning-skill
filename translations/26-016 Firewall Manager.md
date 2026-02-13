---
source: 26 - Security & Compliance\016 Firewall Manager_zh.srt
---

## 学习目标

- 理解 AWS Firewall Manager 的作用：在多个账户与资源上集中管理 WAF、Shield、安全策略与规则集。 

## 重点速览

- Firewall Manager 用于在 Organizations 范围内统一配置与强制执行安全策略（WAF 规则集、Shield Advanced 策略、VPC 安全组策略等）。 

## 详细内容

- 工作方式：
  - 在管理账户中配置 Firewall Manager 策略并选择目标 OU，策略会自动应用到符合条件的资源上并保持一致性。 
  - 适合需要跨账户统一治理和快速响应安全事件的组织，减少手动配置与遗漏风险。 

## 自测问题

- 描述使用 Firewall Manager 在所有账户上统一启用 WAF 托管规则的流程。 
- Firewall Manager 如何与 Organizations/Config 协作实现集中治理？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
