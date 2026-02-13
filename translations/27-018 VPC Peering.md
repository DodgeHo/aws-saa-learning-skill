## 学习目标

- 理解 VPC Peering 的用途、限制与配置要点。

## 重点速览

- VPC Peering 提供两个 VPC 之间的私有 IPv4/IPv6 连通性，适用于简单互联，但不支持跨对等路由转发（no transitive routing）。

## 详细内容

1. 配置：发起 Peering 请求 -> 对端接受 -> 配置路由表以允许流量 -> 更新安全组/ NACL。
2. 限制：不可进行传递路由（如通过 A->B->C 的转发）；若需中心化互联，使用 Transit Gateway。

## 自测问题

1. 为什么 VPC Peering 不适用于大型中心化网络拓扑？
2. 配置 VPC Peering 后，需在哪些地方更新路由或安全配置？
