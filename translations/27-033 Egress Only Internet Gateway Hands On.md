## 学习目标

- 实操为 IPv6 子网配置 Egress-Only Internet Gateway 并验证出站行为。

## 重点速览

- Hands On 包括创建 Egress-Only IGW、在路由表中添加 `::/0` 路由并测试私有实例的 IPv6 出站访问。

## 详细内容

1. 步骤：为 VPC 分配/启用 IPv6 -> 创建 Egress-Only IGW -> 在私有子网路由表添加 `::/0` 指向 Egress-Only IGW -> 测试出站请求。
2. 验证：确认私有 IPv6 实例能发起外网连接但无法被互联网直接访问。

## 自测问题

1. 如何验证 Egress-Only IGW 已正确配置并生效？
2. 若私有实例既有 IPv4 又有 IPv6，如何同时控制出/入流量？
