## 学习目标

- 理解 Bastion Host（跳板机）的用途、部署模式与安全实践。

## 重点速览

- Bastion Host 用作进入私有子网的单一跳点，通常放在公有子网并通过严格的安全组/审计访问。

## 详细内容

1. 部署方式：在公有子网部署最小权限的 EC2，限制仅允许管理人员的 IP 访问，并通过该主机 SSH/RDP 到私有实例。
2. 安全强化：使用 MFA、Session 记录、最小化网络口径、定期更换密钥；也可使用 AWS Systems Manager Session Manager 替代跳板机以减少公网暴露。

## 自测问题

1. 列出 Bastion Host 的三个安全最佳实践。
2. 为什么 Session Manager 有时比传统 Bastion 更受推荐？
