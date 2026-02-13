---
source: 26 - Security & Compliance\017 WAF & Shield - Hands On_zh.srt
---

## 学习目标

- 实操配置 WAF 规则并结合 Shield（或观测 Shield 报告）验证对常见攻击的拦截与记录。 

## 重点速览

- Hands-on 包括：在 CloudFront 上启用 WAF、部署托管规则并触发测试请求以验证拦截效果；查看 Shield 报表（若启用 Advanced）。 

## 详细内容

- 实操步骤（高层）：
  - 在 CloudFront 或 ALB 前端绑定 WAF Web ACL，启用托管规则并添加自定义规则（如 IP blacklisting / rate-based）。
  - 发送模拟恶意请求（测试模式或较低频率）观察 WAF 日志与 CloudWatch 指标；若启用 Shield Advanced，查看相应的检测与缓解记录。 

## 自测问题

- 描述如何在测试环境中安全地验证 WAF 规则而不影响生产流量。 
- 如果 WAF 未拦截某类攻击，应如何调整规则或分析日志？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
