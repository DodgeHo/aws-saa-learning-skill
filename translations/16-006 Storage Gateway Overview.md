```markdown
**学习目标**

- 理解 AWS Storage Gateway 的定位：作为本地数据与 AWS 云存储之间的桥梁。
- 掌握四种网关类型（S3 文件网关、FSx 文件网关、卷网关、磁带网关）的用途与差异。

**重点速览**

- S3 文件网关：通过 NFS/SMB 暴露 S3 对象；本地缓存近期对象以降低延迟。
- FSx 文件网关：提供对 Amazon FSx for Windows File Server 的本地缓存访问（SMB）。
- 卷网关（Volume Gateway）：通过 iSCSI 暴露块卷，支持缓存卷（cached）与存储卷（stored）两种模式，并通过 EBS 快照备份到 S3。
- 磁带网关（Tape Gateway）：虚拟磁带库（VTL），将传统磁带备份工作流连接到 S3/Glacier。

**详细内容**

- 部署方式：可以在内部虚拟化平台（VMware/Hyper-V/KVM）或在 EC2 上部署，也可订购 Storage Gateway 硬件设备用于没有虚拟化的小型数据中心。
- S3 文件网关：适合将本地文件共享透明映射到 S3，支持多种 S3 存储类（除 Glacier），并可通过生命周期策略归档到 Glacier。
- 卷网关：
  - Cached：将热数据缓存在本地，主数据保留在 S3，适合扩展到云备份并低延迟访问近期数据。
  - Stored：整个数据集保存在本地并按计划备份到 S3，适合本地优先的场景。
- 磁带网关：兼容现有备份软件，备份至 S3 并可转换到 Glacier/Deep Archive，用于长期归档。

**自测问题**

1. S3 文件网关如何对本地应用透明提供对象存储？
2. 卷网关的 cached 与 stored 模式有何不同？
3. 磁带网关解决了哪类传统备份痛点？

```
