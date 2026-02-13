---
source: 25 - Identity & Access\008 AWS Directory Services - Hands On_zh.srt
---

## 学习目标

- 通过实操在 VPC 中部署 AWS Managed Microsoft AD 或配置 AD Connector，并在 EC2 上完成域加入验证。 

## 重点速览

- Hands-on 包含：在指定 VPC 子网中创建目录、配置安全组/网络、在 Windows EC2 上加入域并验证域用户登录。 

## 详细内容

- 实操步骤（高层）：
  - 在 AWS Directory Services 控制台选择 Managed Microsoft AD 或 AD Connector，配置目录子网与管理员账户。 
  - 在目标 VPC 中启动 Windows EC2，配置 DNS 指向目录并通过 System Properties 加入域，使用域用户登录验证。 

- 注意事项：
  - 确保网络（路由、安全组、NACL）允许域控制器所需端口（如 Kerberos、LDAP、DNS）；验证时间同步（NTP）。 

## 自测问题

- 描述在 EC2 上加入域时常见的网络或 DNS 问题及排查步骤。 
- 在使用 AD Connector 时，为什么需要保证与本地 AD 的稳定网络通道？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
