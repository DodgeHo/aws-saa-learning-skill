---
source: 10 - Route 53\013 Routing Policy - Failover_zh.srt
---

# 路由策略：故障转移

## 学习目标
- 理解主/备记录的故障转移流程
- 知道健康检查的强制性要求

## 重点速览
- 仅两条记录：Primary/Secondary
- Primary 必须关联健康检查
- Primary 不健康时自动切换到 Secondary

## 详细内容
故障转移路由用于灾备：
- Primary 记录正常时返回 Primary
- Primary 不健康时返回 Secondary

配置要点：
- 主记录必须绑定健康检查
- 备用记录可选绑定健康检查
- TTL 通常设置较短以加快切换

## 自测问题
- Primary 记录为什么必须绑定健康检查？
- TTL 设置过长会影响什么？
