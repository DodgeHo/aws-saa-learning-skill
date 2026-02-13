---
source: 09 - AWS Fundamentals RDS + Aurora + ElastiCache\013 ElastiCache for Solution Architects_zh.srt
---

# ElastiCache 解决方案要点

## 学习目标
- 了解 ElastiCache 安全与认证选项
- 掌握缓存加载策略
- 记住 Redis Sorted Sets 典型用例

## 重点速览
- Redis 支持 IAM 认证与 Redis AUTH
- Memcached 支持 SASL 认证
- 三种加载策略：延迟加载、直写、会话存储

## 详细内容
**安全与认证**：
- Redis：支持 IAM 认证（仅 API 级），应用连接用 Redis AUTH
- 支持 TLS 传输加密
- Memcached：支持 SASL 认证

**缓存加载策略**：
- 延迟加载：缓存未命中时从数据库读取并写入缓存
- 直写：写数据库时同步更新缓存
- 会话存储：把会话放入缓存并设置 TTL

**考试用例：排行榜**
- Redis 的 **Sorted Sets** 支持排序与唯一性
- 适合实时游戏排行榜

## 自测问题
- 延迟加载与直写的主要差异是什么？
- 为什么 Sorted Sets 适合排行榜？
