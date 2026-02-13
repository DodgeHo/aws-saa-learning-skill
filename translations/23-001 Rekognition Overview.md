---
source: 23 - Machine Learning & AI\001 Rekognition_zh.srt
---

## 学习目标

- 理解 Amazon Rekognition 的功能与典型应用（图像/视频中的物体、面部与内容分析）。
- 掌握 Rekognition 的 API 类型：图像检测、面部比对、情感/年龄估计与流媒体视频分析。 

## 重点速览

- Rekognition 提供托管的计算机视觉服务，支持静态图片与实时视频流分析，适用于安防、内容审核与搜索。 
- 可与 S3、Kinesis Video Streams、Lambda 集成实现端到端处理与事件驱动响应。 

## 详细内容

- 功能要点：
  - 图像标签（Label Detection）、面部识别（Face Detection/Comparison）、人脸索引（Face Indexing）、文本检测（Text in Image）等。 
  - 视频分析支持对象跟踪、面部搜索与片段检索，常与 Kinesis Video 配合实现实时监控。 

- 隐私与精度：
  - Rekognition 提供置信度（confidence）评分，使用时应结合阈值与业务规则以降低误判。 
  - 在包含个人数据的场景中需遵循隐私与合规要求（如取得同意、数据最小化、加密存储）。

## 自测问题

- 列举三种常见的 Rekognition 用例并说明各自的输入/输出。 
- 在实时视频分析场景中，Rekognition 通常如何与其他 AWS 服务集成？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
