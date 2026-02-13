---
source: 04 - IAM & AWS CLI\010 AWS CLI Setup on Linux_zh.srt
---

# Linux 安装 AWS CLI

## 学习目标
- 在 Linux 上安装 AWS CLI v2
- 了解安装所需的关键命令
- 验证安装成功

## 重点速览
- 安装流程：下载 zip → 解压 → 运行安装脚本
- `aws --version` 用于验证

## 详细内容
在官方文档中选择 Linux 安装 AWS CLI v2，按步骤执行三条命令：
1. 下载安装包（zip）
2. 解压缩安装包
3. 使用 `sudo` 运行安装脚本

安装完成后，运行 `aws --version`（或完整路径 `/usr/local/bin/aws --version`）。如果显示 `aws-cli/2.x.x`、Python、Linux 与 Botocore 版本信息，说明安装成功。

## 自测问题
- Linux 安装 AWS CLI 的三步流程是什么？
- 若 `aws` 不在 PATH 中，应如何验证版本？
