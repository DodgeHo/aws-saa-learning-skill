---
source: 22 - Data & Analytics\010 Kinesis Data Analytics - Hands On_zh.srt
---

## 学习目标

- 通过实操了解如何使用 Kinesis Data Analytics 创建一个简单的流处理作业并输出结果。 

## 重点速览

- Hands-on 关注：连接数据源（Kinesis Streams/Firehose）、定义输入映射、编写 SQL/Flink 逻辑、配置输出。 

## 详细内容

- 实操流程（高层）：
  - 创建或使用已有 Kinesis Data Stream，准备示例事件数据。 
  - 在 Kinesis Data Analytics 中创建应用，配置输入映射并测试 SQL 查询或上传 Flink 程序。 
  - 配置输出，将结果写入 S3、Lambda 或目标数据存储，并观察 CloudWatch 指标。 

- 注意事项：
  - 处理时间窗口（tumbling/sliding）、检查点与状态后端配置对正确性至关重要；测试小批量数据确保映射正确。 

## 自测问题

- 在 Hands-on 中，为什么需要配置检查点（checkpoint）？
- 列出将处理结果输出到 S3 的关键步骤。 

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
