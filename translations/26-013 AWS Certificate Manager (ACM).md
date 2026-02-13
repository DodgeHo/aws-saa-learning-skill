---
source: 26 - Security & Compliance\013 AWS Certificate Manager (ACM)_zh.srt
---

## 学习目标

- 理解 ACM 的用途：托管 TLS/SSL 证书的请求、颁发与自动续期，并与负载均衡、CloudFront 集成。 

## 重点速览

- ACM 简化公有证书的申请与管理（免费在支持区域内），支持导入私有证书并与 ELB、CloudFront、API Gateway 等集成。 

## 详细内容

- 使用要点：
  - 在公有环境使用 ACM 申请免费证书并通过 DNS 或 Email 验证；证书自动续期并可绑定到 ELB/CloudFront。 
  - 对于私有证书或内部 PKI，可使用 ACM Private CA（额外付费）管理内部证书生命周期。 

## 自测问题

- 说明如何在 CloudFront 上使用 ACM 证书（跨区域注意点）。 
- 如果需要在自托管服务器上使用证书，应如何从 ACM 导出或导入？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
