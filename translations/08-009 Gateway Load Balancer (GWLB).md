---
source: 08 - High Availability and Scalability ELB & ASG\009 Gateway Load Balancer (GWLB)_zh.srt
---

# 网关负载均衡器（GWLB）

## 学习目标
- 了解 GWLB 的用途与协议层
- 理解“流量先检查再放行”的流程

## 重点速览
- 面向第三方安全设备（防火墙/IDS/IPS）
- 运行在三层，使用 GENEVE（端口 6081）
- 目标组支持实例或私有 IP

## 详细内容
GWLB 用于在 AWS 中部署和扩展网络安全设备：
- 让所有流量先经过安全设备，再进入应用
- 简化过去复杂的路由与分流流程

工作流程：
1. 用户流量先进入 GWLB
2. GWLB 将流量转发到安全设备目标组
3. 设备检查/处理后再返回 GWLB
4. GWLB 将合规流量送回应用

技术点：
- **协议层**：L3（IP 层）
- **封装协议**：GENEVE（端口 `6081`）
- **目标类型**：实例 ID 或私有 IP（含本地数据中心设备）

## 自测问题
- GWLB 与 ALB/NLB 的核心用途差异是什么？
- 为什么 GWLB 需要 GENEVE 协议？
