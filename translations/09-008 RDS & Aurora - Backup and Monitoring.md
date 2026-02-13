---
source: 09 - AWS Fundamentals RDS + Aurora + ElastiCache\008 RDS & Aurora - Backup and Monitoring_zh.srt
---

# RDS/Aurora 备份与恢复

## 学习目标
- 掌握自动备份与手动快照差异
- 理解从 S3 恢复到 RDS/Aurora 的限制
- 了解 Aurora 克隆的优势

## 重点速览
- 自动备份保留 1-35 天（Aurora 不能关闭）
- 手动快照可长期保留
- Aurora 克隆基于写时复制，速度快

## 详细内容
**自动备份**：
- 每日全量备份 + 事务日志每 5 分钟
- 可做时间点恢复（最早到 5 分钟前）
- RDS 可关闭；Aurora 不能关闭

**手动快照**：
- 需手动触发
- 可长期保留

成本技巧：
- 不常用数据库可做快照后删除实例，降低成本

**从 S3 恢复**：
- RDS MySQL：可直接从 S3 备份恢复
- Aurora MySQL：需使用 Percona XtraBackup 生成备份并上传 S3

**Aurora 克隆**：
- 从现有集群快速创建新集群
- 写时复制：初期共享存储，写入时才分离
- 适合生产数据的测试/预发布环境

## 自测问题
- RDS 与 Aurora 在自动备份上有何区别？
- Aurora 克隆为什么比快照恢复快？
