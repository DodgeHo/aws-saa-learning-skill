---
source: 06 - EC2 - Solutions Architect Associate Level\005 Elastic Network Interfaces (ENI) - Overview_zh.srt
---

# 弹性网络接口（ENI）概览

## 学习目标
- 理解 ENI 在 VPC 中的角色
- 掌握 ENI 的关键属性与限制
- 了解 ENI 在故障转移中的用途

## 重点速览
- ENI 是虚拟网卡，属于 VPC 组件
- 绑定到特定 AZ，不能跨 AZ 迁移
- 可独立创建并动态挂载/卸载

## 详细内容
ENI（Elastic Network Interface）是 VPC 中的虚拟网卡，用于给 EC2 实例提供网络能力。每个实例至少有一个主 ENI（`eth0`）。

ENI 常见属性：
- 主私有 IPv4（可有多个辅助 IPv4）
- 可绑定弹性 IP 或公有 IP
- 可绑定多个安全组
- 具有固定的 MAC 地址

ENI 可以独立创建并在实例之间迁移，常用于快速故障转移（例如将私有 IP 从实例 A 切换到实例 B）。

注意：ENI **绑定在特定 AZ**，不能跨 AZ 使用。

## 自测问题
- ENI 是否可以跨 AZ 迁移？
- ENI 在故障转移中如何使用？
