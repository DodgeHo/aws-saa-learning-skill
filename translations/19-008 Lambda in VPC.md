---
source: 19 - Serverless Overviews from a Solution Architect Perspective\008 Lambda in VPC_zh.srt
---

**学习目标**
- 理解如何让 Lambda 访问 VPC 内资源（如 RDS、ElastiCache）及相关限制
- 掌握为 Lambda 配置子网、安全组与使用 RDS Proxy 的理由

**重点速览**
- 默认 Lambda 在 AWS 管理的网络中运行，不可直接访问客户 VPC 内私有资源
- 若需访问 VPC 资源，必须将 Lambda 配置为在指定子网与安全组内运行（会创建 ENI）
- 使用 RDS Proxy 可减少直接连接对数据库造成的压力，提升可伸缩性与可用性

**详细内容**
默认情况下 Lambda 在 AWS 管理的环境中执行，能访问公共 AWS 服务（如 DynamoDB、S3）但不能访问私有子网内的 RDS 或 ElastiCache。若函数需要访问这些私有资源，需在函数配置中指定 VPC、子网与安全组，Lambda 将为其创建弹性网络接口（ENI）以实现私有连接。

注意事项：ENI 的创建会增加冷启动时间与网络配置复杂度；若函数高并发频繁创建 ENI，应考虑 VPC 连接优化、减少子网内 IP 消耗或使用 VPC 端点。对于数据库连接，建议使用 RDS Proxy 来复用连接、控制连接数并启用 IAM 验证，从而避免大量 Lambda 并发导致数据库连接耗尽的问题。

**自测问题**
- 默认 Lambda 是否能访问私有 RDS 实例？为什么需要为 Lambda 创建 ENI？
- RDS Proxy 带来哪些好处？
- 将 Lambda 加入 VPC 会带来哪些性能/延迟影响？
