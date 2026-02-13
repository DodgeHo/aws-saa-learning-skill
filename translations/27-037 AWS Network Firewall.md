## 学习目标

- 了解 AWS Network Firewall 的功能、部署模式与与 VPC 集成的方法。

## 重点速览

- AWS Network Firewall 提供托管的网络层防火墙，支持规则集（状态检测、IPS 策略）并与 VPC 流量镜像或 TGW 集成用于集中防护。

## 详细内容

1. 功能：状态检测、域名/协议过滤、入侵防护（结合 Suricata 规则）等；部署可通过 VPC 流量路由或与 Transit Gateway 集成实现集中化。
2. 设计注意：性能与吞吐、规则复杂度对成本与延迟的影响；与 AWS WAF/Shield 的分层防护策略。

## 自测问题

1. 描述在 VPC 内部署 Network Firewall 的两种常见拓扑。
2. 为什么在高流量场景中要谨慎设计规则与日志输出？
