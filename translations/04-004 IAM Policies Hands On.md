---
source: 04 - IAM & AWS CLI\004 IAM Policies Hands On_zh.srt
---

# IAM 策略实操

## 学习目标
- 通过实操理解权限继承与访问控制
- 识别“只读”与“管理员”权限差异
- 学会创建与验证自定义策略

## 重点速览
- 从管理员组移除用户会立刻失去权限
- `ReadOnlyAccess` 只能读取，不能创建资源
- `Action: *` + `Resource: *` 等同管理员权限

## 详细内容
演示开始时，用户 Stephane 属于管理员组，因此拥有完全权限。将 Stephane 从管理员组移除后，刷新页面会看到 `AccessDenied`，无法再列出用户。

要恢复最小权限访问，我们给 Stephane 直接附加 `IAMReadOnlyAccess`。此时可以查看用户和组，但无法创建新组，证明“只读”权限不包含写操作。

随后创建一个 `developers` 组并附加任意策略（示例使用 `AlexaForBusiness`），再把 Stephane 加回管理员组。此时用户拥有三类权限来源：
- 通过 `admin` 组继承的管理员权限
- 通过 `developers` 组继承的策略
- 直接附加的 `IAMReadOnlyAccess`

接着查看 `AdministratorAccess` 的 JSON，可以看到 `Action: *` 与 `Resource: *`，表示对任何资源执行任何操作，即管理员权限。

查看 `IAMReadOnlyAccess` 的 JSON 会看到 `Get*` 与 `List*` 的通配方式，代表所有以 Get/List 开头的读操作。

最后演示了创建自定义策略：使用可视化编辑器只允许 `iam:ListUsers` 与 `iam:GetUser`，生成策略并可附加给用户或组。实操结束后清理临时组与策略，恢复到仅管理员组的状态。

## 自测问题
- 为什么移除管理员组后会立刻无法 `ListUsers`？
- `ReadOnlyAccess` 能否创建组？为什么？
- `Action: *` + `Resource: *` 表示什么权限？
