---
source: 23 - Machine Learning & AI\012 Textract_zh.srt
---

## 学习目标

- 了解 Amazon Textract 的功能：从文档（图片、PDF）中自动提取文本、表格与表单字段。 
- 掌握常见调用模式、输出结构与与其他服务（S3、Lambda、Comprehend）的集成方法。 

## 重点速览

- Textract 能识别文档中的段落、表格与键值对，适用于发票、合同、证件等文档自动化处理。 
- 支持同步与异步接口，异步适合大文件或批量处理，并可将结果持久化到 S3。 

## 详细内容

- 功能与实践：
  - 文本检测（DetectDocumentText）适合简单 OCR；分析 API（AnalyzeDocument）能提取表格与键值对。 
  - 使用异步 Job（StartDocumentAnalysis）处理较大文档，并通过 SNS/ SQS 通知结果完成。 

- 集成建议：
  - 将 Textract 输出与 Comprehend/NLP 管道结合进行实体抽取或与 Glue/Step Functions 构建端到端处理流程。 

## 自测问题

- 描述使用 Textract 提取发票中表格与字段的基本流程。 
- 何时应选择异步分析接口而非同步接口？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
