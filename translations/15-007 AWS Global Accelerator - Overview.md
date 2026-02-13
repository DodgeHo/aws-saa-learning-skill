## 学习目标

- 理解 AWS Global Accelerator 的作用、工作原理（Anycast/任播 IP）及与 CloudFront 的差异。
- 能说明 Global Accelerator 在多区域部署、故障切换与网络路径优化中的优势与典型用例。

## 重点速览

- Global Accelerator 为应用提供两个全球静态任播 IP，将用户流量路由到最近的边缘节点并通过 AWS 全球骨干网络传输至后端终端（如 ALB、NLB、EC2 或弹性 IP）。
- 与 CloudFront 不同，Global Accelerator 不做边缘缓存，适用于需要全局静态 IP、低延迟 TCP/UDP 加速或确定性故障切换的场景（如游戏、VoIP、全球 API）。

## 详细内容

1. 工作原理
- 使用 Anycast（任播）IP，用户连接到最近的边缘位置，流量在 AWS 的全球网络中被快速转发至运行中应用的区域终端。

2. 主要特点
- 提供两个静态任播 IP；自动执行健康检查并在终端或区域失效时快速切换；适用于 TCP/UDP 和需要静态 IP 的 HTTP 服务。

3. 场景对比
- CloudFront：适合缓存静态/可缓存内容并减轻源站负载；Global Accelerator：适合加速实时、非缓存流量和需要快速区域故障切换的应用。

## 自测问题

1. Global Accelerator 与 CloudFront 在用途上有何关键区别？
2. Global Accelerator 如何实现更快的故障切换与更低延迟？
