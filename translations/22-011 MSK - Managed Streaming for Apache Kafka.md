---
source: 22 - Data & Analytics\011 MSK - Managed Streaming for Apache Kafka_zh.srt
---

## 学习目标

- 理解 Amazon MSK 的定位：托管的 Apache Kafka 服务、适合高吞吐低延迟的流式平台。 
- 掌握 MSK 的集群部署选项、数据保留与安全配置要点。 

## 重点速览

- MSK 提供与开源 Kafka 兼容的托管服务，支持多 AZ 部署、备份与监控。 
- 适用于需要持久化主题、分区与高吞吐的事件驱动系统。 

## 详细内容

- 部署与操作：
  - MSK 可以使用自管理或 AWS 管理的配置，支持多可用区复制以保证高可用性。 
  - 需考虑分区策略、消费者组与吞吐需求来选定节点规格与分区数。 

- 安全与整合：
  - 支持 IAM、VPC 私有访问、TLS 与 SASL 认证；可与 MSK Connect、Kinesis、Lambda 等集成消费数据。 

## 自测问题

- 描述为保证高可用性在 MSK 中常见的部署做法。 
- MSK 与 Kinesis 的主要差异是什么？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
