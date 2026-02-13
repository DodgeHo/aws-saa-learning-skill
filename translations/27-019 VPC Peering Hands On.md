## 学习目标

- 动手建立 VPC Peering 连接并配置路由与安全组以实现跨 VPC 通信。

## 重点速览

- Hands On 包括发起 Peering 请求、接受、更新路由表并验证实例间通信。

## 详细内容

1. 步骤：在 A VPC 发起 Peering -> 在 B VPC 接受 -> 在双方路由表中添加对端 CIDR 的路由 -> 调整 Security Group。
2. 验证：尝试从 A 的实例 ping/连接 B 的实例并排查路由或安全组阻止。

## 自测问题

1. 列出建立 Peering 后常见无法连通的三种原因及排查方法。
