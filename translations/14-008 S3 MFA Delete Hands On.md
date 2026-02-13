---
source: 14 - Amazon S3 Security\008 S3 MFA Delete Hands On_zh.srt
---

教师：好的, 我们来演示一下MFA删除｡ 

我将创建一个桶, 并将其命名为demo

stephane MFA delete 2020（eu-west-1）｡

我将启用存储桶版本控制, 然后单击“创建存储桶”｡

好的, 很好｡ 

现在, 如果我们转到此存储桶（MFA存储桶）,

然后转到“属性”和“存储桶版本控制”, 然后单击“编辑”｡

正如您所看到的, 多因素身份验证（MFA）删除当前被禁用,

并且由于某些原因, 您无法通过Amazon控制台的UI更改此设置｡

所以也许有一天他们会允许我们启用它｡ 

但现在,

您需要做的是使用AWS

CLI直接启用它｡

因此, 本上机操作的先决条件是确保在IAM下,

您已经为root帐户设置了MFA设备｡

## 学习目标

- 学会使用 root 账户通过 CLI 启用/禁用 S3 的 MFA Delete 功能。
- 能配置并验证 MFA 设备 ARN、生成临时代码，并检查 MFA Delete 是否生效。

## 重点速览

- 控制台无法直接启用 MFA Delete，必须使用 root 账户和 AWS CLI 来完成。
- 操作流程：为 root 账户配置 MFA 设备 → 为该 root 创建临时访问密钥并配置专用 CLI profile → 使用指定的 MFA 设备 ARN 与验证码执行启用/禁用命令 → 在控制台核验结果。

## 详细内容（实操步骤）

1. 为 root 账户配置 MFA 设备
- 在 IAM 安全凭据下为 root 账户登记虚拟或硬件 MFA 设备，记录该设备的 ARN。

2. 创建并配置 CLI 凭证（仅用于此操作）
- 在 root 账户下创建新的访问密钥（Access Key ID & Secret），在本地使用 `aws configure --profile <name>` 配置一个专门的 profile（例如 `root-MFA-delete-demo`）。完成后应立即删除或停用这些密钥以减少风险。

3. 使用 CLI 启用 MFA Delete
- 通过 `put-bucket-versioning` 或相应命令，附带 `MFA` 参数（包含 MFA 设备 ARN 与当前验证码）来启用 MFA Delete。示例流程中需指定桶名与 MFA code。

4. 验证与测试
- 在控制台的存储桶版本控制页面刷新，确认显示 `MFA delete: Enabled`。
- 上传对象并尝试删除特定版本，将会在未提供 MFA 的情况下被拒绝；要永久删除版本需在 CLI 中提供正确的 MFA 验证。

5. 禁用 MFA Delete
- 禁用流程与启用相似，同样需要使用 root profile、设备 ARN 与验证码来执行对应的 CLI 命令。

6. 安全注意事项
- 谨慎使用 root 访问密钥：启用/禁用后应立即删除这些密钥以降低泄露风险。

## 自测问题

1. 为什么必须使用 root 账户来启用/禁用 MFA Delete？
2. 启用 MFA Delete 的 CLI 流程包含哪些关键参数？
3. 启用后如何验证 MFA Delete 已生效？
