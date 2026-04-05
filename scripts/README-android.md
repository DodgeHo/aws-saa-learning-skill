# Android 快速使用说明（AWS-SAA-Learning-Flutter）

## 1) 前置条件

- 已安装 Flutter（当前项目使用 3.41.2）
- Android SDK / Emulator 可用
- 建议开启 Clash 代理（本项目脚本默认：HTTP `127.0.0.1:7892`，SOCKS `127.0.0.1:7891`）

## 2) 一键运行（模拟器/真机）

在项目根目录执行：

```powershell
.\scripts\run_android.ps1 -NoResident
```

- 默认行为：自动选择第一个可用 Android 设备
- 若没有在线 Android 设备：脚本会尝试自动启动第一个可用模拟器
- 指定设备：

```powershell
.\scripts\run_android.ps1 -DeviceId <device-id> -NoResident
```

- 仅查看将执行的命令（不真正运行）：

```powershell
.\scripts\run_android.ps1 -DryRun
```

## 3) 一键构建 APK

### Release APK（默认）

```powershell
.\scripts\build_android.ps1
```

产物：

- `build/app/outputs/flutter-apk/app-saa-release.apk`

指定题库变体（可并存安装）：

```powershell
.\scripts\build_android.ps1 -Bank saa
.\scripts\build_android.ps1 -Bank sap
.\scripts\build_android.ps1 -Bank ispm
```

### Debug APK

```powershell
.\scripts\build_android.ps1 -Debug
```

产物：

- `build/app/outputs/flutter-apk/app-saa-debug.apk`

## 4) 一键构建 AAB（上架包）

```powershell
.\scripts\build_android.ps1 -Aab
```

产物：

- `build/app/outputs/bundle/saaRelease/app-saa-release.aab`

## 5) 代理开关

脚本默认启用代理。如果你临时不想走代理：

```powershell
.\scripts\run_android.ps1 -NoProxyMode -NoResident
.\scripts\build_android.ps1 -NoProxyMode
```

## 6) 脚本说明

- `scripts/android_env.ps1`：注入 `JAVA_HOME` 与代理环境变量
- `scripts/run_android.ps1`：运行到设备（支持 `-DeviceId`）
- `scripts/build_android.ps1`：构建 APK/AAB

## 7) 常见问题

### 7.1 卡在 Gradle 下载 / `Read timed out`

- 检查 Clash 是否开启
- 优先用默认代理模式重新执行构建脚本
- 如果仍失败，重试一次：

```powershell
.\scripts\build_android.ps1
```

### 7.2 `adb` 异常（device offline / protocol fault）

```powershell
adb kill-server
adb start-server
adb devices
```

### 7.3 `JAVA_HOME` 相关错误

- 直接通过脚本执行，不要手动裸跑 `gradlew`，脚本会自动设置 `JAVA_HOME`

## 8) 推荐日常命令

```powershell
# 启动调试运行
.\scripts\run_android.ps1 -NoResident

# 生成发布 APK
.\scripts\build_android.ps1
```

## 9) 题库替换与多题库 APK（开发者）

目标：在不修改数据库表结构的前提下，构建不同题库的 APK 变体。

### 9.1 题库资产目录

- `assets/banks/saa/`：SAA 题库资产（`data.db` + `questions.json`）
- `assets/banks/sap/`：SAP 题库资产（`data.db` + `questions.json`）
- `assets/banks/ispm/`：ISPM 题库资产（`data.db` + `questions.json`）

### 9.2 从 SAP PDF 生成题库资产

先安装一次 PDF 提取依赖：

```powershell
py -m pip install pypdf
```

```powershell
.\scripts\prepare_sap_bank.ps1
```

该命令会：
- 从 `题库/2.中文SAP-C02 - 含答案.pdf` 抽取 UTF-8 文本到 `题库/SAP-C02 中文题库.txt`
- 生成 `assets/banks/sap/data.db` 和 `assets/banks/sap/questions.json`

### 9.3 切换当前构建题库

```powershell
.\scripts\select_question_bank.ps1 -Bank saa
.\scripts\select_question_bank.ps1 -Bank sap
.\scripts\select_question_bank.ps1 -Bank ispm
```

切换后会覆盖：
- `assets/data.db`
- `assets/questions.json`

### 9.4 构建题库变体 APK

```powershell
.\scripts\build_android_bank_variant.ps1 -Bank saa -VersionTag 0.2.0
.\scripts\build_android_bank_variant.ps1 -Bank sap -VersionTag 0.2.0
.\scripts\prepare_ispm_bank.ps1
.\scripts\build_android_bank_variant.ps1 -Bank ispm -VersionTag 0.2.0
```

输出文件：
- `release/banks/app-0.2.0-saa.apk`
- `release/banks/app-0.2.0-sap.apk`
- `release/banks/app-0.2.0-ispm.apk`

### 9.5 当前发布风险说明

- `saa`：当前为默认稳定题库。
- `sap`：已完成 PDF 抽取与资产生成，可作为 0.2.0 变体输出。
- `ispm`：已适配最新 OCR 题源目录并完成正式产物命名，可作为 0.2.2 变体输出。
- 仍建议在发布前按抽样方式人工复核 OCR 识别质量与答案字段完整性。

### 9.6 使用 DeepSeek 批量校对题干语句（可选）

用途：批量修复题干/选项/解析中的中文格式问题与语句不通顺问题，不改题意与答案字母。

1) 设置 API Key（建议环境变量，不要写进代码仓库）：

```powershell
$env:DEEPSEEK_API_KEY = "<your-key>"
```

2) 先生成建议文件（不直接改题库）：

```powershell
py .\scripts\proofread_ispm_with_deepseek.py `
	--input assets\banks\ispm\questions.json `
	--output reports\ispm_deepseek_suggestions.json `
	--type objective `
	--start-id 1 --end-id 999999 `
	--batch-size 15
```

3) 人工看过建议后再应用：

```powershell
py .\scripts\proofread_ispm_with_deepseek.py `
	--input assets\banks\ispm\questions.json `
	--output reports\ispm_deepseek_suggestions.json `
	--type objective `
	--batch-size 15 `
	--apply
```

断点续作：脚本默认开启，进度文件默认为 `reports/ispm_deepseek_suggestions.json.resume.json`。
- 中断后直接重跑同一命令，会自动跳过已完成批次。
- 若要强制重头开始，加 `--restart`。
- 也可自定义进度文件路径：`--resume-file reports\ispm_resume_group1.json`。

建议：先按题号区间分组跑（例如 `--start-id 1 --end-id 120`），每组审核后再应用。
