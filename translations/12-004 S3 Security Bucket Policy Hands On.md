---
source: 12 - Amazon S3 Introduction\004 S3 Security Bucket Policy Hands On_zh.srt
---

# S3 Bucket 策略 - 实操步骤（概览）

## 学习目标
- 熟悉通过控制台将 Bucket 设置为对外公开的基本步骤
- 能用策略生成器快速构建一个允许 Public Read 的 Bucket 策略
- 理解公开访问的风险与防护措施

## 重点速览
- 启用静态公开访问前须评估风险并谨慎操作
- 使用策略生成器可快速生成 GetObject 的公开读取策略
- 记得配合“阻止公共访问”设置检查最终效果

## 步骤概述（实操流程）
1. 进入目标 Bucket 的 `Permissions`（权限）选项卡
2. 若启用了 Block Public Access，确认并在确知风险后按需解除相应阻止项
3. 在 Bucket policy 区域使用“Policy generator”或手工编辑策略
	- 示例资源 ARN 格式：`arn:aws:s3:::your-bucket-name/*`（注意末尾的 `/ *` 表示对象）
	- Action 选择 `s3:GetObject`，Effect 选择 `Allow`，Principal 可设为 `*`（对外公开）
4. 保存策略并在 `Access` 或 `Permissions` 中检查对象访问状态（UI 会显示是否“Public”）
5. 通过对象的公共 URL 验证文件可被外部访问

## 风险与建议
- 公开 Bucket 会导致任何人读取其对象，请避免对敏感或公司数据做公开策略
- 优先使用最小权限原则与时间限制策略（若需要临时公开可用 pre-signed URL）

## 自测问题
- 为什么要在生成策略前检查并理解 Block Public Access 的设置？
- 如果只想临时共享单个对象，除了公开 Bucket，还有什么替代方案？
