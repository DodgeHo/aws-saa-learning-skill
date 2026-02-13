---
source: 14 - Amazon S3 Security\013 Glacier Vault Lock & S3 Object Lock_zh.srt
---

旁白：现在我们来谈谈S3冰川保险库锁｡ 

因此, 您需要锁定Glacier Vault以适应WORM模型｡

这意味着一次写入多次读取｡ 

这个想法是你拿一个物体, 你把它放进你的S3冰川保险库,

然后你锁定它,

这样它就永远不会被修改或删除｡

因此, 您需要在Glacier上创建一个Vault

## 学习目标

- 理解 Glacier Vault Lock 的 WORM 模型与 S3 Object Lock 的用途与差异。
- 掌握 S3 对象锁的两种保留模式（合规性/治理）与法律保全（Legal Hold）的基本行为与限制。

## 重点速览

- Glacier Vault Lock 提供 WORM（写一次读多次）机制：一旦锁定，Vault Lock policy 无法修改或删除，适合合规与数据保留。
- S3 Object Lock 在对象级别实现类似 WORM 功能，但需先启用版本控制；提供两种模式：Compliance（合规）与 Governance（治理）。
- Legal Hold 可对单个对象施加无限期保护，与保留期无关，可由具备 `s3:PutObjectLegalHold` 权限的用户设置/取消。

## 详细内容

1. Glacier Vault Lock（WORM）
- 在 Glacier 上创建 Vault Lock policy 并将策略锁定后，策略不能再被编辑或删除；此后写入到 Vault 的对象无法被修改或移除，适用于强合规需求。

2. S3 Object Lock
- 要使用 S3 Object Lock，必须先为桶启用版本控制；Object Lock 允许针对每个对象设置保留期，防止在保留期内删除或覆盖该对象版本。

3. 两种保留模式
- Compliance（合规）模式：最严格模式，任何用户（包括 root）均不能覆盖或删除受保护对象，保留期和保护不可缩短或取消。
- Governance（治理）模式：更灵活，普通用户受限，但具备特权的管理员通过恰当的 IAM 权限可以覆盖或删除对象。

4. Legal Hold（法律保全）
- Legal Hold 是对特定对象实施的无限期保护，独立于保留期，用于法律或审计需求；需要 `s3:PutObjectLegalHold` 权限的用户来设置或移除。

## 自测问题

1. Glacier Vault Lock 与 S3 Object Lock 在用途和粒度上有何不同？
2. S3 Object Lock 的 Compliance 模式与 Governance 模式有何关键区别？
3. 什么是 Legal Hold，它什么时候比保留期更合适？


让我们对它进行法律冻结｡ 

这样, 无论您以前在对象上设置了什么保留模式和保留期,

该对象都将受到永久保护｡

然后, 具有IAM权限S3 PutObjectLegalHold的用户可以选择获取任何对象并对其进行合法保留或删除它们｡

这是一种灵活的模式, 您可以说, 嘿, 当有人想在admin中保护一个对象时,

他们使用PutObjectLegalHold权限｡

例如, 一旦法律调查结束, 就会使用此PutObjectLegalHold

IAM权限再次将其删除｡

好吧, 我会的

因此, 您需要了解在测试中进行的S3对象锁的差异｡

所以我希望你喜欢｡ 

我们下节课再见｡
