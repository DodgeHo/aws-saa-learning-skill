```markdown
**学习目标**

- 了解 Amazon Kinesis 的定位与组成（Data Streams、Data Firehose、Data Analytics、Video Streams）。
- 能区分各子服务的主要用途与典型场景（实时采集、批量传输、实时分析、视频流处理）。

**重点速览**

- Kinesis 是用于实时收集、处理与分析流数据的家族服务：
  - Data Streams：可编程的流，用于按需消费与重放。
  - Data Firehose：托管的传输，负责把流数据送到 S3/Redshift/OpenSearch 等目标（近实时、无重放）。
  - Data Analytics：使用 SQL 或 Flink 对流数据做实时分析。
  - Video Streams：专用于视频流采集与处理。

**详细内容**

- 选择建议：
  - 需要自定义处理与重放能力、且可管理分片容量 → 选 Data Streams。
  - 需要无运维的近实时传输并写入目标存储/第三方 → 选 Data Firehose。
  - 需要在流上执行实时 SQL/Flink 分析 → 选 Data Analytics。
  - 视频流捕获/处理则使用 Video Streams。
- Kinesis 适用于点击流、日志、遥测、实时监控与大数据摄取等场景，设计时关注分片、吞吐与保留策略（Data Streams 可保留 1–365 天）。

**自测问题**

1. Data Streams 与 Data Firehose 在“重放能力”上有什么不同？
2. 哪个 Kinesis 子服务更适合将流数据直接送入 Redshift？为什么？

```
