---
source: 25 - Identity & Access\007 AWS Directory Services_zh.srt
---

## 学习目标

- 了解 AWS Directory Services（包括 AWS Managed Microsoft AD、Simple AD、AD Connector）的差异与典型使用场景。 
- 掌握如何选择目录服务以支持 Windows 域加入、LDAP 验证或与现有本地 Active Directory 集成。 

## 重点速览

- AWS Managed Microsoft AD 提供托管的 Microsoft Active Directory，适用于需要域控制器功能的应用；AD Connector 用于代理到现有本地 AD。 
- Simple AD 为轻量级的 LDAP 目录，适合基础的认证场景但功能受限。 

## 详细内容

- 选择与集成：
  - 若需完整域服务（Group Policy、Kerberos、域用户），选择 AWS Managed Microsoft AD；若只是转发认证请求到本地 AD，选择 AD Connector。 
  - 注意网络连通（VPN/Direct Connect）、时钟同步与信任关系配置，确保域集成稳定。 

- 运维与安全：
  - 管理员应关注目录备份、恢复策略、基于角色的访问与最小权限原则；配置日志与监控（CloudWatch/CloudTrail）。 

## 自测问题

- 在需要将 EC2 加入域并使用域用户登录的场景，应该选择哪种目录服务？为什么？
- AD Connector 与 AWS Managed Microsoft AD 的关键区别是什么？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
