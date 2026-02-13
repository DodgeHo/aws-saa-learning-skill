---
source: 09 - AWS Fundamentals RDS + Aurora + ElastiCache\007 Amazon Aurora - Advanced Concepts_zh.srt
---

# Aurora 高级概念

## 学习目标
- 了解副本自动缩放与自定义端点
- 掌握 Serverless 与 Global Database 的用途
- 了解 Aurora ML 集成方向

## 重点速览
- 副本自动缩放：读压力高时自动加副本
- 自定义端点：按副本规格拆分工作负载
- Global Database：跨区域复制 < 1 秒

## 详细内容
**副本自动缩放**：
- 读请求激增时自动新增 Aurora 副本
- reader endpoint 自动纳入新副本

**自定义端点**：
- 选择一部分副本（如更大规格）组成专用端点
- 适合分析型/重型查询

**Aurora Serverless**：
- 依据负载自动创建与扩缩实例
- 适合不规律或间歇性负载

**Aurora Global Database**：
- 主区域读写，最多 5 个只读辅助区域
- 跨区域复制通常 < 1 秒
- 故障转移 RTO 可 < 1 分钟

**Aurora ML**：
- 通过 SQL 调用 SageMaker / Comprehend
- 用于推荐、情感分析、欺诈检测

## 自测问题
- 自定义端点解决了什么问题？
- Global Database 的关键考试点是什么？
