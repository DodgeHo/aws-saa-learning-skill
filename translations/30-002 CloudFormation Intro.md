## 学习目标

- 理解 AWS CloudFormation 的基本概念、模板结构与基础实践。

## 重点速览

- CloudFormation 通过模板定义基础设施为代码（IaC），支持资源声明、参数化、输出与栈管理，便于重复部署与版本控制。

## 详细内容

1. 模板格式支持 JSON 与 YAML，常见部分包括 `Parameters`、`Resources`、`Outputs`、`Mappings` 与 `Conditions`。
2. 部署模式：创建/更新栈（Stack），变更集（Change Sets）用于预览变更；建议与 CI/CD 集成并使用堆栈策略与服务角色控制权限。
3. 常见实践：使用模块化模板（Nested Stacks）、参数校验、输出导出（跨栈引用）、在变更时使用 Change Sets 防止意外停机。

## 自测问题

1. 描述 CloudFormation 模板的主要组成部分。
2. 什么是 Change Set，为什么在生产环境中推荐使用？
