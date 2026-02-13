```markdown
**学习目标**

- 掌握通过控制台创建 Kinesis Data Firehose 交付流的关键步骤（选择源、目标、缓冲策略、转换与 IAM 角色）。
- 理解如何测试流并验证数据在目标（如 S3）中的到达情况。

**重点速览**

- 创建流程：选择源（Kinesis Data Streams 或直接 PUT）→ 配置目标（S3/Redshift/OpenSearch/HTTP/第三方）→ 可选 Lambda 转换 → 设置缓冲大小与间隔 → 指定 IAM 角色。
- 缓冲与延迟：缓冲按大小或时间触发写入（默认示例 5 MB 或 60s），更小间隔可降低延迟但可能增加写入次数与成本。

**详细内容**

- 实操要点：
  - 源选择：常见为 Kinesis Data Streams（将流再路由到 Firehose）；目标常为 S3（可作为备份）或 Redshift（先写 S3 再 COPY）。
  - 转换：启用 Lambda 转换可在写入前清洗或转换记录（例如转为 Parquet/ORC）；需为 Firehose 配置相应的 Lambda IAM 权限。
  - IAM：Firehose 需要一个服务角色来写入目标与读取源（若为 Kinesis Data Streams）。
  - 测试与清理：发送测试记录（或从 DemoStream 写入），等待缓冲时间后在目标 S3 查验对象；完成练习后删除交付流与临时流以避免费用。

**自测问题**

1. 如果希望 Firehose 更快将数据写入 S3，应如何调整缓冲设置？有哪些权衡？
2. 将 Firehose 数据发入 Redshift 时，Firehose 会先将数据写到哪里？

```
