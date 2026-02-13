---
source: 05 - EC2 Fundamentals\007 SSH Overview_zh.srt
---

# SSH 连接方式概览

## 学习目标
- 了解不同操作系统的 SSH 连接方案
- 知道 EC2 Instance Connect 的定位
- 明白常见故障来源

## 重点速览
- Mac/Linux/Windows 10+ 可直接用 SSH 命令
- Windows 7/8 推荐 PuTTY
- EC2 Instance Connect 通过浏览器连接

## 详细内容
连接 Linux EC2 实例的方式取决于你的操作系统：
- **Mac/Linux/Windows 10+**：使用内置 `ssh` 命令。
- **Windows 7/8**：使用 PuTTY（功能等同 SSH）。
- **EC2 Instance Connect**：浏览器内直接连接，无需本地 SSH 配置。

如果你不熟悉命令行，EC2 Instance Connect 是最简单的选择。

常见 SSH 失败原因包括：安全组未开放 22 端口、IP 写错、命令拼写错误或密钥权限问题。课程后续会有针对不同系统的详细步骤与排错指南。

## 自测问题
- Windows 7/8 使用什么工具连接 EC2？
- EC2 Instance Connect 最大的优势是什么？
