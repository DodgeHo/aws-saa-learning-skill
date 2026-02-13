## 学习目标

- 实操创建 VPC Endpoint（Interface/Gateway）并验证通过私有网络访问 AWS 服务。

## 重点速览

- VPC Endpoint（Gateway 用于 S3/DynamoDB，Interface 用于其他服务）允许私有子网直接访问 AWS 服务，无需公网流量。

## 详细内容

1. 步骤：选择服务类型 -> 创建 Endpoint -> 配置子网与安全组（Interface）或路由表（Gateway）-> 验证私有实例访问。
2. 优点：提高安全性（无公网）、降低数据外溢风险；注意 IAM 组件与策略控制访问。

## 自测问题

1. Gateway Endpoint 与 Interface Endpoint 的主要区别是什么？
2. 在什么场景下建议使用 VPC Endpoint？
