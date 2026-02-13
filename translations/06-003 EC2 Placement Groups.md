---
source: 06 - EC2 - Solutions Architect Associate Level\003 EC2 Placement Groups_zh.srt
---

# EC2 放置组（Placement Groups）

## 学习目标
- 理解放置组的作用与三种策略
- 识别各策略的优缺点与适用场景

## 重点速览
- Cluster：高性能、低延迟，但单点风险高
- Spread：实例分散在不同硬件，最多 7 个/每 AZ
- Partition：分区隔离，适合大规模分布式系统

## 详细内容
放置组用于控制 EC2 实例在 AWS 基础设施中的物理分布。三种策略：

1. **Cluster（集群）**
	- 同一 AZ、同一机架，网络延迟低、吞吐高
	- 风险：机架故障会影响全部实例
	- 适合高性能、大数据、低延迟应用

2. **Spread（分散）**
	- 实例分布在不同硬件上，最大化容错
	- 限制：每个放置组每 AZ 最多 7 个实例
	- 适合关键应用与高可用需求

3. **Partition（分区）**
	- 同一 AZ 内划分多个分区（不同机架），每分区可放大量实例
	- 每 AZ 最多 7 个分区
	- 适合 HDFS、HBase、Cassandra、Kafka 等分区感知系统

实例可通过元数据服务查询所在分区。

## 自测问题
- Cluster 与 Spread 的风险与收益各是什么？
- Partition 与 Spread 的主要区别是什么？
