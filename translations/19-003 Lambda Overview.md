---
source: 19 - Serverless Overviews from a Solution Architect Perspective\003 Lambda Overview_zh.srt
---

**学习目标**
- 理解 AWS Lambda 的定位、优点与典型用例
- 了解 Lambda 的运行时限制、定价模型及常见语言支持

**重点速览**
- Lambda 是事件驱动的 FaaS 平台：无需管理服务器、按调用与运行时长计费、自动扩缩
- 支持多种语言与自定义运行时，亦支持镜像形式部署（需实现 Lambda 运行时 API）
- 与 API Gateway、S3、DynamoDB、Kinesis、SNS、SQS、CloudWatch 等深度集成

**详细内容**
Lambda 允许开发者上传函数代码（或镜像），在触发事件时按需执行，最长运行时间为 15 分钟。计费按请求数与计算时间（GB‑秒）计费，并提供慷慨免费层（100 万次请求，400,000 GB‑秒）。通过调整内存可以获得更高的 CPU/网络性能。Lambda 可与众多 AWS 服务集成以构建无服务器流水线，例如：S3 触发图像缩略图生成、EventBridge/CloudWatch 定时触发、Kinesis 数据处理、API Gateway 提供 HTTP 接入等。

Lambda 容器映像需实现运行时 API；通常若需运行任意 Docker 镜像或更复杂的容器工作负载，仍建议使用 ECS/Fargate 或 EKS。

**自测问题**
- Lambda 的计费由哪些要素构成？
- 如果需要运行超过 15 分钟或 30 GB 内存的任务，应如何选择？
- Lambda 容器映像与 ECS/Fargate 的适用场景如何区分？
