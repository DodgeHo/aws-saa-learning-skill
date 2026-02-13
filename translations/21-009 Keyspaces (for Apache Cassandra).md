---
source: 21 - Databases in AWS\009 Keyspaces (for Apache Cassandra)_zh.srt
---


## 学习目标

- 了解 Amazon Keyspaces（托管的 Apache Cassandra）在 AWS 上的定位与特性。
- 掌握 Keyspaces 的容量模型、复制、查询接口（CQL）以及典型用例（物联网、时间序列等）。

## 重点速览

- Keyspaces 是 AWS 托管的 Apache Cassandra 服务，提供无服务器式扩展、自动缩放与高可用性。 
- 使用 Cassandra 查询语言（CQL）进行访问；表在多个 AZ 中复制以提高可用性；支持按需与预配（带自动扩缩）两种容量模式。 

## 详细内容

- 核心特性：
	- 托管 Cassandra：免运维，自动根据流量扩展表，适合高吞吐场景。 
	- 数据复制：表数据在多个 AZ 中复制，保证可用性与耐久性。 
	- 接口与性能：使用 CQL 查询，能在任意规模下实现低毫秒级延迟与高并发处理。 

- 容量、备份与恢复：
	- 支持按需模式与预配（带自动扩缩）模式；提供加密、备份与时间点恢复（最多 35 天）。 

- 典型用例：
	- 适合 IoT 设备数据、时间序列或其他需要可扩展 Cassandra 模型的场景。 

## 自测问题

- Keyspaces 与自建 Cassandra 集群相比的主要优势是什么？
- 在 Keyspaces 中如何选择按需与预配容量模式？列出决策要点。 
- 给出两个适合使用 Keyspaces 的应用场景并解释原因。 

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
