## 学习目标

- 通过实操掌握编写与部署 CloudFormation 模板的基本流程，并学会使用 Change Sets 与堆栈更新策略。

## 重点速览

- Hands On 包括编写一个简单的模板（如 VPC + 子网 + EC2）、创建变更集、执行更新并观察回滚行为。

## 详细内容

1. 步骤：编写模板 -> 使用 `aws cloudformation create-stack` 或通过控制台创建 -> 生成 Change Set -> 审查并执行。
2. 验证与回滚：触发失败时观察事件（Events）并理解回滚流程；使用堆栈策略避免关键资源被意外替换。

## 自测问题

1. 在 Hands On 中如何创建并应用 Change Set？
2. 如果某次更新导致资源损坏，应如何恢复之前的状态？
