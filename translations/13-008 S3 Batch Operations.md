---
source: 13 - Advanced Amazon S3\008 S3 Batch Operations_zh.srt
---

# S3 Batch Operations（批量操作）概览

## 学习目标
- 理解 S3 Batch Operations 的用途与工作流
- 掌握如何生成对象列表并调用批量任务执行常见操作

## 重点速览
- S3 Batch Operations 允许对大量现有对象批量执行操作（修改元数据、复制、加密、调用 Lambda 等）
- 优势：内建重试、进度跟踪、报告与完成通知，适合对海量对象做一次性变更
- 对象列表通常通过 S3 Inventory + S3 Select 生成并传入 Batch 作业

## 详细内容
- 作业组成：对象列表（CSV/清单）、要执行的操作（例如 Copy、Put Object Copy、Invoke Lambda、Encrypt）和操作参数
- 常见用例：批量加密未加密对象、跨桶复制历史对象、修改 ACL/标签、从 Glacier 批量恢复对象、对每个对象调用自定义 Lambda
- 对象列表来源：启用 S3 Inventory 生成对象清单，再用 S3 Select 筛选出目标对象集合并传入 Batch
- 运行与管理：Batch 提供失败重试、并行执行、任务报告和通知，减轻自己实现大规模任务的复杂度

## 自测问题
- 如何为 S3 Batch Operations 生成并筛选要处理的对象列表？
- S3 Batch Operations 相比自写脚本有什么主要优势？
