```markdown
**学习目标**

- 理解 AWS Snow Family 的两大用例：离线数据迁移与边缘计算。
- 区分 Snowcone、Snowball Edge、Snowmobile 的容量与典型场景。
- 了解请求设备、传输数据到 S3 的基本流程与安全/运维要点（OpsHub、DataSync）。

**重点速览**

- Snowcone：小型便携（8TB HDD / 14TB SSD），适合受限空间与边缘采集。
- Snowball Edge：中型设备（Storage/Compute 两种类型），适合 TB–PB 级迁移与边缘计算。
- Snowmobile：卡车级传输，适合 PB–EB 级大规模迁移（每辆约 100 PB）。
- 经验法则：若网络传输需 >1 周，考虑使用 Snow 设备；Snowcone 可本地运行 DataSync 或直接运输回 AWS。

**详细内容**

- 用例：数据迁移（物理运输设备到 AWS 并导入 S3）与边缘计算（在没有稳定网络的现场近源处理数据）。
- 设备对比与容量：Snowcone（便携，边缘场景），Snowball Edge（Storage Optimized ~80TB / Compute Optimized 若做本地计算），Snowmobile（100+ PB，适合极大规模迁移）。
- 现场计算：Snowball Edge 和 Snowcone 可运行 EC2 实例与 Lambda（通过 IoT Greengrass），并可选 GPU/更高 vCPU。存储群集可扩展节点以提高容量。
- 运维与安全：通过控制台请求设备，使用 OpsHub 管理解锁与传输，设备返还后 AWS 将数据导入目标 S3 桶并按最高安全标准擦除设备。

**自测问题**

1. 何时应选择 Snowmobile 而不是 Snowball？
2. Snowcone 在哪些场景优于 Snowball Edge？
3. 描述将数据通过 Snowball 导入 S3 的基本流程与安全注意点。

```
