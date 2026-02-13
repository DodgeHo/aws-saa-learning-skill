---
source: 06 - EC2 - Solutions Architect Associate Level\008 EC2 Hibernate_zh.srt
---

# EC2 休眠（Hibernate）

## 学习目标
- 理解 Hibernate 与 Stop/Terminate 的差异
- 掌握休眠的工作原理与限制条件

## 重点速览
- 休眠会保存 RAM 状态到根 EBS 卷
- 启动更快，避免重复初始化
- 根卷必须加密且容量足够

## 详细内容
Stop 会保留 EBS 数据但丢失 RAM；Terminate 会按配置删除卷。Hibernate 则把 RAM 内容写入根 EBS 卷，使实例“像未停止一样”恢复，启动速度更快。

休眠流程：
1. 实例运行，RAM 有状态
2. 休眠时将 RAM 写入根 EBS 卷
3. 实例停止
4. 再次启动时从卷恢复 RAM

适用场景：长时间运行的进程、需要保留内存状态、初始化耗时长的服务。

限制与要求：
- 仅支持部分实例系列，且不支持裸机实例
- 根卷必须是 **加密 EBS**，容量需容纳 RAM
- RAM 上限（当前约 150 GB）
- 休眠最长 60 天

## 自测问题
- Hibernate 与 Stop 的核心区别是什么？
- 为什么根卷必须加密且容量足够？
