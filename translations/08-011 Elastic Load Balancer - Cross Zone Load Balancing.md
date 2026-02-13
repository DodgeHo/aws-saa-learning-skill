---
source: 08 - High Availability and Scalability ELB & ASG\011 Elastic Load Balancer - Cross Zone Load Balancing_zh.srt
---

# 跨可用区负载均衡

## 学习目标
- 理解跨 AZ 负载均衡的流量分配差异
- 记住各类负载均衡器的默认行为与费用影响

## 重点速览
- 开启跨 AZ：流量在所有实例间均匀分配
- 关闭跨 AZ：流量只在本 AZ 内分配
- ALB 默认开启；NLB/GWLB 默认关闭（开启可能收费）

## 详细内容
**开启跨 AZ**：
- 客户端流量先到各 ALB 节点
- 每个 ALB 再把流量分摊给所有 AZ 的实例
- 适合 AZ 内实例数量不均衡的场景

**关闭跨 AZ**：
- 每个 ALB 仅把流量发给本 AZ 实例
- 若实例分布不均，会导致单 AZ 实例压力过大

默认与费用：
- **ALB**：默认开启；一般不收跨 AZ 数据费
- **NLB/GWLB**：默认关闭；开启会产生跨 AZ 费用
- **CLB**：默认关闭；开启通常不收跨 AZ 数据费

## 自测问题
- 为什么跨 AZ 会影响成本？
- 关闭跨 AZ 的典型风险是什么？
