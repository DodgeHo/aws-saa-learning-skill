---
source: 08 - High Availability and Scalability ELB & ASG\008 Network Load Balancer (NLB) - Hands On_zh.srt
---

# NLB 实操

## 学习目标
- 创建 NLB 与目标组
- 配置安全组让健康检查通过
- 验证负载均衡效果

## 重点速览
- NLB 可分配每个 AZ 的固定 IP
- 监听器常用 TCP 80
- 实例安全组需允许来自 NLB 的流量

## 详细内容
创建 NLB：
1. 选择 **Network Load Balancer**，命名如 `DemoNLB`。
2. **Internet-facing**，启用多个 AZ。
3. 如需固定 IP，可为每个 AZ 绑定 EIP。
4. 创建安全组 `demo-sg-nlb`，允许 `80/TCP`。

创建目标组：
1. 协议 `TCP`，端口 `80`，类型为 **Instances**。
2. 注册两台实例。
3. 健康检查可使用 `HTTP`（如果实例提供 HTTP 服务）。

排查健康检查失败：
- 确认实例安全组允许来自 `demo-sg-nlb` 的入站 `HTTP`。

验证：
- 访问 NLB DNS，刷新多次，观察后端实例轮换。

## 自测问题
- 为什么 NLB 需要实例安全组允许来自 NLB 的流量？
- NLB 每个 AZ 固定 IP 有何用途？

您可以选择删除演示目标组,

就在这里, 为NLB｡

如果您愿意,

还可以删除NLB的安全组｡

但我不认为这是必要的,

但它是很好的做法, 如果你想尝试一下｡

好了, 这节课就到这里了｡ 

我希望你们喜欢,

我们下次课再见｡
