---
source: 08 - High Availability and Scalability ELB & ASG\013 Elastic Load Balancer - SSL Certificates - Hands On_zh.srt
---

# 负载均衡器 SSL/TLS 实操

## 学习目标
- 在 ALB/NLB 上启用 HTTPS/TLS
- 了解证书来源与安全策略

## 重点速览
- ALB 使用 HTTPS 监听器（443）
- NLB 使用 TLS 监听器
- 证书推荐使用 ACM

## 详细内容
**ALB 配置**：
1. 添加监听器：协议 `HTTPS`，端口 `443`。
2. 配置转发到目标组。
3. 选择 **SSL 安全策略**（兼容性/加密套件）。
4. 选择证书来源：优先 **ACM**，也可 IAM 或导入。

**NLB 配置**：
1. 添加监听器：协议 `TLS`。
2. 选择目标组并配置安全策略。
3. 选择证书来源（ACM/IAM/导入）。

提示：导入证书需私钥、证书主体与证书链。

## 自测问题
- 为什么推荐使用 ACM 管理证书？
- ALB 与 NLB 的 HTTPS/TLS 监听器有何区别？
