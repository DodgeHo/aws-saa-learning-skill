## 学习目标

- 掌握将大规模数据迁移到 AWS 的常见方法、工具与成本/性能权衡。

## 重点速览

- 常用方法包括网络传输（VPN/Direct Connect）、物理传输（AWS Snowball/Snowmobile）以及并行化传输工具（S3 Multipart、DataSync）。

## 详细内容

1. 小到中等数据量：使用网络传输或 AWS DataSync；大规模离线迁移：使用 Snowball/Snowmobile 等物理设备以降低时间与成本。
2. 考量点：带宽与传输时间、加密与合规、传输过程中数据完整性验证、目标存储（S3、EFS、Glacier）的选择。

## 自测问题

1. 在什么场景下应优先考虑使用 AWS Snowball 而非直接网络传输？
2. 描述使用 S3 Multipart 上传大文件的好处。
