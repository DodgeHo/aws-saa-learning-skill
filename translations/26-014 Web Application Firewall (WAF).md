---
source: 26 - Security & Compliance\014 Web Application Firewall (WAF)_zh.srt
---

## 学习目标

- 了解 AWS WAF 的核心功能：基于规则的应用层（L7）防护、规则组与与 CloudFront/ALB/API Gateway 的集成。 

## 重点速览

- WAF 提供可配置的规则（IP 阻断、请求大小、SQL 注入/XSS 策略与托管规则）以保护 Web 应用免受常见攻击。 

## 详细内容

- 使用建议：
  - 在 CloudFront 或 ALB 前端启用 WAF，使用托管规则集（Managed Rules）作为起点并基于访问模式逐步调优自定义规则。 
  - 配置速率限制（rate-based rules）防止暴力枚举或爬虫，使用日志（Kinesis Data Firehose / S3）进行事件分析与告警。 

## 自测问题

- 描述如何使用 WAF 阻断来自特定 IP 的请求并记录相关日志。 
- WAF 中的托管规则与自定义规则有何区别？什么时候分别使用？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
