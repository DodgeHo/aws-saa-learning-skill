---
source: 05 - EC2 Fundamentals\008 How to SSH using Linux or Mac_zh.srt
---

# Linux/Mac 使用 SSH 连接 EC2

## 学习目标
- 使用 `ssh` 命令连接 EC2 实例
- 正确配置密钥文件权限
- 理解公共 IP 变化的影响

## 重点速览
- 安全组必须开放 22 端口
- 使用 `ec2-user` 登录 Amazon Linux 2
- `.pem` 权限需设置为只读

## 操作步骤
1. 确保安全组开放 SSH(22)。
2. 将下载的 `.pem` 文件放在易定位目录，避免文件名包含空格。
3. 进入该目录，确认文件存在：`ls`。
4. 设置权限：
```bash
chmod 0400 EC2Tutorial.pem
```
5. 连接实例：
```bash
ssh -i EC2Tutorial.pem ec2-user@<public-ip>
```
6. 首次连接提示信任时输入 `yes`。
7. 退出：`exit`。

## 注意事项
- 若 Stop/Start 实例，公共 IP 会变化，需要更新命令中的 IP。

## 自测问题
- 为什么必须执行 `chmod 0400`？
- Amazon Linux 2 默认登录用户名是什么？
