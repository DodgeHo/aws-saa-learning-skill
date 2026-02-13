```markdown
**学习目标**

- 熟悉在控制台创建 Amazon FSx 文件系统时的关键配置项（文件系统类型、存储类型、部署选项、加密与 AD 集成）。
- 理解各选项对性能、可用性与成本的影响，便于答题时快速定位正确选项。

**重点速览**

- 创建时需选择文件系统类型（Lustre / Windows / NetApp ONTAP / OpenZFS）、部署模式（单 AZ / 多 AZ、临时 / 持久）、存储类型（SSD / HDD）、以及是否启用 AD 集成、备份与加密。
- Lustre 有临时与持久两种模式；Windows 支持 SMB 与 AD；NetApp/ OpenZFS 提供高级数据管理功能。

**详细内容**

- 控制台创建要点：
  - 选择正确的 FSx 类型来匹配工作负载（HPC → Lustre；Windows 共享 → FSx for Windows；企业级存储功能 → NetApp ONTAP；ZFS 兼容 → OpenZFS）。
  - 存储类型：SSD 用于 IOPS 密集型与低延迟场景，HDD 适用于吞吐量导向且成本敏感场景。
  - 部署与可用性：是否跨 AZ 部署（提高可用性但成本更高）；Lustre 的临时文件系统适合短期高性能处理，持久文件系统用于长期存储。
  - 目录服务/安全：Windows 文件服务器可与 AD 集成并使用 ACL；可启用加密与自动每日备份到 S3。

**自测问题**

1. 在创建 FSx 时，什么时候应选择 SSD 而不是 HDD？
2. 创建 FSx for Windows 时，为何需要考虑 AD 集成？
3. Lustre 的临时文件系统适合哪类处理流程？

```
