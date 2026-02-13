---
source: 09 - AWS Fundamentals RDS + Aurora + ElastiCache\011 ElastiCache Overview_zh.srt
---

# ElastiCache 概览

## 学习目标
- 理解缓存的作用与使用方式
- 区分 Redis 与 Memcached

## 重点速览
- ElastiCache 提供托管 Redis/Memcached
- 缓存用于减轻数据库读压力
- Redis 支持高可用与持久化，Memcached 不支持

## 详细内容
**缓存的价值**：
- 内存数据库，低延迟高吞吐
- 减少读密集型数据库压力
- 支持会话存储，实现应用无状态化

**基本流程（缓存命中/未命中）**：
- 命中：直接从缓存返回
- 未命中：查询数据库 -> 写回缓存
- 需设计缓存失效策略

**Redis vs Memcached**：
- Redis：多 AZ、读副本、持久化、备份恢复
- Memcached：分片、多线程、无持久化/无高可用

## 自测问题
- 缓存命中与未命中分别会发生什么？
- 为什么 Redis 更适合高可用场景？
