---
source: 04 - IAM & AWS CLI\003 IAM Policies_zh.srt
---

# IAM 策略结构

## 学习目标
- 理解策略在用户/组/角色之间的继承关系
- 掌握 IAM 策略 JSON 的关键字段
- 为考试打好策略结构基础

## 重点速览
- 组策略作用于组内所有成员
- 用户可有内联策略，和组策略叠加生效
- 策略核心字段：Effect、Principal、Action、Resource、Condition

## 详细内容
策略可以附加到**组**、**用户**或**角色**。如果策略附加在组上，组内所有用户都会继承该策略。如果用户属于多个组，那么会继承多份策略；此外还可以给用户设置**内联策略**（仅对该用户生效）。

IAM 策略是 JSON 文档，常见结构如下：
- **Version**：策略语言版本（常见为 `2012-10-17`）
- **Id**：策略标识（可选）
- **Statement**：一个或多个语句
	- **Sid**：语句标识（可选）
	- **Effect**：`Allow` 或 `Deny`
	- **Principal**：策略适用的主体（账户/用户/角色）
	- **Action**：允许或拒绝的 API 操作列表
	- **Resource**：操作作用的资源列表
	- **Condition**：可选条件，指定何时生效

考试中要重点理解 Effect、Principal、Action、Resource 与 Condition 的含义与用法。后续实操会进一步强化。

## 自测问题
- 用户同时属于多个组时，策略如何叠加？
- IAM 策略中最关键的四个字段是什么？
