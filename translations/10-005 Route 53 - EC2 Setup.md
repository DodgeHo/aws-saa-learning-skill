---
source: 10 - Route 53\005 Route 53 - EC2 Setup_zh.srt
---

# Route 53 练习前置准备

## 学习目标
- 在多个区域部署 EC2 实例
- 创建一个 ALB 作为演示目标
- 验证实例与 ALB 可访问

## 重点速览
- 3 个区域各 1 台 EC2
- 统一用户数据脚本输出 Hello World
- 在一个区域创建 ALB 并绑定目标组

## 详细内容
创建 EC2 实例（3 个区域）：
1. 选择 Amazon Linux 2、`t2.micro`。
2. 安全组放行 `HTTP/SSH`。
3. 在用户数据中粘贴 Web 服务器脚本。
4. 在不同区域重复（如 eu-central-1、us-east-1、ap-southeast-1）。

创建 ALB（单一区域）：
1. 新建 **Application Load Balancer**（Internet-facing）。
2. 选择多个子网映射。
3. 安全组放行 `HTTP`。
4. 创建目标组并注册实例。

验证：
- 访问每台实例公网 IP，确认输出区域标识。
- 访问 ALB DNS，确认可正常返回。

## 自测问题
- 为什么要在多个区域部署实例？
- ALB 目标组与实例之间是什么关系？
