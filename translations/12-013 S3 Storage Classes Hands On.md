---
source: 12 - Amazon S3 Introduction\013 S3 Storage Classes Hands On_zh.srt
---

# S3 存储类 - 实操要点

## 学习目标
- 学会在控制台为对象设置存储类并验证更改
- 能为 Bucket 创建生命周期规则以自动在存储类间迁移对象

## 重点速览
- 上传对象后可手动修改其存储类，或用生命周期规则自动过渡
- 可以在对象属性中看到当前存储类并切换为 Standard-IA、One Zone-IA、Glacier 等

## 实操步骤
1. 创建或打开目标 Bucket（示例名 `s3-storage-classes-demos-2022`）
2. 上传对象（例如 `coffee.jpg`）
3. 在对象详情查看 `Storage class`，可将其改为 `Standard-IA`、`One Zone-IA`、或归档类
4. 若需自动过渡：在 Bucket 的 `Management` → `Lifecycle rules` 创建规则
	- 示例：30 天后转到 Standard-IA，60 天后转到 Intelligent-Tiering，180 天后转到 Glacier Flexible
5. 保存并验证对象属性与生命周期事件（控制台会显示已完成的过渡）

## 自测问题
- 如何将已存在的对象迁移到 Glacier？
- 为什么要为某些对象选择 One Zone-IA 而不是 Standard-IA？
