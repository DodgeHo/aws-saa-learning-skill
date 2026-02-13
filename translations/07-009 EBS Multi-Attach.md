---
source: 07 - EC2 Instance Storage\009 EBS Multi-Attach_zh.srt
---

# EBS Multi-Attach

## 学习目标
- 了解 Multi-Attach 的用途
- 记住可用范围与限制

## 重点速览
- 仅支持 `io1/io2`
- 同一 AZ 内可多实例挂载同一卷
- 需要支持多写入的集群文件系统

## 详细内容
**EBS Multi-Attach** 允许在同一可用区内将一个卷挂载到多个实例：
- 适用于集群/高可用场景
- 仅支持 `io1/io2`
- 每个实例拥有读写权限，应用需处理并发写入

限制与注意：
- 仅限同一 AZ
- 最多可挂载到 16 个实例
- 必须使用支持集群的文件系统

## 自测问题
- Multi-Attach 的最大实例数是多少？
- 为什么需要集群文件系统而不是普通文件系统？
