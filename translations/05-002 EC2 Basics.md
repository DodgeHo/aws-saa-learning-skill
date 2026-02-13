---
source: 05 - EC2 Fundamentals\002 EC2 Basics_zh.srt
---

# EC2 基础概念

## 学习目标
- 了解 EC2 的核心定位与组成能力
- 理解实例选择时的关键参数
- 掌握 EC2 User Data 的用途与限制

## 重点速览
- EC2 = Elastic Compute Cloud，是 IaaS 的核心服务
- 你可选择操作系统、CPU、内存、存储与网络
- User Data 只在首次启动时运行

## 详细内容
EC2 是 AWS 最常用的服务之一，用于租用虚拟机（实例）。围绕 EC2 还有一系列配套能力：
- **EBS/EFS 存储**
- **弹性负载均衡（ELB）**
- **自动扩展（ASG）**

创建实例时需要做的关键选择包括：
- **操作系统**：Linux、Windows、macOS
- **计算规格**：vCPU、内存
- **存储**：EBS/EFS（网络存储）或实例存储（本地）
- **网络**：网卡性能与公有 IP
- **安全**：安全组规则
- **启动脚本**：EC2 User Data

EC2 User Data 是“引导脚本（bootstrapping）”，只在实例首次启动时执行一次。通常用于安装更新、软件、下载文件等自动化初始化任务。User Data 以 root 权限执行。

实例类型决定性能与成本。例如：
- `t2.micro`：1 vCPU、1 GiB 内存（免费层）
- `c5d.4xlarge`：高 CPU、高网络性能、带本地 NVMe
- `r5.16xlarge`：内存型实例

本课程的实操主要使用 `t2.micro`（免费层每月 750 小时）。

## 自测问题
- EC2 User Data 在实例生命周期中会执行几次？
- 选择实例类型时，哪些参数最关键？
