## 学习目标

- 掌握 VPC 的基本组件及其在 AWS 网络拓扑中的角色。

## 重点速览

- VPC (Virtual Private Cloud) 是 AWS 上的虚拟网络边界，包含 CIDR、子网、路由表、Internet Gateway、NAT、Security Groups、NACL 等。
- 设计应关注可用区划分、子网大小、与本地网络互通策略与安全边界。

## 详细内容

1. VPC 是逻辑隔离的网络空间：每个 VPC 需要一个 CIDR 块。
2. 子网按 AZ 划分以提高可用性；路由表决定子网流量去向（IGW、VGW、TGW、Peering 等）。
3. 安全组与 NACL 提供实例与子网层级的访问控制，二者互补但行为不同（有状态 vs 无状态）。

## 自测问题

1. 描述 Security Group 与 NACL 的差异及各自适用场景。
2. 说明何时需要使用多个 VPC 而非单个大 VPC。
