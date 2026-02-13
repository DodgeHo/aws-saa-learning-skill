---
source: 06 - EC2 - Solutions Architect Associate Level\009 EC2 Hibernate - Hands On_zh.srt
---

# 实操：EC2 Hibernate

## 学习目标
- 启用 Hibernate 并验证效果
- 了解加密与容量要求

## 重点速览
- 根卷必须加密
- 根卷容量要大于 RAM

## 操作步骤
1. 启动 Amazon Linux 2 实例（`t2.micro`）。
2. 在高级设置中**启用 Hibernate**。
3. 勾选根卷加密（使用默认 KMS 密钥）。
4. 启动实例并使用 EC2 Instance Connect 连接。
5. 运行 `uptime` 记录运行时间。
6. 将实例 **Hibernate**，等待停止。
7. 再次启动实例，重新连接并运行 `uptime`，验证时间未重置为 0。
8. 实操结束后终止实例。

## 自测问题
- 为什么 `t2.micro` 的 8 GiB 根卷足够支持 Hibernate？
- 如何判断实例是 Hibernate 恢复而不是冷启动？
