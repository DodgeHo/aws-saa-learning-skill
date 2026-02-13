---
source: 12 - Amazon S3 Introduction\012 S3 Storage Classes Overview_zh.srt
---

# S3 存储类概览

## 学习目标
- 了解主要 S3 存储类的用途与权衡（成本、可用性、检索延迟）
- 理解持久性与可用性之间的区别以及智能分层的作用

## 重点速览
- 所有 S3 存储类具有高耐久性（11 个 9），但可用性与冗余范围随类而变
- 常用类：Standard（频繁访问）、Standard-IA（不频繁访问）、One Zone-IA（单可用区）
- 归档类：Glacier Instant, Glacier Flexible Retrieval, Glacier Deep Archive（检索延迟/成本不同）
- S3 Intelligent-Tiering 自动在层间移动对象，适合访问模式不确定的场景

## 详细内容
- 耐久性（Durability）：表示对象长期保存不丢失的概率，S3 各类均为 99.999999999%（11 个 9）
- 可用性（Availability）：表示服务可用性的时间百分比（不同存储类有所差异）
- 主要比较点：访问频率、检索延迟、最低存储期限、单对象计费最小值、是否跨 AZ

各类示意：
- Standard：高可用、低延迟，适合热数据
- Standard-IA：较低存储成本，但有检索费用，适合备份/灾备
- One Zone-IA：仅存储在单 AZ，更低成本但无多 AZ 冗余，适合作为可重建数据的副本
- Glacier Instant / Flexible / Deep Archive：按检索速度分层，Deep Archive 成本最低但检索最慢
- Intelligent-Tiering：自动分层，无检索费用，但有监控与自动分层费用

## 自测问题
- 为什么 S3 的所有类具有相同的耐久性但不同的可用性？
- 在哪些场景下应优先选择 One Zone-IA？
