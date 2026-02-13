---
source: 22 - Data & Analytics\008 Lake Formation_zh.srt
---

## 学习目标

- 理解 AWS Lake Formation 的目的：简化构建与管理数据湖的权限、目录与安全治理。 
- 掌握数据权限细粒度控制、蓝图与数据入口的基本概念。 

## 重点速览

- Lake Formation 在 S3 之上提供元数据、访问控制与数据准备工作流，便于合规与团队协作。 
- 与 Glue Catalog 和 IAM 集成，支持列/行级别权限控制与审计。 

## 详细内容

- 功能概述：
  - 数据湖蓝图（blueprints）用于快速构建 ETL 与数据共享模式；权限管理可在表/列层面控制访问。 
  - 注册 S3 数据位置并管理元数据、数据加密与访问策略，简化跨团队数据共享。 

- 安全与治理：
  - 使用 Lake Formation 策略对数据进行授权，结合 IAM 和 KMS 实现端到端安全与审计。 

## 自测问题

- Lake Formation 相比仅使用 Glue Catalog 的优势是什么？
- 如何使用 Lake Formation 实现列级别数据访问控制？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
