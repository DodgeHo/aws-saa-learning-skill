# AWS-SAA Learning Skill

一个用于学习 AWS Certified Solutions Architect Associate (SAA) 的 AI 学习辅导系统。课程内容来自 Stéphane Maarek 的 AWS SAA 课程, 学习框架参考 AlphaMao Skills。

## 项目定位

- 面向自学: 用本地字幕材料构建可复习的学习路径
- 面向实操: 将 Hands-On 章节视为实践任务
- 面向复习: 通过进度追踪与间隔复习强化记忆

## 课程来源

- 课程名称: AWS Certified Solutions Architect Associate
- 讲师: Stéphane Maarek
- 官方认证页面: https://aws.amazon.com/certification/certified-solutions-architect-associate/

> 说明: 本仓库不包含课程视频或字幕文件, 仅提供学习框架与结构化模板。课程素材需由学习者自行准备并放置在translations路径中。

## 学习框架来源

- 项目: AlphaMao Skills
- 链接: https://github.com/z1993/AlphaMao_Skills/tree/main
- 说明: 本项目在学习流程与结构设计上参考该仓库的思路, 保留原作者署名与链接。
- 许可证: 上游仓库未标注明确许可证 (GitHub API 显示 license = null)。如需严格许可声明, 请先确认上游许可证后再发布。

## 核心特点

- **课程素材**: 来自课程中的字幕文件
- **自动整理**: 转换字幕为可读的 Markdown 并放入 translations/
- **结构化学习**: 按章节生成学习清单与进度模板
- **中文优先**: 材料来自中文字幕, 术语保留英文
- **进度追踪**: 在 Obsidian Vault 中管理进度与复习

## 新增子项目: QBank 背题工具（Windows MVP）

在不影响原学习流程的前提下，仓库新增了一个一次性题库导入 + 背题应用子目录：`qbank_trainer/`。

### 你可以做什么

- 基于本地 SQLite 题库一题一题背题（上一题 / 下一题）
- 标记题目状态（会 / 不会 / 收藏），状态会用颜色高亮，收藏题目带星号
- 在“题目概览”窗口查看所有题的状态（灰/绿/红/黄＋星标），可直接跳转
- 支持中文“筛选”菜单（所有/会/不会/收藏）、随机顺序、按题号跳转、清空刷题记录
- 显示答案与解析，字体大小可通过设置中的滑杆调整
- AI 辅助可以接入 DeepSeek、OpenAI 等服务，设置中选择提供者并填写 API Key
  - 初次运行若未配置 Key 会弹窗提醒并高亮“设置 Key”按钮
  - AI 按钮在无 Key 情况下禁用
- 包括上一版中一键调用 DeepSeek 的四个常用问题以及自定义提问框

### 快速开始

1. 如果不希望安装 Python，可以直接下载 [GitHub Release](https://github.com/DodgeHo/aws-saa-learning-skill/releases) 中的 `qbank_trainer-vX.Y.zip`，解压后双击 `qbank_trainer.exe`。
2. 或者进入 `qbank_trainer/` 子目录并安装依赖（仅导入与运行所需）。
3. 准备 `qbank_trainer/data.db`（已生成可直接使用）。
4. 一键运行（Windows）：双击根目录 `run_qbank.bat`
5. 或命令行运行：`python qbank_trainer/quiz_app.py`

### DeepSeek Key 配置

推荐使用 `qbank_trainer/.env`：

```
DEEPSEEK_API_KEY=你的key
```

读取优先级：`.env` > 系统环境变量 `DEEPSEEK_API_KEY` > 本地配置文件。

### 子项目文档

- `qbank_trainer/README.md`: 背题工具与导入工具说明
- `qbank_trainer/build_release.ps1`: Powershell 脚本，自动构建并打包 Windows 发行版
- `PROJECT_PLAN.md`: 本次实现记录与阶段日志

> 说明：原有学习系统文档（本 README、SKILL.md、translations 与 references 相关说明）均保留不变。

## 安装

1. 将此文件夹复制到你的 Skills 目录:
   ```
   # Windows
   C:\Users\你的用户名\.gemini\antigravity\skills\aws-saa-learning\
   C:\Users\你的用户名\.copilot\skills\aws-saa-learning\
   
   # macOS/Linux
   ~/.gemini/antigravity/skills/aws-saa-learning/
   ```

2. 创建或准备一个 Obsidian Vault（首次运行时会询问路径）

3. 安装 Obsidian 插件 (推荐):
   - https://github.com/st3v3nmw/obsidian-spaced-repetition

## 使用方法

### 开始学习

```
开始学习
```

系统会：
1. 读取你的当前进度
2. 询问学习模式
3. 逐篇引导学习

### 核心命令

| 命令 | 作用 |
|------|------|
| `开始学习` | 首次启动, 选择学习模式 |
| `学习 章节名` | 学习指定章节 |
| `读 [材料名]` | 阅读指定材料 |
| `解释 [术语]` | 获得通俗解释 |
| `读完了` | 完成阅读, 进入问答环节 |
| `我的进度` | 查看学习进度 |

### 学习流程

```
选择材料 -> 阅读字幕整理稿 -> 解释疑问 -> 回答问题 -> 生成笔记 -> 周末生成定制闪卡
```

## 文件结构

```
aws-saa-learning/
├── SKILL.md
├── README.md
├── CHANGELOG.md
├── PROJECT_PLAN.md
├── ISSUES.md
├── qbank_trainer/
│   ├── README.md
│   ├── quiz_app.py
│   ├── data.db
│   └── src/
├── references/
│   ├── course-content.md
│   ├── content-audit.md
│   ├── why-this-matters.md
│   └── assignments-guide.md
├── templates/
│   ├── progress.md
│   ├── note-template.md
│   └── flashcard-template.md
└── translations/         # 由 _zh.srt 转换的学习材料
```

## 许可证

MIT License

## 贡献指南 (GitHub)

欢迎提交 issue 与 PR。为便于协作, 建议遵循以下流程:

1. 在 [ISSUES.md](ISSUES.md) 中确认是否已有相关问题
2. 新建 issue 描述动机、影响范围与期望结果
3. Fork 仓库并创建分支: `feature/<short-name>` 或 `fix/<short-name>`
4. 保持改动聚焦、提交信息清晰 (建议: `type: summary` 格式)
5. 在 PR 中说明变更背景、验证方式与相关 issue

如果涉及学习材料或模板更新, 请同时更新 [CHANGELOG.md](CHANGELOG.md)。

## 发布说明 (GitHub)

本项目采用 GitHub Releases 发布。建议使用语义化版本号 (SemVer):

- 版本格式: `MAJOR.MINOR.PATCH`
- 变更记录: 统一维护在 [CHANGELOG.md](CHANGELOG.md)
- 发布节奏: 重要内容合并后发布; 小修复可累积后发布

发布步骤建议:

1. 更新 [CHANGELOG.md](CHANGELOG.md) 并确保版本号一致
2. 打 tag 并推送到 GitHub
3. 在 GitHub Releases 页面发布对应版本说明

## 相关链接

- https://aws.amazon.com/certification/certified-solutions-architect-associate/
- https://github.com/z1993/AlphaMao_Skills/tree/main
