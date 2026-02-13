## 学习目标

- 理解 AWS 网络相关费用构成并掌握常见的成本优化策略。

## 重点速览

- 成本项包括 NAT Gateway 流量费、Data Transfer（跨 AZ/Region/Internet）、Direct Connect 端口与传输、Transit Gateway 附加费用等。

## 详细内容

1. 常见高成本来源：大量跨 AZ 或跨区域数据传输、长期运行的 NAT Gateway、未优化的吞吐路径。
2. 优化策略：减少跨 AZ/Region 流量、使用 VPC Endpoint 降低公网流量、评估使用 Direct Connect 与 TGW 成本效益、按需关闭临时资源。

## 自测问题

1. 列举三种减少 VPC 网络费用的具体做法。
