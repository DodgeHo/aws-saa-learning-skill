source: 12 - Amazon S3 Introduction\003 S3 Security Bucket Policy_zh.srt
---

# S3 安全：Bucket 策略与访问控制

## 学习目标
- 区分基于身份（IAM）与基于资源（Bucket 策略）的权限模型
- 理解对象 ACL、Bucket 策略与“阻止公共访问”设置的作用与优先级
- 掌握跨账户访问与对公开访问的防护方法

## 重点速览
- IAM 策略（基于身份）与 Bucket 策略（基于资源）可叠加，共同决定访问权限
- 对象 ACL 较少使用，可在需要时启用；推荐用 Bucket 策略或 IAM 策略管理权限
- “阻止公共访问”（Block Public Access）是额外的保护层，可覆盖 Bucket 策略以防数据泄露

## 详细内容
权限判定原则：若 IAM 权限或资源策略允许且无显式拒绝，则主体可执行对应 API。

Bucket 策略：
- 基于 JSON 的资源策略，可为整个 Bucket 或特定前缀/对象授予或拒绝权限
- 常见用途：公开读取、跨账户访问、上传时强制加密等
- 策略字段：Principal（主体）、Action（API，如 GetObject）、Resource（ARN，例如 arn:aws:s3:::bucket-name/*）、Effect（Allow/Deny）

对象 ACL：更细粒度但较少使用，可为单个对象设定额外权限；企业多采用 ACL 禁用策略并用 Bucket 策略替代

跨账户访问：若需允许其他 AWS 账户或账户内的 IAM 用户访问，通常在目标 Bucket 上配置 Bucket 策略授权特定 Principal

阻止公共访问：
- 可在 Bucket 或账户层启用作为“保险”，即使策略允许公共访问也会被阻断
- 若业务确实需要公共访问，需谨慎关闭相应阻止项并评估风险

## 自测问题
- IAM 策略与 Bucket 策略冲突时如何决策？
- 为什么推荐使用 Bucket 策略而非对象 ACL 来实现跨账户访问？
- “阻止公共访问”打开后会阻止哪些行为？
