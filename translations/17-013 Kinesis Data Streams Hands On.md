```markdown
**学习目标**

- 掌握使用控制台/CLI 创建 Kinesis Data Stream、写入记录（PutRecord/PutRecords）并用 shard iterator 读取记录的基本流程。
- 理解按分片读取、ShardIterator 类型（TRIM_HORIZON / LATEST）与增强扇出的实操差异。

**重点速览**

- 创建数据流需指定分片数；每个分片影响写入/读取吞吐（默认每分片 1 MB 写入 / 2 MB 读取）。
- 读取流程（低级 API）：DescribeStream → GetShardIterator → GetRecords；建议使用 KCL 或增强扇出以简化消费者实现并提升吞吐。

**详细内容**

- 控制台与 CLI 要点：
  - 创建流时选择按需或预配置模式以及分片数；生产者可用 SDK/KPL/Agent 写入数据（注意 base64 编码或 CLI 的 binary-format 参数）。
  - 读取时获取 ShardIterator（如 TRIM_HORIZON 从头读，LATEST 从最新读），用 GetRecords 获取批次记录并使用 NextShardIterator 迭代。
  - 监控与清理：注意 CloudWatch 指标（Put/Read records），演示完毕及时删除流以避免持续计费。

**自测问题**

1. 使用 CLI 写入 Kinesis 时，为什么需要指定 partition key？
2. 描述用低级 API 从特定分片读取记录的主要步骤。

```
