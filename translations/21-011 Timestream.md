---
source: 21 - Databases in AWS\011 Timestream_zh.srt
---


## 学习目标

- 理解 Amazon Timestream 的定位：用于时序数据的托管、无服务器数据库。 
- 掌握 Timestream 的存储分层、查询能力与常见集成（IoT、Kinesis、Prometheus、QuickSight 等）。

## 重点速览

- Timestream 专为时间序列数据设计，支持自动扩缩、内存层（近期数据）与成本优化的历史存储层。
- 支持 SQL 查询、排程查询与时序分析功能，并可与 QuickSight、SageMaker、Grafana 集成用于可视化与机器学习。 

## 详细内容

- 基本概念：
	- 时间序列由带时间戳的度量点组成，Timestream 以高效的方式存储与查询这类数据。 

- 存储与查询：
	- 近期数据保存在内存层以实现低延迟查询，历史数据迁移到成本优化层以降低存储成本。 
	- 支持 SQL 风格查询与排程查询，方便做聚合与时间窗口分析。 

- 集成与用例：
	- 常见数据来源包括 AWS IoT、Lambda、Prometheus、Telegraf、Kinesis、MSK 等。 
	- 可与 QuickSight/Grafana 构建仪表板，或与 SageMaker 做机器学习与异常检测。 

## 自测问题

- 解释 Timestream 的两层存储模型以及它为何对时序数据有优势。 
- 列举三种将数据写入 Timestream 的常见方法或服务。 
- 如果需对最近与历史数据运行不同频率的查询，应如何利用 Timestream 的特性设计查询策略？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
