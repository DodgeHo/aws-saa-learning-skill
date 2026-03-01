import 'package:flutter/material.dart';
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
  String _output = '';
  bool _askingAi = false;

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendQuestion(AppModel model, Question q, String text) async {
    final t = text.trim();
    if (t.isEmpty || _askingAi) return;

    setState(() {
      _askingAi = true;
      _output += '\n[用户][题号:${q.qNum ?? '-'}] $t\n';
      _output += '[系统] 正在请求 ${model.aiProvider.toUpperCase()}...\n';
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
        _output += '[AI] $reply\n';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _output += '[错误] $e\n';
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
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: _askingAi ? null : () => _sendQuestion(model, q, '这题用到了什么知识？'),
              child: const Text('知识点'),
            ),
            ElevatedButton(
              onPressed: _askingAi ? null : () => _sendQuestion(model, q, '这道题是什么意思？'),
              child: const Text('题意'),
            ),
            ElevatedButton(
              onPressed: _askingAi ? null : () => _sendQuestion(model, q, '为什么是这个结果？'),
              child: const Text('解析'),
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
          onSubmitted: (v) => _sendQuestion(model, q, v),
        ),
        const SizedBox(height: 8),
        if (_askingAi) const LinearProgressIndicator(),
        if (_askingAi) const SizedBox(height: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Text(_output),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionPanel(AppModel model, Question q) {
    final filterOptions = ['All', 'Know', 'DontKnow', 'Favorite'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('筛选：'),
            DropdownButton<String>(
              value: model.filterMode,
              items: filterOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  model.filterMode = v;
                  model.saveSettings();
                  model.loadQuestions();
                }
              },
            ),
            const SizedBox(width: 16),
            const Text('随机'),
            Checkbox(
              value: model.randomOrder,
              onChanged: (v) {
                model.randomOrder = v ?? false;
                model.saveSettings();
                model.loadQuestions();
              },
            ),
          ],
        ),
        Text(
          '第${model.currentIndex + 1}/${model.questions.length} 题',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: model.fontSize),
        ),
        if (model.status != null)
          Text('状态: ${model.status}', style: TextStyle(fontSize: model.fontSize)),
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
            ElevatedButton(onPressed: () => model.mark('Know'), child: const Text('会')),
            ElevatedButton(onPressed: () => model.mark('DontKnow'), child: const Text('不会')),
            ElevatedButton(onPressed: () => model.mark('Favorite'), child: const Text('收藏')),
          ],
        ),
      ],
    );
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
    final total = model.questions.length;

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
        final cross = (cons.maxWidth / 80).floor().clamp(4, 20);
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cross),
          itemCount: model.questions.length,
          itemBuilder: (ctx, idx) {
            return InkWell(
              onTap: () {
                model.currentIndex = idx;
                model.loadStatus();
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.all(2),
                alignment: Alignment.center,
                color: Colors.grey.shade200,
                child: Text('${idx + 1}'),
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
  double _fontSize = 11;

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
    _keyController.text = model.apiKey;
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

    model.aiProvider = _provider;
    model.aiModel = _model.trim().isEmpty ? _defaultModelFor(_provider) : _model.trim();
    model.aiBaseUrl = _baseUrlController.text.trim();
    model.apiKey = _keyController.text.trim();
    model.fontSize = _fontSize;

    await model.saveSettings();
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
