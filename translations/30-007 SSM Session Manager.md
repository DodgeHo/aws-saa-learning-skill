## 学习目标

- 理解 AWS Systems Manager Session Manager 的功能、优势与实践场景。

## 重点速览

- Session Manager 提供无跳板机的安全远程终端访问，可通过 IAM 控制、审计会话并与 KMS 集成实现会话加密。

## 详细内容

1. 优点：无需公开 SSH 端口或维护 Bastion，支持会话记录、IAM 访问控制、以及与 CloudWatch/ S3 集成用于审计。
2. 配置要点：在实例上安装 SSM Agent 并配置 IAM 实例配置文件（Instance Profile），为需要的用户授予 `ssm:StartSession` 权限。

## 自测问题

1. 列出使用 Session Manager 替代 Bastion Host 的三个好处。
2. 描述如何启用会话记录以进行审计。

---

**补充资源**：课程术语与易错点汇总请见仓库根的 [GLOSSARY.md](../GLOSSARY.md) 与 [COMMON_MISTAKES.md](../COMMON_MISTAKES.md)。
