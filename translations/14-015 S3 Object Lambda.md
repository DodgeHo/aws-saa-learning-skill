---
source: 14 - Amazon S3 Security\015 S3 Object Lambda_zh.srt
---

- ：EFS三个接入点还有另一个用例, 称为S3

Object Lambda｡

因此, 我们的想法是, 您有一个S3桶,
## 学习目标

- 理解 S3 Object Lambda 的概念：在对象被检索时通过 Lambda 动态修改或增强对象内容。
- 知道如何使用 Object Lambda 来避免复制数据桶并按需对对象进行转换、脱敏或增强。

## 重点速览

- S3 Object Lambda 通过在 Access Point 之上关联 Lambda 函数，当客户端通过该访问点读取对象时，Lambda 会拦截请求、拉取原始对象、运行转换代码并返回修改后的对象。
- 用例包括 PII 脱敏、XML→JSON 转换、按请求用户动态丰富内容、图片按需缩放或加水印等。

## 详细内容

1. 工作原理
- 为现有 S3 桶创建 Access Point，并将该 Access Point 与一个 Lambda 关联（Object Lambda Access Point）。当客户端请求对象时，请求会通过该访问点触发 Lambda，Lambda 从原始桶取回对象并返回处理后的结果给调用方。

2. 优点
- 无需复制或维护多个桶来保存不同的对象版本；不同的应用可以通过不同的 Object Lambda Access Point 获得不同的“视图”。
- 支持多种处理逻辑：脱敏（redaction）、格式转换、增强数据（例如从外部数据库拉取信息）、图像处理等。

3. 注意事项
- Lambda 的执行时间与并发会影响性能与成本；对高吞吐量场景需做好容量与成本评估。
- 需要为 Access Point 与 Lambda 配置适当的权限与 IAM 策略，确保 Lambda 可读取源桶并返回响应。

## 自测问题

1. S3 Object Lambda 与普通 S3 Access Point 的主要不同点是什么？
2. 给出两个适合使用 Object Lambda 的实际例子，并说明为什么比复制桶更合适。
