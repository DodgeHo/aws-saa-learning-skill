---
source: 05 - EC2 Fundamentals\016 EC2 Instances Launch Types Hands On_zh.srt
---

# 实操：启动 EC2 的多种方式

## 学习目标
- 在控制台中查看 Spot 价格与请求配置
- 理解 Spot Fleet 的关键参数
- 了解预留、节省计划、专用主机、容量预留入口

## 重点速览
- Spot 请求可设置最高价、目标容量与中断策略
- Spot Fleet 支持多实例类型与分配策略
- 其他采购方式在控制台均有入口但不建议随意下单

## 详细内容
### 1) Spot 请求与 Spot Fleet
在左侧进入 **Spot Requests** 可查看价格历史，并创建 Spot 请求。主要参数包括：
- 最高价格、有效期、目标容量
- 实例规格（手动选择或按 vCPU/内存筛选）
- 分配策略（最低价、容量优化等）

完成配置后可查看预计每小时价格与节省比例。

### 2) 直接在启动实例时申请 Spot
在“启动实例 → 高级详情”中选择 Spot 实例请求，可设置：
- 最高价
- 一次性/持久性请求
- 中断行为（终止/停止/休眠）

### 3) 其他采购入口
- **Reserved Instances**：选择实例类型、期限、付款方式并加入购物车
- **Savings Plans**：按每小时预算承诺换取折扣
- **Dedicated Hosts**：分配专用主机（成本高，谨慎使用）
- **Capacity Reservations**：保证特定 AZ 容量（无折扣）

## 自测问题
- Spot Fleet 的“最低价策略”意味着什么？
- 持久性 Spot 请求与一次性请求的区别是什么？
