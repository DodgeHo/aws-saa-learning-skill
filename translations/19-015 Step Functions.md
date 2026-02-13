---
source: 19 - Serverless Overviews from a Solution Architect Perspective\015 Step Functions_zh.srt
---

**学习目标**
- 理解 AWS Step Functions 的作用：可视化编排无服务器工作流
- 掌握常见状态类型（顺序、并行、选择、等待、错误处理）与与其他服务的集成模式

**重点速览**
- Step Functions 提供状态机（State Machine）用于定义工作流，每一步可以调用 Lambda、ECS、API Gateway、SQS 等服务
- 支持条件分支、并行执行、重试/捕获错误与人工审批（Human-in-the-loop）场景
- 提供可视化监控与执行历史，便于调试与重试失败步骤

**详细内容**
Step Functions 通过定义状态机来编排复杂业务流程：状态包括 Task（调用任务）、Choice（分支判断）、Parallel（并行）、Wait（等待）、Map（并行映射）与终止/失败状态。它能与大量 AWS 服务集成（Lambda、ECS、Batch、Glue、SNS、SQS、API Gateway 等），并支持标准与 Express 两种执行模式（Express 适合高吞吐短时任务，Standard 支持更长运行与可见性）。

常见用例包括订单履行、数据处理管道、长时间运行的审批流程与事件驱动的任务编排。Step Functions 的错误处理、重试策略与可视化执行历史是其核心价值。

**自测问题**
- Step Functions 的两种执行模式有哪些区别？
- 哪些状态类型可用于并行执行任务？
- 如何在工作流中实现人工审批步骤？
