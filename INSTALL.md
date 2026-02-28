# Installation Instructions

This document explains how to set up the AWS-SAA Learning Skill and the QBank Trainer tool.

## 1. AWS-SAA Learning Skill

1. Clone or download the repository:
   ```bash
   git clone https://github.com/DodgeHo/aws-saa-learning-skill.git
   ```
2. Place course subtitles and materials in the `translations/` directory as described in the main `README.md`.
3. (Optional) Create an [Obsidian](https://obsidian.md/) vault and install the recommended spaced repetition plugin.
4. Use the interactive commands (`开始学习`, `学习 章节名`, etc.) via your preferred interface.

No additional dependencies are required for the learning skill itself; it is primarily a collection of markdown and supporting scripts.

## 2. Question Bank Trainer (Flutter)

本项目的题库助手已使用 Flutter 重新实现，放在仓库根目录。
它支持 Windows、macOS、Linux 桌面，Android 手机/平板，以及 Web（可选）。

### Build & Run

```bash
# 先安装 Flutter SDK
git clone https://github.com/DodgeHo/aws-saa-learning-skill.git
cd aws-saa-learning-skill
flutter pub get
flutter run          # 在默认连接的设备或模拟器上运行
# 指定平台示例：flutter run -d windows/android/ios/web
```

> **注意（Windows 桌面）**
> 
> 构建/运行 Windows 版本需要
> 1. 在系统设置中启用 **开发者模式**（符号链接支持）；
> 2. 安装 **Visual Studio 2022/2023** 并添加 “Desktop development with C++” 工作负载。
>    `flutter doctor` 会提示缺少此工具链。完成安装后重新运行 `flutter run -d windows`。


应用首次启动时会从 `assets/data.db` 将题库复制到设备的本地数据库目录。
（可在命令行日志看到复制操作，目标路径由 `getDatabasesPath()` 决定，例如
`C:\Users\<user>\AppData\Local\...`)。

> 如果想使用新的题库，请将替换好的 SQLite 文件重命名为 `assets/data.db`，
> 然后重新运行或打包应用；旧的本地数据库会被覆盖或手动删除后再次启动。

用户设置、进度和 AI Key 保存在本地 `shared_preferences` 中。

### Packaging

```bash
flutter build windows   # 生成 Windows 可执行文件
flutter build macos
flutter build linux
flutter build apk       # Android APK
flutter build web       # Web 应用
```

构建成果静态放在各自的 `build/` 子目录下，可按需打包分发。

## 3. Environment Variables

- `DEEPSEEK_API_KEY` 或 `OPENAI_API_KEY`：仅在使用 AI 提问功能时需要。
  也可以在应用设置页直接输入 API Key。


