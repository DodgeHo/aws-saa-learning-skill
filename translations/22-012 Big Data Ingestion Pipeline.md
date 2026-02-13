---
source: 22 - Data & Analytics\012 Big Data Ingestion Pipeline_zh.srt
---

## 学习目标

- 理解构建大型数据摄取管道的关键组件：数据源、传输、缓冲、处理与存储。 
- 掌握使用 Kinesis、Firehose、Glue、Kafka、S3 等服务构建可扩展、容错的数据流的模式。 

## 重点速览

- 摄取管道通常包括事件产生->流收集->实时/批处理->长期存储/分析，常用服务有 Kinesis、MSK、Firehose、Glue、S3、Redshift。 
- 设计要点：吞吐、持久化、重复处理、顺序保证、延迟与成本平衡。 

## 详细内容

- 常见模式：
  - 流式路径：产生端 -> Kinesis/MSK -> 实时处理（Kinesis Data Analytics/Flink/Lambda）-> 输出（S3/Redshift/OpenSearch）。
  - 批处理路径：数据落盘 S3 -> Glue/EMR -> 加载到数据仓库（Redshift）或供 BI 使用。 

- 关键设计考虑：
  - 选择合适的传输与缓冲（Kinesis vs MSK vs Firehose），确保容错与重试机制；使用分区或分片满足并行度需求。 
  - 数据治理：使用 Glue Catalog、Lake Formation、加密与审计来管理元数据与访问控制。 

## 自测问题

- 描述一个同时满足实时与批处理需求的数据摄取架构。 
- 在设计大数据摄取管道时，如何权衡延迟与成本？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
