## 学习目标

- 了解 Systems Manager（SSM）其他常用功能：Run Command、Parameter Store、Inventory、Automation 等。

## 重点速览

- SSM 提供远程命令执行、参数管理、自动化运行书、实例清单与补丁管理，适用于大规模运维与配置管理。

## 详细内容

1. Run Command：在大量实例上并行执行命令或脚本；Parameter Store：安全地存储配置与机密（可与 KMS 集成）。
2. Automation：定义和执行可重复的运行手册以实现自动化运维任务；Inventory 与 Patch Manager 帮助资产与补丁管理。

## 自测问题

1. 描述如何使用 Parameter Store 存储并检索应用配置的安全密钥。
2. 当需要在数百台实例上执行相同脚本时，应优先使用 SSM 的哪个功能？为什么？
