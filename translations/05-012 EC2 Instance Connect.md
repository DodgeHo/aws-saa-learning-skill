---
source: 05 - EC2 Fundamentals\012 EC2 Instance Connect_zh.srt
---

# EC2 Instance Connect

## 学习目标
- 使用浏览器连接 EC2 实例
- 了解其与 SSH 的关系
- 知道失败时的排查点

## 重点速览
- Instance Connect 会临时上传 SSH 密钥
- 仍需安全组开放 22 端口
- 可在任何操作系统上使用

## 详细内容
在 EC2 实例页面点击 **Connect**，选择 **EC2 Instance Connect**。该方式会自动上传临时 SSH 密钥，无需你管理本地密钥。默认用户名为 `ec2-user`（Amazon Linux 2）。

连接失败时，优先检查安全组是否允许 SSH(22)。如果使用 IPv6 网络环境，可能需要同时开放 IPv6 规则。

Instance Connect 依然基于 SSH，只是把终端放在浏览器中。

## 自测问题
- Instance Connect 是否仍然依赖 SSH？
- 连接失败最常见的安全组原因是什么？
