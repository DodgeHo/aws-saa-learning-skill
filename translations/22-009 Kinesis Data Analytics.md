---
source: 22 - Data & Analytics\009 Kinesis Data Analytics_zh.srt
---

## 学习目标

- 理解 Amazon Kinesis Data Analytics 的作用：实时流数据处理与分析（基于 SQL 或 Flink）。 
- 掌握与 Kinesis Data Streams/Firehose 的集成模式和常见实时应用。 

## 重点速览

- Kinesis Data Analytics 允许使用 SQL 或 Apache Flink 对流进行近实时分析与窗口化聚合。 
- 常见用途包括实时指标计算、异常检测与流式 ETL。 

## 详细内容

- 工作方式与集成：
  - 从 Kinesis Data Streams 或 Kinesis Data Firehose 读取事件，执行实时处理并输出到 S3、Redshift、Elasticsearch 或 Lambda。 
  - 支持 SQL 编辑器进行快速原型，也支持更复杂的 Flink 作业进行状态管理与事件时间处理。 

- 运行与监控：
  - 注意并发、状态后端与检查点（checkpoint）配置以保证正确性与容错；利用 CloudWatch 监控延迟和错误率。 

## 自测问题

- Kinesis Data Analytics 使用何种方法来处理事件时间与延迟？
- 描述将流数据写回 S3 的典型流程。 

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
