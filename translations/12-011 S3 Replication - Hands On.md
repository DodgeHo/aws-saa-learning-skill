---
source: 12 - Amazon S3 Introduction\011 S3 Replication - Hands On_zh.srt
---

# S3 复制 - 实操步骤

## 学习目标
- 能在控制台配置源/目标 Bucket 的复制规则并了解关键选项
- 掌握复制与版本化、删除标记复制、以及复制现有对象的区别

## 重点速览
- 复制要求源与目标 Bucket 启用 Versioning（版本控制）
- 复制规则默认只作用于启用规则之后的新对象；复制现有对象需使用 S3 Batch Replication
- 可选项包括跨区域/同区域、是否复制删除标记等；默认不复制永久删除的特定版本

## 实操流程
1. 创建源与目标 Bucket，并在两者上启用 Versioning
2. 在源 Bucket 的 `Management` → `Replication rules` 创建新规则（例如 DemoReplicationRule）
	- 选择规则范围（全桶或特定前缀/标签）
	- 指定目标 Bucket（本账户或跨账户）与目标区域
	- 为复制操作创建或选择 IAM 角色（Beanstalk 会提示创建所需角色）
	- 决定是否复制现有对象（若需复制历史对象，选用 S3 Batch Replication）
	- 决定是否复制删除标记（默认不复制，可按需启用）
3. 保存规则后对新的上传对象进行验证（目标桶会在短时间内出现复制对象，版本 ID 一致）

## 自测问题
- 为什么复制后的目标对象与源对象有相同的版本 ID？
- 如果想要把历史对象也复制到目标桶，应如何操作？
