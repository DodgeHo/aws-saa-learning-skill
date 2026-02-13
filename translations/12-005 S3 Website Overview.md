source: 12 - Amazon S3 Introduction\005 S3 Website Overview_zh.srt
---

# S3 静态网站托管概览

## 学习目标
- 了解如何用 S3 托管静态网站并访问网站端点
- 明白公开读取权限对静态网站的必要性与风险

## 重点速览
- S3 可托管静态网站（HTML/CSS/图片/JS）并提供网站端点 URL
- 网站端点格式与区域有关（域名略有差异）
- 必须确保对象可公开读取或由 Bucket 策略/CloudFront 提供访问，否则会出现 403 错误

## 详细内容
托管流程要点：
- 在目标 Bucket 中上传静态网站文件（如 index.html、图片等）
- 在 Bucket 属性中启用“静态网站托管”，并指定索引文档（例如 index.html）
- 若直接用 S3 网站端点，Bucket 必须允许公开读取（或使用 CloudFront + OAI 做更安全的发布）

端点与可访性：
- S3 网站端点是区域化的，语法上在不同区域会有小差别；若拿不到页面，请检查权限与端点 URL

安全建议：
- 若需更安全的分发，使用 CloudFront 与 OAI（Origin Access Identity）或签名 URL，避免直接公开 Bucket

## 自测问题
- 为什么直接启用 S3 静态网站托管时常见的错误是 403？
- 将静态网站放在 S3 上时，何时应该使用 CloudFront？
