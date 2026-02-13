---
source: 04 - IAM & AWS CLI\008 AWS CLI Setup on Windows_zh.srt
---

# Windows 安装 AWS CLI

## 学习目标
- 完成 Windows 上 AWS CLI v2 安装
- 验证安装是否成功
- 了解升级方式

## 重点速览
- 建议安装 AWS CLI v2（性能与安装体验更好）
- 使用 MSI 安装程序最简单
- 用 `aws --version` 验证安装

## 详细内容
在浏览器搜索 AWS CLI，选择 Windows 上的 AWS CLI v2 安装指引。下载 MSI 安装程序后运行，按向导完成安装即可。

安装完成后打开命令提示符，运行 `aws --version`。如果看到 `aws-cli/2.x.x`、Python 版本与 Windows 平台信息，说明安装成功。

升级时只需重新下载 MSI 并运行即可自动覆盖升级。

## 自测问题
- 如何验证 AWS CLI 是否安装成功？
- Windows 上升级 AWS CLI 的方法是什么？
