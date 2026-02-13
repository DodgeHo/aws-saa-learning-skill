## 学习目标

- 理解 Egress-Only Internet Gateway 的用途与限制，以及与 IGW 的差别。

## 重点速览

- Egress-Only IGW 用于仅允许 IPv6 地址的出站互联网访问（阻止入站来自互联网的连接）。

## 详细内容

1. 适用场景：当 VPC 使用 IPv6 并需要私有资源发起出站连接但不允许入站访问时使用。
2. 配置要点：在路由表中添加目标 `::/0` 指向 Egress-Only IGW；仅针对 IPv6 生效。

## 自测问题

1. 为什么需要 Egress-Only IGW，而不能使用普通 IGW？
2. Egress-Only IGW 仅对哪种 IP 协议类型有效？
