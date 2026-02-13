---
source: 04 - IAM & AWS CLI\011 AWS CLI Hands On_zh.srt
---

# AWS CLI 实操：访问密钥与配置

## 学习目标
- 创建访问密钥并理解其使用场景
- 使用 `aws configure` 完成 CLI 配置
- 观察权限变更对 CLI 的影响

## 重点速览
- 访问密钥只会显示一次，务必保存
- CLI 权限与控制台权限一致
- 推荐了解 CloudShell 与 IAM Identity Center 的替代方式

## 详细内容
在 IAM 用户的“安全凭证”中创建访问密钥。创建时 AWS 会提示更安全的替代方式（如 CloudShell 或 IAM Identity Center）。为了理解访问密钥原理，本节选择继续创建。注意：访问密钥与秘密访问密钥仅在创建时展示一次。

接下来在本地配置 CLI，执行 `aws configure`，依次输入 Access Key ID、Secret Access Key、默认区域（例如 `eu-west-1`）与输出格式。完成后执行 `aws iam list-users` 验证。

随后演示权限变化：将用户从管理员组移除后，无论在控制台还是 CLI 执行 `iam list-users` 都会返回权限不足。这说明 CLI 权限完全遵循 IAM 授权。

最后将用户添加回管理员组恢复权限。

## 自测问题
- 访问密钥的显示机会有几次？
- 为什么 CLI 的权限结果与控制台一致？
