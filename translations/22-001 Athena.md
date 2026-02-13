---
source: 22 - Data & Analytics\001 Athena_zh.srt
---

## 学习目标

- 理解 Amazon Athena 的定位：无服务器的 SQL 即席查询服务，用于直接查询存放在 Amazon S3 上的数据。
- 掌握影响 Athena 成本与性能的要点：列式格式（Parquet/ORC）、分区、压缩与合并小文件等优化技巧。

## 重点速览

- Athena 支持对 S3 中 CSV/JSON/Parquet/ORC/Avro 等格式文件使用标准 SQL 查询；基于 Presto 引擎实现。 
- 定价按扫描数据量计费：优先使用列式格式（Parquet/ORC）、分区与压缩以降低扫描数据量与费用。 
- 支持 Federated Query（通过数据源连接器在其他数据库与服务上执行查询），常与 Glue、QuickSight 配合使用用于 ETL 与可视化。 

## 详细内容

- 用例与流程：
	- 适用于即席查询、BI 报告、日志分析（VPC Flow/ALB/CloudTrail 等）和对 S3 数据的交互式探索。 
	- 常见架构：数据以 Parquet/ORC 存放在 S3，通过 Athena 查询；查询结果可保存回 S3 并由 QuickSight 可视化。 

- 性能优化建议：
	- 使用列式存储（Parquet/ORC）与压缩减少扫描量；进行分区（按年月日等）以只扫描需要的文件路径；避免大量小文件，合并成较大的对象（例如 ≥128MB）。 
	- 在需要对外部数据源查询时使用 Federated Query，借助 Lambda 连接器访问 RDS、DynamoDB、CloudWatch Logs 等。 

- 实践注意：
	- 设置查询结果位置（S3 Bucket）；注意查询成本监控与权限（IAM/Glue Data Catalog）。 

## 自测问题

- 为什么将数据转换为 Parquet 会降低 Athena 的查询成本？
- 请列出三种减少 Athena 扫描数据量的方法。 
- Athena 的 Federated Query 可以连接哪些类型的数据源？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
