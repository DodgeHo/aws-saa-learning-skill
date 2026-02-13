---
source: 09 - AWS Fundamentals RDS + Aurora + ElastiCache\004 RDS Custom for Oracle and Microsoft SQL Server_zh.srt
---

# RDS Custom（Oracle/SQL Server）

## 学习目标
- 理解 RDS Custom 与标准 RDS 的差异
- 记住支持的引擎范围
- 掌握自定义前的风险控制

## 重点速览
- 仅支持 Oracle 与 Microsoft SQL Server
- 允许访问底层 OS 与数据库定制
- 建议暂停自动化并先做快照

## 详细内容
标准 RDS：
- AWS 完全托管，无法访问底层 OS

RDS Custom：
- 允许 SSH/SSM 访问底层 EC2
- 可安装补丁、修改配置、启用原生功能
- 仍保留 RDS 的自动化优势

操作建议：
- 自定义前停用自动化，避免冲突
- 先创建快照，便于回滚

## 自测问题
- RDS Custom 支持哪些数据库引擎？
- 为什么自定义前需要停用自动化？
