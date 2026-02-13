## 学习目标

- 理解 CloudFront 的地理限制（Geo Restriction）功能及常见用途。
- 会区分 allowlist 与 blocklist，并能在控制台配置受限或允许的国家/地区列表。

## 重点速览

- Geo Restriction 根据客户端 IP 的地理位置（借助 Geo-IP 数据库）决定是否允许访问分发内容，可用于版权或合规限制。
- 支持两种模式：allowlist（仅允许列出的国家/地区）和 blocklist（阻止列出的国家/地区）。

## 详细内容

1. 工作方式
- CloudFront 根据请求源 IP 通过 Geo-IP 数据库映射到国家/地区，再与分发的地理限制配置进行匹配以决定是否允许请求。

2. 配置要点
- 在 CloudFront 控制台的 Security -> Geo restriction 下可编辑配置，选择 allowlist 或 blocklist 并列出国家/地区代码。

3. 使用场景
- 常见用于内容版权控制（按国家/地区限制访问）、合规性要求或区域性业务策略。

## 自测问题

1. Geo Restriction 的两种模式有何区别？适用场景分别是什么？
2. CloudFront 如何判断请求来自哪个国家/地区？
