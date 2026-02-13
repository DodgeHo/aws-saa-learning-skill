---
source: 05 - EC2 Fundamentals\013 EC2 Instance Roles Demo_zh.srt
---

# EC2 实例角色实操

## 学习目标
- 理解为何不要在实例中配置长期密钥
- 为 EC2 实例附加 IAM 角色并验证权限

## 重点速览
- 禁止在实例中运行 `aws configure` 填写访问密钥
- 用 IAM 角色为实例提供临时凭据

## 详细内容
连接到 EC2 实例后运行 `aws iam list-users` 会提示缺少凭据。虽然可以用 `aws configure` 配置 Access Key，但这会把长期密钥留在实例上，属于高风险做法。

正确方式是为实例附加 **IAM 角色**。在实例页面选择 **Actions → Security → Modify IAM Role**，选中 `DemoRoleForEC2` 并保存。随后再执行 `aws iam list-users` 会得到正常输出。

如果从角色上移除策略，命令会返回 `AccessDenied`。重新附加后可能需要等待权限传播，再次执行即可成功。

## 自测问题
- 为什么不应在 EC2 实例上使用 `aws configure`？
- IAM 角色如何让实例获取凭据？
