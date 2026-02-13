---
source: 09 - AWS Fundamentals RDS + Aurora + ElastiCache\012 ElastiCache Hands On_zh.srt
---

# ElastiCache 实操

## 学习目标
- 创建 Redis 集群
- 了解关键配置项
- 学会删除资源避免费用

## 重点速览
- 可选 Serverless 或自建集群
- 集群模式决定分片与副本数量
- 安全组与加密控制访问

## 详细内容
创建 Redis 集群：
1. 选择 **Redis** 引擎。
2. 选择 **Serverless** 或 **Design your own**。
3. 配置集群模式（是否启用分片）。
4. 设置节点类型与副本数量。
5. 创建 **子网组** 并选择 VPC。
6. 配置加密（静态/传输）与认证（Redis AUTH/ACL）。
7. 配置安全组、维护窗口、日志与标签。
8. 创建集群。

验证与使用：
- 控制台查看主端点与读端点。
- 连接需应用代码支持。

清理：
- 在 **Actions** 中删除集群，输入名称确认。

## 自测问题
- 集群模式开启后会带来什么变化？
- 传输加密开启后为什么需要认证配置？
