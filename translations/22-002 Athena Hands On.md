---
source: 22 - Data & Analytics\002 Athena Hands On_zh.srt
---


## 学习目标

- 掌握在 Athena 控制台设置查询结果位置并创建数据库/外部表的基本操作。 
- 会使用 Athena 对 S3 中数据进行预览、运行查询和保存/管理查询结果。 

## 重点速览

- 在运行查询前需配置查询结果的 S3 位置（在 View settings -> Manage 中设置）。
- 使用 CREATE DATABASE/CREATE EXTERNAL TABLE 在 Glue Data Catalog 下创建数据库与表，以便在 Athena 中查询 S3 数据。 
- 可在控制台预览表数据、运行聚合查询（GROUP BY）并将查询结果保存到指定的 S3 存储桶。 

## 详细内容

- 操作步骤示例：
	1. 在 S3 创建用于存放查询结果的 Bucket（例如 stephane-demo-athena-...），在 Athena 设置中填写 `s3://bucket-name/`。 
	2. 使用 SQL 创建数据库：`CREATE DATABASE ...`，随后用 `CREATE EXTERNAL TABLE` 指向 S3 上的日志或数据路径。 
	3. 运行 `SELECT`/`GROUP BY` 等查询以聚合日志（统计不同 status、URI 等），在控制台可预览返回的前 N 行。 
	4. 可将查询结果写回 S3，或将常用查询保存为 Saved Query 便于复用。 

- 实践提示：
	- 建表时注意字段类型与分区路径（partitioned by），预览能帮助校验表结构；
	- 若查询数据量大，先测试小范围（LIMIT / 指定分区）以避免高额扫描费用。 

## 自测问题

- 在 Athena 中如何配置查询结果的位置？
- 创建外部表时需要改动哪些字段以匹配目标 S3 路径？
- 如何在控制台预览表并验证数据格式正确？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
