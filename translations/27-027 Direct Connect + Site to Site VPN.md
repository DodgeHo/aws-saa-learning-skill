## 学习目标

- 理解 Direct Connect 与 Site-to-Site VPN 的差异、如何结合使用以满足可用性与带宽需求。

## 重点速览

- Direct Connect 提供稳定的专线，VPN 提供弹性的加密隧道；两者可并用以实现备份与冗余。

## 详细内容

1. 常见架构：Primary 使用 Direct Connect，Secondary 使用 Site-to-Site VPN 作为备份路径；需配置路由优先级与 BGP。
2. 设计考量：带宽需求、成本、故障转移策略以及安全合规要求。

## 自测问题

1. 描述一个使用 Direct Connect 为主、VPN 为备的网络故障切换流程。
2. 在混合云场景如何评估是否需要 Direct Connect？
