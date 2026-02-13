## 学习目标

- 理解 AWS Direct Connect 的优势、Direct Connect Gateway 的作用以及与 VPC 的互联方式。

## 重点速览

- Direct Connect 提供专线连接以降低网络延迟与带宽成本；Direct Connect Gateway 支持跨区域或多个 VPC 的连接集中管理。

## 详细内容

1. 优点：稳定、低延迟、可计费模型优于大流量 VPN；缺点：需要物理联通与前期安装时间与成本。
2. Direct Connect Gateway 用于在单个物理连接上访问多个 VPC（通过私有虚拟接口和 VGW 绑定）。

## 自测问题

1. 列出 Direct Connect 相比 VPN 的三个主要优势。
2. Direct Connect Gateway 在跨区域互联中能解决什么问题？
