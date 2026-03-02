import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import 'ai_client.dart';
import 'app_model.dart';
import 'db.dart';
import 'models.dart';

void main() {
  runApp(const AwsSaaTrainerApp());
}

class AwsSaaTrainerApp extends StatelessWidget {
  const AwsSaaTrainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final model = AppModel();
        model.loadSettings().then((_) => model.loadQuestions());
        return model;
      },
      child: MaterialApp(
        title: 'AWS SAA 题库助手',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MainScaffold(),
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  void _openProgressDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          width: 900,
          height: 640,
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: ProgressPage(),
          ),
        ),
      ),
    );
  }

  void _openSettingsDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          width: 560,
          height: 520,
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: SettingsPage(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AWS SAA 题库助手'),
        actions: [
          IconButton(
            tooltip: '进度',
            icon: const Icon(Icons.bar_chart_outlined),
            onPressed: _openProgressDialog,
          ),
          IconButton(
            tooltip: '设置',
            icon: const Icon(Icons.settings_outlined),
            onPressed: _openSettingsDialog,
          ),
        ],
      ),
      body: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _jumpController = TextEditingController();
  String _output = '';
  bool _askingAi = false;

  static const Map<String, String> _filterDisplayToMode = {
    '所有': 'All',
    '会': 'Know',
    '不会': 'DontKnow',
    '收藏': 'Favorite',
  };

  static const Map<String, String> _filterModeToDisplay = {
    'All': '所有',
    'Know': '会',
    'DontKnow': '不会',
    'Favorite': '收藏',
  };

  static const Map<String, String> _statusDisplay = {
    'Know': '会',
    'DontKnow': '不会',
    'Favorite': '收藏 ★',
  };

  Color _statusColor(String? status) {
    switch (status) {
      case 'Know':
        return Colors.green.shade700;
      case 'DontKnow':
        return Colors.red.shade700;
      case 'Favorite':
        return Colors.amber.shade800;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _jumpController.dispose();
    super.dispose();
  }

  Future<void> _sendQuestion(AppModel model, Question q, String text) async {
    final t = text.trim();
    if (t.isEmpty || _askingAi) return;

    setState(() {
      _askingAi = true;
      _output += '\n### 用户（题号: ${q.qNum ?? '-'}）\n$t\n\n';
      _output += '> 系统：正在请求 ${model.aiProvider.toUpperCase()}...\n\n';
    });

    final prompt = _buildPrompt(q, t);

    try {
      final reply = await AiClient.ask(
        provider: model.aiProvider,
        apiKey: model.apiKey,
        prompt: prompt,
        model: model.aiModel,
        baseUrl: model.aiBaseUrl,
      );
      if (!mounted) return;
      setState(() {
        _output += '### AI 回复\n$reply\n\n---\n';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _output += '### 错误\n$e\n\n---\n';
      });
    } finally {
      if (mounted) {
        setState(() {
          _askingAi = false;
        });
      }
    }

    _inputController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  String _buildPrompt(Question q, String userQuestion) {
    final zhOptions = q.optionsZh?.join('\n') ?? '';
    final enOptions = q.optionsEn?.join('\n') ?? '';
    return '''
用户提问：$userQuestion

题号：${q.qNum ?? '-'}

中文题干：
${q.stemZh ?? ''}

中文选项：
$zhOptions

英文题干：
${q.stemEn ?? ''}

英文选项：
$enOptions

参考答案：${q.correctAnswer ?? ''}
中文解析：${q.explanationZh ?? ''}
英文解析：${q.explanationEn ?? ''}

请按以下要求回答：
1) 先给结论，再给理由；
2) 用简洁中文，必要时括号补英文术语；
3) 如果用户问“为什么”，请对错误选项做简短排除。
''';
  }

  Widget _buildAiPanel(AppModel model, Question q) {
    final hasKey = model.apiKey.trim().isNotEmpty;
    final canAsk = hasKey && !_askingAi;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('AI 提问', style: TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text('提供者: ${model.aiProvider}', style: const TextStyle(fontSize: 12)),
          ],
        ),
        if (!hasKey)
          const Padding(
            padding: EdgeInsets.only(top: 4, bottom: 6),
            child: Text('请先在设置中填写 API Key 后再使用 AI 提问。', style: TextStyle(color: Colors.red)),
          ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade500,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: canAsk ? () => _sendQuestion(model, q, '这题用到了什么知识？') : null,
              child: const Text('这题用到了什么知识？'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade500,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: canAsk ? () => _sendQuestion(model, q, '这道题是什么意思？') : null,
              child: const Text('这道题是什么意思？'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade500,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: canAsk ? () => _sendQuestion(model, q, '为什么是这个结果？') : null,
              child: const Text('为什么是这个结果？'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: canAsk ? () => _sendQuestion(model, q, '我没看懂，能更简单吗？') : null,
              child: const Text('我没看懂，能更简单吗？'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _inputController,
          decoration: const InputDecoration(
            labelText: '自定义问题',
            hintText: '输入提问后回车',
            border: OutlineInputBorder(),
          ),
          enabled: hasKey,
          onSubmitted: (v) => _sendQuestion(model, q, v),
        ),
        const SizedBox(height: 8),
        if (_askingAi) const LinearProgressIndicator(),
        if (_askingAi) const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              setState(() {
                _output = '';
              });
            },
            child: const Text('清空历史'),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: MarkdownBody(
                selectable: true,
                data: _output.trim().isEmpty ? '_暂无对话历史_' : _output,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionPanel(AppModel model, Question q) {
    final displayFilter = _filterModeToDisplay[model.filterMode] ?? '所有';
    final statusText = _statusDisplay[model.currentStatus] ?? '未标记';
    final statusColor = _statusColor(model.currentStatus);
    final answerText =
        '正确答案：${q.correctAnswer ?? '(空)'}\n\n中文解析：\n${q.explanationZh ?? '(空)'}\n\nEnglish Explanation:\n${q.explanationEn ?? '(empty)'}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('筛选：'),
            DropdownButton<String>(
              value: displayFilter,
              items: _filterDisplayToMode.keys
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  final mode = _filterDisplayToMode[v] ?? 'All';
                  model.setFilterMode(mode);
                }
              },
            ),
            const SizedBox(width: 16),
            const Text('随机'),
            Checkbox(
              value: model.randomOrder,
              onChanged: (v) {
                model.setRandomOrder(v ?? false);
              },
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 72,
              child: TextField(
                controller: _jumpController,
                decoration: const InputDecoration(
                  hintText: '题号',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _handleJump(model),
              ),
            ),
            const SizedBox(width: 6),
            OutlinedButton(
              onPressed: () => _handleJump(model),
              child: const Text('跳转'),
            ),
            const SizedBox(width: 6),
            OutlinedButton(
              onPressed: () => _confirmClearProgress(model),
              child: const Text('清空刷题记录'),
            ),
          ],
        ),
        Text(
          '第${model.currentIndex + 1}/${model.questions.length} 题 | 题号为${q.qNum ?? '-'}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: model.fontSize),
        ),
        Text(
          '状态：$statusText',
          style: TextStyle(
            fontSize: model.fontSize,
            color: statusColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (q.stemZh != null)
                  Text('【中文题干】\n${q.stemZh}\n', style: TextStyle(fontSize: model.fontSize)),
                if (q.optionsZh != null)
                  Text('【中文选项】\n${q.optionsZh!.join('\n')}\n',
                      style: TextStyle(fontSize: model.fontSize)),
                if (q.stemEn != null)
                  Text('【English Stem】\n${q.stemEn}\n', style: TextStyle(fontSize: model.fontSize)),
                if (q.optionsEn != null)
                  Text('【English Options】\n${q.optionsEn!.join('\n')}\n',
                      style: TextStyle(fontSize: model.fontSize)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: model.prev, child: const Text('上一题')),
            ElevatedButton(onPressed: model.next, child: const Text('下一题')),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: model.showAnswer,
              child: const Text('答案'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              onPressed: () => model.mark('Know'),
              child: const Text('会'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              onPressed: () => model.mark('DontKnow'),
              child: const Text('不会'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade600,
                foregroundColor: Colors.black87,
                shape: const StadiumBorder(),
              ),
              onPressed: () => model.mark('Favorite'),
              child: const Text('收藏'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (model.answerVisible)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(answerText, style: TextStyle(fontSize: model.fontSize - 1)),
          ),
      ],
    );
  }

  void _handleJump(AppModel model) {
    final raw = _jumpController.text.trim();
    final num = int.tryParse(raw);
    if (num == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('请输入有效题号')));
      return;
    }
    final ok = model.jumpToNumber(num);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('题号超出范围')));
      return;
    }
    _jumpController.clear();
  }

  Future<void> _confirmClearProgress(AppModel model) async {
    final yes1 = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('确认'),
        content: const Text('此操作将清除所有刷题记录，无法恢复。继续？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('继续')),
        ],
      ),
    );
    if (yes1 != true) return;
    if (!mounted) return;

    final yes2 = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('再确认'),
        content: const Text('真的确定要清除所有记录吗？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('取消')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('确定')),
        ],
      ),
    );
    if (yes2 != true) return;

    await model.clearProgress();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('刷题记录已清空')));
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppModel>(context);
    final q = model.currentQuestion;
    if (q == null) return const Center(child: Text('没有题目'));

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 1100;
        if (wide) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(flex: 3, child: _buildQuestionPanel(model, q)),
                const SizedBox(width: 16),
                Expanded(flex: 2, child: _buildAiPanel(model, q)),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(flex: 6, child: _buildQuestionPanel(model, q)),
              const SizedBox(height: 12),
              Expanded(flex: 4, child: _buildAiPanel(model, q)),
            ],
          ),
        );
      },
    );
  }
}

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppModel>(context);
    final total = model.allQuestions.length;

    return FutureBuilder<Map<String, int>>(
      future: _computeStats(),
      builder: (ctx, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final stats = snap.data;
        final know = stats?['Know'] ?? 0;
        final dont = stats?['DontKnow'] ?? 0;
        final fav = stats?['Favorite'] ?? 0;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('共 $total 题'),
              Text('会: $know    不会: $dont    收藏: $fav'),
              const SizedBox(height: 16),
              const Text('题目概览：'),
              Expanded(child: _buildOverviewGrid(context, model)),
            ],
          ),
        );
      },
    );
  }

  Future<Map<String, int>> _computeStats() async {
    return await AppDatabase.countByStatus();
  }

  Widget _buildOverviewGrid(BuildContext context, AppModel model) {
    return LayoutBuilder(
      builder: (ctx, cons) {
        final cross = (cons.maxWidth / 40).floor().clamp(4, 20);
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cross),
          itemCount: model.allQuestions.length,
          itemBuilder: (ctx, idx) {
            final q = model.allQuestions[idx];
            final status = model.statusByQuestionId[q.id];
            Color bg = Colors.grey.shade300;
            if (status == 'Know') bg = Colors.green.shade400;
            if (status == 'DontKnow') bg = Colors.red.shade400;
            if (status == 'Favorite') bg = Colors.yellow.shade600;

            return InkWell(
              onTap: () async {
                await model.jumpToQuestionIdFromOverview(q.id);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                margin: const EdgeInsets.all(2),
                alignment: Alignment.center,
                color: bg,
                child: Text('${idx + 1}${status == 'Favorite' ? ' ★' : ''}'),
              ),
            );
          },
        );
      },
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _baseUrlController = TextEditingController();
  String _provider = 'deepseek';
  String _model = 'deepseek-chat';
  double _fontSize = 20;

  static const Map<String, List<String>> _modelOptions = {
    'deepseek': ['deepseek-chat', 'deepseek-reasoner'],
    'openai': ['gpt-4o-mini', 'gpt-4o', 'o4-mini'],
  };

  List<String> _optionsForProvider(String provider) {
    final options = List<String>.from(_modelOptions[provider] ?? const <String>[]);
    if (_model.trim().isNotEmpty && !options.contains(_model.trim())) {
      options.add(_model.trim());
    }
    return options;
  }

  String _defaultModelFor(String provider) {
    switch (provider) {
      case 'openai':
        return 'gpt-4o-mini';
      case 'deepseek':
      default:
        return 'deepseek-chat';
    }
  }

  @override
  void initState() {
    super.initState();
    final model = Provider.of<AppModel>(context, listen: false);
    _provider = model.aiProvider;
    _model = model.aiModel;
    _keyController.text = model.getProviderKey(_provider);
    _baseUrlController.text = model.aiBaseUrl;
    _fontSize = model.fontSize;
  }

  @override
  void dispose() {
    _keyController.dispose();
    _baseUrlController.dispose();
    super.dispose();
  }

  Future<void> _savePrefs() async {
    final model = Provider.of<AppModel>(context, listen: false);
    final messenger = ScaffoldMessenger.of(context);

    await model.applySettings(
      provider: _provider,
      key: _keyController.text.trim(),
      model: _model.trim().isEmpty ? _defaultModelFor(_provider) : _model.trim(),
      baseUrl: _baseUrlController.text.trim(),
      font: _fontSize,
    );
    if (!mounted) return;
    messenger.showSnackBar(const SnackBar(content: Text('保存成功')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('AI 提供者'),
            DropdownButton<String>(
              value: _provider,
              items: const [
                DropdownMenuItem(value: 'deepseek', child: Text('Deepseek')),
                DropdownMenuItem(value: 'openai', child: Text('OpenAI')),
              ],
              onChanged: (v) {
                if (v != null) {
                  setState(() {
                    _provider = v;
                    _keyController.text =
                        Provider.of<AppModel>(context, listen: false).getProviderKey(_provider);
                    final opts = _optionsForProvider(v);
                    if (opts.isNotEmpty && !opts.contains(_model)) {
                      _model = _defaultModelFor(v);
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            const Text('模型'),
            DropdownButton<String>(
              value: _model,
              isExpanded: true,
              items: _optionsForProvider(_provider)
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _model = v);
              },
            ),
            const SizedBox(height: 8),
            const Text('自定义 Base URL（可选）'),
            TextField(
              controller: _baseUrlController,
              decoration: const InputDecoration(
                hintText: '例如 https://api.deepseek.com 或 OpenAI 兼容网关地址',
              ),
            ),
            const SizedBox(height: 8),
            const Text('API Key'),
            TextField(controller: _keyController),
            const SizedBox(height: 8),
            const Text('字体大小'),
            Slider(
              value: _fontSize,
              min: 8,
              max: 24,
              divisions: 16,
              label: _fontSize.toStringAsFixed(0),
              onChanged: (v) => setState(() => _fontSize = v),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 4, bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '字体预览：这是一道 AWS SAA 题目的示例文本（EC2 / S3 / IAM）',
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
            const SizedBox(height: 8),
            const Text('默认筛选'),
            DropdownButton<String>(
              value: Provider.of<AppModel>(context, listen: false).filterMode,
              items: ['All', 'Know', 'DontKnow', 'Favorite']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  Provider.of<AppModel>(context, listen: false).filterMode = v;
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('随机顺序'),
                Checkbox(
                  value: Provider.of<AppModel>(context, listen: false).randomOrder,
                  onChanged: (v) {
                    Provider.of<AppModel>(context, listen: false).randomOrder = v ?? false;
                    setState(() {});
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _savePrefs, child: const Text('保存')),
          ],
        ),
      ),
    );
  }
}
