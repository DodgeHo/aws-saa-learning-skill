---
source: 06 - EC2 - Solutions Architect Associate Level\004 EC2 Placement Groups - Hands On_zh.srt
---

# 放置组实操

## 学习目标
- 在控制台创建三种放置组
- 在启动实例时选择放置组

## 重点速览
- Cluster/Spread/Partition 各有独立配置
- 放置组在“高级详细信息”中选择

## 操作步骤
1. 进入 **Network & Security → Placement Groups**。
2. 创建三个放置组：
	- **HighPerformanceGroup**：Cluster
	- **CriticalGroup**：Spread（默认 rack）
	- **DistributedGroup**：Partition（如 4 个分区）
3. 启动实例时，在 **Advanced details** 里选择放置组名称。

## 自测问题
- 在启动实例时，放置组选择位于哪个页面区域？
