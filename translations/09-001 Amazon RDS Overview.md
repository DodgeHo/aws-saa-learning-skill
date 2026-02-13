---
source: 09 - AWS Fundamentals RDS + Aurora + ElastiCache\001 Amazon RDS Overview_zh.srt
---

# Amazon RDS 概览

## 学习目标
- 了解 RDS 的定位与优势
- 记住 RDS 支持的引擎
- 掌握存储自动扩展要点

## 重点速览
- RDS 是托管关系型数据库服务
- 支持 PostgreSQL、MySQL、MariaDB、Oracle、SQL Server、DB2、Aurora
- 支持自动备份、维护、监控与扩缩

## 详细内容
RDS 提供托管型 SQL 数据库，AWS 负责底层运维：
- 自动化部署与补丁
- 持续备份与时间点恢复
- 监控与维护窗口
- 纵向扩展实例规格，横向扩展读副本

限制：不能 SSH 到底层实例（托管服务特性）。

**存储自动扩展**：
- 创建时指定初始存储与最大上限
- 当可用存储 < 10% 且持续 5 分钟，并距上次扩展超过 6 小时，会自动扩容
- 适合负载不可预测的应用

## 自测问题
- 使用 RDS 相比自建数据库的主要优势是什么？
- RDS 存储自动扩展触发条件是什么？
