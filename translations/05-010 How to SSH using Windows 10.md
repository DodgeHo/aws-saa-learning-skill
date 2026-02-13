---
source: 05 - EC2 Fundamentals\010 How to SSH using Windows 10_zh.srt
---

# Windows 10 使用 SSH 连接 EC2

## 学习目标
- 在 Windows 10 上使用内置 SSH
- 处理 `.pem` 权限问题
- 成功登录并退出实例

## 重点速览
- PowerShell 或 CMD 都可用 `ssh`
- 密钥文件需放在当前目录
- 权限异常时需修改文件安全设置

## 操作步骤
1. 在 PowerShell 运行 `ssh`，确认命令可用。
2. `cd` 到 `.pem` 文件所在目录（如 Desktop）。
3. 执行连接命令：
```powershell
ssh -i EC2Tutorial.pem ec2-user@<public-ip>
```
4. 首次连接提示信任时输入 `yes`。
5. 退出：`exit` 或 `Ctrl+D`。

## 权限问题修复
若提示密钥权限问题：右键 `.pem` → 属性 → 安全 → 高级：
- 将“所有者”改为当前用户
- 禁用继承并移除其他主体权限
- 仅保留当前用户完全控制

## 自测问题
- Windows 10 连接 EC2 使用的命令是什么？
- 出现权限报错时应该修改哪里？
