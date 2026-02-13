```markdown
**学习目标**

- 了解 Snowball 将数据导入 AWS 时与 Glacier 的关系。
- 掌握把离线导入数据归档到 Glacier 的标准架构流程。

**重点速览**

- Snowball 不能直接写入 Glacier；必须先将数据导入 Amazon S3，然后通过生命周期规则转为 Glacier/Glacier Deep Archive。
- 典型流程：Snowball → S3 桶 → S3 生命周期规则 → Glacier。

**详细内容**

- 场景：需要将大量离线数据归档到 Glacier，但 Snowball 设备本身无法直接写入 Glacier 存储类。正确做法是将 Snowball 的数据导入目标 S3 桶，然后为该桶或对象设置生命周期策略，将对象自动迁移到 Glacier/Deep Archive。
- 考试要点：若题目问“如何把 Snowball 导入的数据归档到 Glacier？”，正确答案通常为先导入 S3，再配置生命周期策略，不是直接从 Snowball 写入 Glacier。

**自测问题**

1. Snowball 能否将数据直接写入 Glacier？为什么？
2. 描述把 Snowball 导入的数据移动到 Glacier 的步骤。

```
