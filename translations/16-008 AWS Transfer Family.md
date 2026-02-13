```markdown
**学习目标**

- 了解 AWS Transfer Family 提供的协议（FTP / FTPS / SFTP）及其与 S3/EFS 的集成方式。
- 掌握身份验证选项与计费要点，识别适用场景（向非 AWS 客户提供传统协议访问）。

**重点速览**

- 支持协议：FTP（不加密）、FTPS（基于 SSL 的加密）、SFTP（基于 SSH 的加密）。
- 可将传入的文件直接写入 Amazon S3 或 EFS；端点为完全托管，按端点小时计费 + 数据传输（GB）计费。
- 身份验证：可在服务中托管凭据，或与 Active Directory / LDAP / Okta / Amazon Cognito / 自定义源 集成。

**详细内容**

- 用例：希望用传统文件传输协议（FTP/SFTP/FTPS）向合作伙伴或内部系统暴露 S3/EFS 存储，而不改造客户端代码或协议栈。
- 端点与主机名：可以直接使用托管端点，也可配合 Route 53 提供自定义主机名与 DNS 入口。
- 安全与认证：推荐使用 SFTP/FTPS 以保证传输加密；认证可委托外部 IdP（如 AD/LDAP/Okta）或使用 Transfer Family 自带的用户管理功能。
- 计费模型：按端点小时数计费，外加按传入/传出数据量计费（注意跨区域流量费用）。

**自测问题**

1. Transfer Family 支持哪三种协议？它们的加密特性如何？
2. 想把外部合作伙伴通过 SFTP 上传的数据写入 S3，应如何选择身份验证方式？

```
