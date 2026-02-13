---
source: 11 - Classic Solutions Architecture Discussions\005 Instantiating applications quickly_zh.srt
---

解说员：这是一个关于快速实例化应用程序的简短讲座｡

## 学习目标
- 理解快速启动 EC2 的常见方法
- 区分 Golden AMI 与 EC2 用户数据的作用
- 知道 RDS/EBS 快照在加速部署中的用途

## 重点速览
- Golden AMI 是最快的启动方式
- 用户数据适合做少量动态配置
- RDS/EBS 快照可加速数据初始化

## 详细内容
为什么需要加速：
- 传统流程要安装依赖、恢复数据、配置环境，耗时长

核心手段：
- Golden AMI：预装依赖与应用，直接从镜像启动
- EC2 用户数据：启动时做动态配置，例如拉取数据库地址/密码
- 组合用法：Golden AMI + 少量用户数据

数据层加速：
- RDS 快照恢复：数据库直接带好结构和数据
- EBS 快照恢复：卷已格式化并含数据

常见服务：
- Elastic Beanstalk 也会使用 AMI + 用户数据的混合方式

## 自测问题
- 为什么 Golden AMI 比仅用用户数据更快？
- RDS 快照恢复在启动阶段解决了什么问题？
