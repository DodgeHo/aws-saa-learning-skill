## 学习目标

- 了解 Transit Gateway 的用途、优势及在大型多 VPC 网络架构中的最佳实践。

## 重点速览

- Transit Gateway（TGW）提供中心化路由与互联，支持跨 VPC、VPN、Direct Connect 的可扩展连接，解决 VPC Peering 的非传递性限制。

## 详细内容

1. 优点：简化路由表管理、支持转发、便于集中流量控制与监控；适合大型多 VPC 或多账户环境。
2. 设计注意：成本模型、路由传播与关联表的配置、通过 TGW 的流量策略与安全控制。

## 自测问题

1. 解释 Transit Gateway 如何解决 VPC Peering 的可扩展性问题。
2. 在设计 TGW 时需考虑哪些成本与治理要点？
