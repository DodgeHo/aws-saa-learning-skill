---
source: 21 - Databases in AWS\003 Aurora_zh.srt
---


## 学习目标

- 理解 Amazon Aurora 的核心设计：计算与存储分离、与 MySQL/PostgreSQL 兼容的引擎。
- 掌握 Aurora 提供的高级特性：自动扩展存储、写/读端点、Aurora Serverless、Global Database、快速克隆与 ML 集成等。

## 重点速览

- Aurora 将存储和计算分离，存储默认在 3 个 AZ 的 6 份副本中，具有自动修复与自动扩展存储能力。
- 读/写分离：集群具有写入器（writer）端点和读取器（reader）端点，可通过只读副本扩展读取性能。
- 高级功能：Aurora Serverless（按需弹性计算）、Aurora Global（跨区域复制、快速故障转移）、数据库克隆与与 SageMaker 的 ML 集成。

## 详细内容

- 架构特性：
	- 存储层：自动在多 AZ 保持多份副本（默认 6 份），提供高可用性与自动修复。 
	- 计算层：由 Aurora 实例（集群）组成，实例可横向扩展；存在写入器和读取器端点用于路由写/读流量。 

- 可扩展性与业务连续性：
	- 自动扩展存储意味着不必提前预估存储大小。 
	- Aurora Global 支持跨区域复制并允许将次要区域提升为主区域，实现低 RPO 的跨区恢复。 

- 特殊模式与工具：
	- Aurora Serverless：适用于不可预测或间歇性负载，按需自动扩缩计算资源，无需容量规划。 
	- 数据库克隆：快速创建副本环境用于测试或分析，比快照恢复更快。 
	- 可与 SageMaker/Comprehend 集成用于 ML 用例。 

## 自测问题

- 描述 Aurora 如何实现存储与计算分离及其好处。 
- 在何种情境下优先考虑 Aurora Serverless？Aurora Global 又适合哪些场景？
- Aurora 的读写端点如何工作？为什么需要区分二者？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
