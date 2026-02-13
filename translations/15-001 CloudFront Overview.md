## 学习目标

- 理解 Amazon CloudFront 的核心概念：作为 CDN（内容分发网络）如何通过边缘缓存提升全球读取性能。
- 能描述 CloudFront 的常见原点类型（S3、HTTP 后端、ALB/EC2）及与 S3 的集成要点（OAC/OAI、源访问控制）。

## 重点速览

- CloudFront 通过全球边缘位置缓存内容，降低延迟并改善用户体验。
- CloudFront 可与 AWS Shield/WAF 集成，增强 DDoS 与应用层防护。
- CloudFront 是 CDN（缓存分发），与 S3 跨区域复制（数据复制）在用途上不同。

## 详细内容

1. 工作原理
- 客户端请求命中最近边缘位置；若缓存未命中，边缘从原点（S3、ALB、EC2 或自定义 HTTP 源）拉取数据并缓存，后续请求由边缘直接响应。

2. 常见原点与访问控制
- 原点可以是私有 S3（推荐使用 Origin Access Control/OAC）、S3 静态网站、ALB、EC2 或任意 HTTP 源。为保护私有 S3，应使用 OAC（取代旧的 OAI）并更新桶策略。

3. 与 S3 跨区域复制的对比
- CloudFront 用于全球缓存与加速；S3 跨区域复制则在指定区域之间复制对象副本用于驻留或灾备，两者侧重点不同。

4. 额外注意项
- 缓存策略（TTL、缓存键等）与失效机制会影响内容一致性与刷新策略；CloudFront 的边缘分发也能减轻源站的 DDoS 风险。

## 自测问题

1. CloudFront 如何加速全球用户访问私有 S3 对象？
2. 什么是 Origin Access Control（OAC），它解决了什么问题？
3. 何时选择 CloudFront 而不是 S3 跨区域复制？
