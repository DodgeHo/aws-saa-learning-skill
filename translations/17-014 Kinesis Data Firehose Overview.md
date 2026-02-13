```markdown
**学习目标**

- 理解 Kinesis Data Firehose 的定位：无服务器的流数据传输服务，负责把流数据近实时写入目标存储。
- 掌握 Firehose 的主要目标（S3、Redshift、OpenSearch、第三方与自定义 HTTP 端点）与缓冲配置要点。

**重点速览**

- Firehose 是托管的、自动扩缩的交付通道（delivery stream），支持可选的 Lambda 转换、批量缓冲（size / interval）、压缩与加密。
- 与 Data Streams 不同：Firehose 不存储原始流用于重放（无重放能力），更适合近实时 ETL 与数据落盘场景。

**详细内容**

- 工作流程与配置：
  - 源可以是直接 PUT、Kinesis Data Streams、CloudWatch、IoT 等；可选 Lambda 转换用于清洗/格式化数据。
  - 缓冲策略决定何时将数据写入目标：按大小或时间（例如 1MB / 60s）；较大缓冲减少成本但增加延迟（近实时通常为 60s 最小延迟）。
  - 目标包含 S3（可做备份）、Redshift（通过先写入 S3 后 COPY）、OpenSearch、第三方（Splunk/Datadog）或自定义 HTTP 端点。
  - 错误处理：可将失败记录发送到指定的失败 S3 桶用于后续排查或重试。

**自测问题**

1. Firehose 与 Data Streams 在“重放能力”与“管理要求”上有何区别？
2. Firehose 的缓冲大小与缓冲间隔如何影响延迟与成本？

```
