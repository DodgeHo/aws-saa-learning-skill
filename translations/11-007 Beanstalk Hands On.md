---
source: 11 - Classic Solutions Architecture Discussions\007 Beanstalk Hands On_zh.srt
---

教练：好的, 让我们继续练习使用Beanstalk服务｡

## 学习目标
- 熟悉 Beanstalk 创建应用与环境的流程
- 理解 IAM 服务角色与实例配置文件的作用
- 了解 Beanstalk 与 CloudFormation 的关系

## 重点速览
- 选择环境类型：Web 或 Worker
- 创建应用与环境，选择平台与示例代码
- 配置服务角色与 EC2 实例配置文件

## 详细内容
创建应用：
- 进入 Elastic Beanstalk 控制台
- 选择 Web 服务器环境
- 创建应用，例如 MyApplication
- 环境命名，例如 MyApplication-dev

选择平台与代码：
- 选择平台（如 Node.js）
- 选择示例应用或上传代码

预设与权限：
- 预设选择单实例（开发友好）
- 创建 Beanstalk 服务角色
- 手动创建 EC2 实例配置文件并绑定权限策略

创建环境后可观察：
- Events 显示由 CloudFormation 创建资源
- EC2 实例、弹性 IP、Auto Scaling group 自动生成
- 通过域名访问示例应用

后续操作：
- 上传新版本并部署
- 查看健康状态、日志和监控
- 管理配置与创建多环境（dev/prod）

## 自测问题
- 为什么需要配置服务角色与实例配置文件？
- Beanstalk 创建资源时依赖的底层服务是什么？
