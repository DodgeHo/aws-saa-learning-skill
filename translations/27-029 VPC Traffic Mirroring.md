## 学习目标

- 理解 VPC Traffic Mirroring 的用途、限制与典型监控/安全场景。

## 重点速览

- VPC Traffic Mirroring 能复制网络包并发送到监控/IDS 节点，用于深度包检测、故障排查与安全分析。

## 详细内容

1. 限制：支持特定实例类型、可能引入额外带宽与处理成本；需规划镜像目标与过滤规则以减少负载。
2. 应用场景：入侵检测、流量审计、性能排查；与 VPC Flow Logs 补充使用以获取更多细节。

## 自测问题

1. 列出部署 Traffic Mirroring 时需要考虑的三个性能/成本因素。
2. 为什么 Traffic Mirroring 不能完全替代 VPC Flow Logs？
