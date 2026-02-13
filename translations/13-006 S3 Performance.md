---
source: 13 - Advanced Amazon S3\006 S3 Performance_zh.srt
---

# S3 性能要点

## 学习目标
- 了解 S3 的基线性能与按前缀的吞吐限制
- 掌握提升上传/下载速度的常用手段（multipart、Transfer Acceleration、范围获取）

## 重点速览
- S3 能自动扩展以支持非常高的请求率；基线延迟通常较低（100–200 ms 首字节）
- 建议的并发限额示例（历史参考）：每前缀每秒约 3,500 个 PUT/COPY/POST/DELETE，5,500 个 GET/HEAD（按前缀分布）
- 性能优化：multipart 上传（>5 GB 必须，>100 MB 建议）、S3 Transfer Acceleration、Byte-range GETs 并行下载

## 详细内容
- 前缀概念：对象 key 中的前缀（如文件夹路径）用于并行化；不同前缀可并行承载请求配额
- Multipart 上传：把大文件分成多个部分并行上传，上传完成后在 S3 端合并为单个对象，能提高带宽利用率与容错性
- Transfer Acceleration：通过最近的 AWS 边缘站点上传到 S3，减少公共互联网的传输时延并使用 AWS 全球网络加速跨区域传输
- Byte-range GET：按字节范围并行获取对象的不同部分，用于加速下载或只读取文件局部内容
- 额外注意：在高吞吐场景下注意 KMS 请求配额（若使用加密）与客户端重试策略

## 自测问题
- 为什么将对象 key 设计为多个不同前缀可以提升并发吞吐？
- Multipart 上传相比单连接上传有哪些优势？
