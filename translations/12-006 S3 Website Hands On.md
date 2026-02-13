---
source: 12 - Amazon S3 Introduction\006 S3 Website Hands On_zh.srt
---

# S3 静态网站托管 - 实操要点

## 学习目标
- 掌握将 S3 Bucket 配置为静态网站端点的基本流程
- 能上传索引文档并验证网站可访问性

## 重点速览
- 需启用静态网站托管并指定索引文档（如 index.html）
- Bucket 对象必须可公开读取，或通过 CloudFront/OAI 提供访问

## 实操步骤
1. 在目标 Bucket 上传静态资源（如 index.html、图片等）
2. 打开 Bucket 的 `Properties`（属性），找到“Static website hosting”（静态网站托管）并编辑启用
3. 在配置中填写索引文档名（例如 `index.html`）并保存
4. 如果提示需要公共访问，确认并按需开放读取权限（或选择更安全的 CloudFront 分发）
5. 启用后控制台会显示网站端点，复制并在浏览器中访问以验证页面与静态资源（图片）是否加载

## 小提示
- 若访问出现 403，请检查对象与 Bucket 的公开读取权限或 Block Public Access 设置
- 推荐使用 CloudFront + OAI 以避免直接公开 Bucket

## 自测问题
- 启用静态网站托管后仍出现 403，最可能的原因是什么？
- 为什么建议使用 CloudFront 而不是直接公开 S3 Bucket？
