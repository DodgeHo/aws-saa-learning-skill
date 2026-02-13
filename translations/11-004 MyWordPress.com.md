---
source: 11 - Classic Solutions Architecture Discussions\004 MyWordPress.com_zh.srt
---

# 架构演进：MyWordPress.com

## 学习目标
- 理解 WordPress 的有状态存储挑战
- 区分 EBS 与 EFS 的适用场景
- 选择合适的数据库方案

## 重点速览
- WordPress 内容与用户数据应放数据库
- 图片/媒体需要共享文件存储
- EFS 适合多实例共享，EBS 适合单实例

## 详细内容
数据库层：
- 可用 RDS MySQL（Multi-AZ）
- 需要更高扩展性可选 Aurora MySQL（读副本/全球数据库）

文件存储问题：
- 单实例 + EBS：可用
- 多实例 + EBS：数据不共享，图片丢失

解决方案：
- 使用 **EFS** 作为共享文件系统
- 多 AZ 实例都可访问同一媒体文件

权衡：
- EBS 成本低但不共享
- EFS 成本高但支持多实例共享

## 自测问题
- 为什么多实例 WordPress 不能只用 EBS？
- 何时优先选择 Aurora 而不是 RDS MySQL？
