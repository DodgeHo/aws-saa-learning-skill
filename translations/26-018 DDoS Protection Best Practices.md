---
source: 26 - Security & Compliance\018 DDoS Protection Best Practices_zh.srt
---

## 学习目标

- 掌握构建多层 DDoS 防护策略的最佳实践：边界防护、应用层防护、自动化与混合缓解措施。 

## 重点速览

- 建议采用多层防护（网络层 Shield、应用层 WAF、流量分发 CloudFront/ALB、速率限制与监控）并结合自动化响应。 

## 详细内容

- 实施要点：
  - 使用 CloudFront 与 Shield 减少源站暴露；在应用层使用 WAF 执行速率限制与规则过滤。 
  - 建立监控与自动化（CloudWatch + EventBridge + Lambda）以在检测到异常流量时快速执行缓解策略（例如临时封禁 IP、增加缓存）。 

## 自测问题

- 描述一个多层 DDoS 防护架构的关键组件与其协作方式。 
- 在 DDoS 事件中，为什么要优先使用边缘服务（如 CloudFront）而不是直接扩缩容源站？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
