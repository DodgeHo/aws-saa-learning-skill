## 学习目标

- 能在控制台为私有 S3 桶创建 CloudFront 分发并通过 Origin Access Control (OAC) 保护原点。
- 会验证分发部署后通过 CloudFront 访问静态网站资源且不将 S3 对象公开。

## 重点速览

- 使用 CloudFront 分发私有 S3 对象的常见流程：创建 S3 桶并上传资源 → 在 CloudFront 创建分发并选择原点 → 使用 OAC（或旧 OAI）配置原点访问 → 更新 S3 桶策略以允许 CloudFront 访问。
- CloudFront 为分发分配域名，首次请求会从原点拉取并缓存资源，后续请求由边缘节点提供，提升响应速度。

## 详细步骤要点

1. 准备 S3 原点
- 创建 S3 桶并上传 `index.html`、图片等资源；保持对象私有以演示通过 CloudFront 访问的场景。

2. 在 CloudFront 创建分发
- 在 CloudFront 创建分发时选择 S3 桶为原点，并创建/分配 Origin Access Control (OAC)；OAC 会在分发与 S3 之间建立受控访问。

3. 更新 S3 桶策略
- CloudFront 创建分发后，复制生成的桶策略并粘贴到 S3 桶策略区域，从而允许 CloudFront 代表分发读取 S3 对象。

4. 部署与验证
- 等待分发部署完毕，复制 CloudFront 域名并打开页面；观察资源（index、image）是否通过 CloudFront 加载并加速响应。

## 自测问题

1. 为何需要 Origin Access Control？如何在 S3 桶策略中允许 CloudFront 访问？
2. CloudFront 首次请求与后续请求在原点和边缘之间如何交互？
3. 如何验证某个对象是通过 CloudFront 缓存而不是直接从 S3 获取的？
