---
source: 22 - Data & Analytics\003 Redshift_zh.srt
---


## 学习目标

- 理解 Amazon Redshift 的定位与适用场景：列式 OLAP 数据仓库，适合复杂查询和大规模分析。 
- 掌握 Redshift 的关键特性：集群架构（leader + compute 节点）、快照与 DR、Redshift Spectrum、数据摄取方式与规模化策略。 

## 重点速览

- Redshift 是面向分析的列式数据库，针对 PB 级数据与复杂聚合/连接进行了优化；适合 BI 报表与数据仓库场景。 
- 典型架构：提交查询到 leader 节点，实际执行在 compute 节点并返回结果；支持快照（存储在 S3）与跨区域复制实现灾备。 
- 数据摄取方式：Kinesis Data Firehose、COPY 从 S3 或使用 JDBC 驱动批量写入；Redshift Spectrum 可直接对 S3 上的数据执行查询而无需先加载。 

## 详细内容

- 集群与运维：
	- Redshift 集群包含 leader 节点与若干 compute 节点；节点类型与数量需预配，支持 Reserved Instances 降低成本。 
	- 备份与恢复：自动/手动快照存储在 S3，支持自动或按需复制到另一区域用于 DR。 

- 性能与扩展：
	- 列式存储与并行查询引擎提供高吞吐，适合大量聚合与连接操作；Spectrum 将查询推送到专用节点以分析 S3 上的数据。 

- 数据摄取与集成：
	- 使用 Kinesis Data Firehose 将实时流写入 S3 后加载到 Redshift，或直接在 Redshift 上执行 `COPY` 从 S3 批量导入。 
	- 可通过 JDBC 客户端或 ETL 工具写入，但应批量加载而非逐行插入以提高效率。 

## 自测问题

- Redshift Spectrum 的用途是什么？它与 Athena 有何不同？
- 描述将数据从 S3 导入 Redshift 的两种常见方法。 
- Redshift 如何实现跨区域灾难恢复（DR）？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
