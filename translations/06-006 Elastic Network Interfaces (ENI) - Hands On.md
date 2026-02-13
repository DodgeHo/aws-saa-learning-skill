---
source: 06 - EC2 - Solutions Architect Associate Level\006 Elastic Network Interfaces (ENI) - Hands On_zh.srt
---

# ENI 实操

## 学习目标
- 创建并附加弹性网络接口
- 在实例间迁移 ENI 实现故障转移
- 理解实例终止时 ENI 的保留规则

## 重点速览
- 手动创建的 ENI 会保留
- 实例自带的 ENI 会随实例删除

## 操作步骤
1. 启动两台 Amazon Linux 2 实例（`t2.micro`）。
2. 在 **Network & Security → Network Interfaces** 查看各实例的 ENI。
3. 创建新 ENI：选择与实例相同 AZ 的子网，自动分配私有 IPv4，并绑定安全组。
4. 将 ENI 附加到实例，刷新实例网络信息可看到第二张网卡。
5. 将 ENI 从实例 A 分离，再附加到实例 B，验证私有 IP 迁移。
6. 终止实例，观察：实例自带 ENI 自动删除，手动 ENI 保留。

## 自测问题
- 为什么 ENI 必须与实例在同一 AZ？
- 哪些 ENI 会在实例终止时被删除？
