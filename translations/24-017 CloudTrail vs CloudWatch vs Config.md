---
source: 24 - Monitoring & Logging\017 CloudTrail vs CloudWatch vs Config_zh.srt
---

## 学习目标

- 理清 CloudTrail、CloudWatch 与 AWS Config 三者的职责边界与典型使用场景。 

## 重点速览

- CloudTrail：记录 API 调用与管理事件，侧重审计与合规；CloudWatch：监控指标、日志与告警，侧重运行态监控；AWS Config：记录资源配置与合规评估，侧重配置状态历史与规则评估。 

## 详细内容

- 对比要点：
  - 数据类型：CloudTrail 关注控制面事件（API 调用）；CloudWatch 关注运行指标与日志；Config 关注资源配置与历史快照。 
  - 集成场景：三者常结合使用：CloudTrail 发现可疑 API 调用 -> EventBridge 触发响应 -> CloudWatch 监控相关运行指标 -> Config 验证资源配置是否合规并触发修复。 

- 选择建议：
  - 需要审计与取证使用 CloudTrail；需要实时运行监控与告警使用 CloudWatch；需要合规检查与历史配置分析使用 AWS Config。 

## 自测问题

- 给出一个场景说明为何同时需要 CloudTrail、CloudWatch 与 AWS Config。 
- 对于“检测并修复公开的 S3 桶”，应如何分别利用这三项服务？

## 术语与易错点（将在全部章节完成后汇总）

- （统一汇总，稍后添加）
