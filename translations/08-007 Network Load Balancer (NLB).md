---
source: 08 - High Availability and Scalability ELB & ASG\007 Network Load Balancer (NLB)_zh.srt
---

# 网络负载均衡器（NLB）

## 学习目标
- 了解 NLB 的协议层与适用场景
- 记住静态 IP 与高性能特性

## 重点速览
- 四层负载均衡：TCP/UDP/TLS
- 超高性能、低延迟
- 每个 AZ 可分配静态 IP（可用 EIP）

## 详细内容
NLB 特性：
- **协议层**：L4，适合 TCP/UDP
- **性能**：每秒百万级请求、低延迟
- **静态 IP**：每个 AZ 一个固定 IP，可绑定弹性 IP

目标组：
- 可以注册 **实例** 或 **私有 IP**
- 支持将自建数据中心的私有 IP 接入

组合使用：
- NLB 前置提供静态 IP
- 后端 ALB 处理 HTTP 路由规则

健康检查：支持 TCP/HTTP/HTTPS。

## 自测问题
- 什么时候必须使用 NLB 而不是 ALB？
- NLB 目标组支持哪两种注册类型？
