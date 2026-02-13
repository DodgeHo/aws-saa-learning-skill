## 学习目标

- 理解 Site-to-Site VPN 的组成（Customer Gateway、Virtual Private Gateway）及其在混合云互联中的作用。

## 重点速览

- Site-to-Site VPN 通过 IPSec 隧道在本地网络与 AWS VPC 之间建立加密连接，涉及 Customer Gateway（本地）与 Virtual Private Gateway（AWS 端）。

## 详细内容

1. 配置流程：在 AWS 创建 Virtual Private Gateway -> 在本地创建 Customer Gateway（填写公网 IP 与 BGP 配置）-> 配置 VPN 连接并下载配置。
2. 注意点：带宽与性能受限于 ISP；可结合 Direct Connect 提供更稳定/低延迟连接；监控隧道状态与重新协商行为。

## 自测问题

1. 描述 Site-to-Site VPN 的典型配置步骤。
2. 何时建议将 VPN 与 Direct Connect 结合使用？
