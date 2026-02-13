## 学习目标

- 掌握 AWS 中常用缓存模式（边缘缓存、应用缓存、数据缓存）与对应服务（CloudFront、ElastiCache、DAX）。

## 重点速览

- CloudFront 提供边缘缓存以降低延迟与外网带宽；ElastiCache（Redis/Memcached）用于应用层数据缓存；DAX 为 DynamoDB 提供加速缓存。

## 详细内容

1. 缓存失效策略（TTL）、缓存一致性与缓存预热是设计缓存层时的关键考虑点。
2. ElastiCache Redis 支持复杂数据结构与持久化选项；Memcached 简单、水平扩展性能好；DAX 专为 DynamoDB 设计，透明加速读操作。
3. 设计注意：缓存穿透、缓存雪崩与缓存击穿的防护策略（如使用互斥锁、二级缓存或预热）。

## 自测问题

1. 描述 CloudFront 如何帮助降低用户延迟并节省带宽成本。
2. 列出防止缓存击穿的三种常用方法。
