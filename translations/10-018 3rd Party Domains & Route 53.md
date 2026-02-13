---
source: 10 - Route 53\018 3rd Party Domains & Route 53_zh.srt
---

# 第三方域名与 Route 53

## 学习目标
- 区分域名注册商与 DNS 服务
- 掌握第三方域名接入 Route 53 的流程

## 重点速览
- 域名可在任意注册商购买
- DNS 可由 Route 53 托管
- 关键是更新 NS 记录

## 详细内容
角色区分：
- **注册商**：负责域名注册与续费
- **DNS 服务**：负责域名解析记录

第三方域名接入 Route 53：
1. 在 Route 53 创建 **Public Hosted Zone**。
2. 获取该托管区域的 4 个名称服务器。
3. 回到注册商（如 GoDaddy）修改 **NS** 记录为 Route 53 名称服务器。

结果：
- 域名注册在第三方
- DNS 解析由 Route 53 管理

## 自测问题
- NS 记录的作用是什么？
- 为什么注册商和 DNS 服务可以分开使用？
