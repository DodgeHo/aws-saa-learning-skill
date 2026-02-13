---
source: 04 - IAM & AWS CLI\016 IAM Security Tools_zh.srt
---

# IAM 安全工具

## 学习目标
- 了解 IAM 凭据报告的用途
- 理解 IAM Access Advisor 的价值
- 将安全工具与最小权限原则关联

## 重点速览
- 凭据报告是账号级别的汇总视图
- Access Advisor 是用户级别的权限使用分析

## 详细内容
IAM 提供两类常用安全工具：

1. **IAM 凭据报告**（账号级别）：列出所有 IAM 用户及其凭据状态（例如是否启用密码、密钥使用情况等）。
2. **IAM Access Advisor**（用户级别）：显示用户被授予的服务权限以及最近访问时间，帮助识别“未使用的权限”。

利用 Access Advisor，可以回收不必要的权限，落实最小权限原则。下一节会演示具体使用方法。

## 自测问题
- 凭据报告是账号级还是用户级工具？
- Access Advisor 如何帮助最小权限落地？
