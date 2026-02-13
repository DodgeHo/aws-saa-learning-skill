```markdown
**学习目标**

- 理解 Amazon FSx 提供的四种主要文件系统及其典型用例：Windows File Server、Lustre、NetApp ONTAP、OpenZFS。
- 掌握性能、存储类型（SSD/HDD）与部署选项（临时/持久、多 AZ vs 单 AZ）的差异。

**重点速览**

- FSx for Windows File Server：托管 Windows 文件共享（SMB、NTFS、AD 集成、ACL）。
- FSx for Lustre：高性能分布式文件系统，适合 HPC / ML / 视频处理（高吞吐与低延迟）。
- FSx for NetApp ONTAP：适合需要 ONTAP 功能（快照、重复数据删除、即时克隆、NFS/SMB/iSCSI）的环境。
- FSx for OpenZFS：托管 ZFS，支持快照、压缩、即时克隆，高 IOPS 场景（不支持重复数据删除）。

**详细内容**

- Windows File Server：支持 SMB、与 Active Directory 集成、可配置为 Multi-AZ，适合企业级 Windows 文件共享与主目录迁移。
- Lustre：面向高性能、临时或持久部署；临时（staging）类型用于短期高性能处理，不复制数据但性能高；持久类型提供数据复制与更高可靠性，可与 S3 无缝集成用于数据入/出。
- NetApp ONTAP：提供企业级数据管理功能（压缩、重复数据删除、快照、时间点克隆），适合需要兼容 NetApp 的迁移与高级存储效率场景。
- OpenZFS：适合需要 ZFS 特性的场景，支持高吞吐与低延迟、快照与复制，但不提供重复数据删除功能。
- 部署与选择：根据操作系统兼容性、性能（IOPS/吞吐）、功能需求（AD、快照、数据效率）与成本选择相应 FSx 类型。

**自测问题**

1. 何时选择 FSx for Lustre 而不是 FSx for Windows File Server？
2. NetApp ONTAP 的主要优势有哪些？
3. 临时（staging）类型的 FSx for Lustre 有什么权衡？

```
