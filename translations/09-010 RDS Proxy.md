---
source: 09 - AWS Fundamentals RDS + Aurora + ElastiCache\010 RDS Proxy_zh.srt
---

# Amazon RDS Proxy

## 学习目标
- 理解 RDS Proxy 的作用
- 记住性能与故障转移优势
- 了解适用引擎与安全特性

## 重点速览
- 连接池化，减少数据库压力
- 故障转移时间可减少约 66%
- 仅在 VPC 内访问

## 详细内容
RDS Proxy 是托管数据库代理：
- 应用连接代理，由代理复用到更少的 DB 连接
- 减少 CPU/RAM 压力和连接超时

优势：
- 无服务器、自动扩展
- 跨 AZ 高可用
- 故障转移更快（最多减少约 66%）

支持引擎：
- MySQL、PostgreSQL、MariaDB、SQL Server
- Aurora MySQL / Aurora PostgreSQL

安全与认证：
- 支持 IAM 认证
- 密钥可存储在 Secrets Manager
- 代理不公开暴露，仅限 VPC 内访问

典型场景：
- Lambda 大量短连接，使用代理池化

## 自测问题
- RDS Proxy 如何提升数据库稳定性？
- 为什么 Lambda 场景特别适合 RDS Proxy？
