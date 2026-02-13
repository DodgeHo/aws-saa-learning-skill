---
source: 06 - EC2 - Solutions Architect Associate Level\002 Private vs Public vs Elastic IP Hands On_zh.srt
---

# 实操：私有 IP / 公有 IP / 弹性 IP

## 学习目标
- 验证私有 IP 与公有 IP 的可达性差异
- 观察 Stop/Start 导致的公有 IP 变化
- 绑定并释放弹性 IP

## 重点速览
- 私有 IP 只能在 VPC 内访问
- Stop/Start 会更换公有 IP
- 弹性 IP 可保持固定公有地址

## 操作步骤
1. 使用 **公有 IPv4** SSH 连接实例，确认可访问。
2. 尝试用 **私有 IPv4** SSH（在本地网络），会失败。
3. **Stop → Start** 实例，观察公有 IPv4 变化，私有 IP 不变。
4. 分配 **Elastic IP** 并关联到实例，公有 IP 变为弹性 IP。
5. 再次 Stop/Start，确认公有 IP 不变。
6. 解除关联并释放弹性 IP，避免产生费用。

## 成本提醒
未使用的公有 IPv4/弹性 IP 会计费，请及时释放。

## 自测问题
- 为什么私有 IP 无法从本地直接 SSH？
- 弹性 IP 的最大价值是什么？
