---
source: 06 - EC2 - Solutions Architect Associate Level\001 Private vs Public vs Elastic IP_zh.srt
---

# 私有 IP、公有 IP 与弹性 IP

## 学习目标
- 区分公有 IP 与私有 IP 的使用范围
- 理解 IPv4/IPv6 基础概念
- 掌握弹性 IP 的用途与限制

## 重点速览
- 公有 IP 在互联网上唯一且可访问
- 私有 IP 只在私有网络内可达
- 弹性 IP 是可固定的公有 IPv4

## 详细内容
网络通信依赖 IP 地址：
- **IPv4**：最常用格式，如 `1.2.3.4`。
- **IPv6**：更长，常用于物联网等场景，AWS 同样支持。

**公有 IP**：可在互联网访问，全球唯一。
**私有 IP**：仅在私有网络中可达，可在不同私网中重复使用。

在 AWS 中，实例在 VPC 内用私有 IP 通信；访问互联网通常通过 NAT 与 Internet Gateway。

**弹性 IP（Elastic IP）**：
- 固定的公有 IPv4 地址
- 只要不释放就一直归你所有
- 可在实例之间快速迁移（故障转移）
- 默认配额有限（通常 5 个）

最佳实践：尽量避免频繁依赖弹性 IP，优先使用 DNS（如 Route 53）或负载均衡来屏蔽变化。

## 自测问题
- 私有 IP 是否要求全球唯一？
- 弹性 IP 的核心用途是什么？
