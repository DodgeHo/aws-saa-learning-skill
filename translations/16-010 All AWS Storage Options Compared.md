```markdown
**学习目标**

- 快速区分 AWS 的主要存储选项（S3/Glacier、EBS、实例存储、EFS、FSx、Storage Gateway、DataSync、Snow Family、Transfer Family）。
- 根据访问模式、性能需求、持久性与成本选择合适的存储服务。

**重点速览**

- S3：对象存储，灵活的存储类用于不同冷热数据；适合大规模对象与静态内容分发。
- Glacier / Glacier Deep Archive：长期归档与低成本检索延迟选择。
- EBS：块存储，附加到 EC2，提供高 IOPS；适合数据库与持久块卷需求。
- EC2 实例存储：本地临时块，适合临时高性能缓存（非持久）。
- EFS：分布式 POSIX 文件系统，跨实例共享，适合 Linux 文件共享。
- FSx：托管第三方文件系统（Windows、Lustre、NetApp、OpenZFS），用于特殊文件系统需求。
- Storage Gateway：本地与云之间的桥梁（S3 文件网关、FSx 文件网关、卷网关、磁带网关）。
- DataSync：在线文件/对象/存储之间的高效数据传输与同步服务。
- Snow Family：物理设备用于脱机迁移与边缘计算（Snowcone/Snowball/Snowmobile）。
- Transfer Family：为 S3/EFS 提供 FTP/FTPS/SFTP 访问接口。

**详细内容**

- 选择指南（简化版）：
  - 需要对象 API 和可扩展静态存储 → S3。
  - 长期归档且可接受检索延迟 → Glacier/Deep Archive（通过 S3 生命周期管理）。
  - 需要块级、低延迟、与 EC2 紧耦合存储 → EBS。
  - 需要跨实例共享的 POSIX 文件系统 → EFS。
  - 需要 Windows 原生共享或高性能并行文件系统 → FSx（选择对应子类型）。
  - 本地与云之间需透明桥接或备份旧流程 → Storage Gateway（选择对应类型）。
  - 大量数据但网络受限 → Snow Family（离线运输）或 DataSync（在线高效传输）。
  - 需要为传统 FTP/SFTP 客户端提供对 S3/EFS 的访问 → Transfer Family。

**自测问题**

1. 你会为需要跨多个 Linux EC2 实例共享的应用选择哪种存储？为什么？
2. 如果要将大量冷归档对象从 S3 移到更低成本层，应使用什么机制？
3. 在网络带宽受限且要迁移 100 TB 数据时，你会选择哪个解决方案？

```
