## 学习目标

- 实操创建 NAT Gateway，并在私有子网中验证出站互联网访问。

## 重点速览

- Hands On 包括：在公有子网创建 NAT Gateway、分配 EIP、更新私有子网路由表并验证连通性。

## 详细内容

1. 步骤：创建 NAT Gateway -> 将私有子网路由表的 `0.0.0.0/0` 指向 NAT Gateway -> 测试私有实例出站访问。
2. 验证与监控：检查 VPC Flow Logs、CloudWatch 指标以观察流量与性能。

## 自测问题

1. 在 Hands On 中如何验证 NAT Gateway 正在处理出站流量？
2. 如果私有实例无法访问互联网，排查的第一步是什么？
