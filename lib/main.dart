import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  int _selectedIndex = 0;

  void setTab(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  final List<Widget> _pages = const [
    QuizPage(),
    AiPage(),
    ProgressPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        return Scaffold(
          appBar: AppBar(
            title: const Text('AWS SAA 题库助手'),
          ),
          body: isWide
              ? Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.quiz_outlined),
                          label: Text('刷题'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.smart_toy_outlined),
                          label: Text('AI问答'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.bar_chart_outlined),
                          label: Text('进度'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.settings_outlined),
                          label: Text('设置'),
                        ),
                      ],
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(child: _pages[_selectedIndex]),
                  ],
                )
              : _pages[_selectedIndex],
          bottomNavigationBar: isWide
              ? null
              : BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: (idx) => setState(() => _selectedIndex = idx),
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.quiz_outlined), label: '刷题'),
                    BottomNavigationBarItem(icon: Icon(Icons.smart_toy_outlined), label: 'AI问答'),
                    BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: '进度'),
                    BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: '设置'),
                  ],
                ),
        );
      },
    );
  }
}

// 题目刷题页
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppModel>(context);

    if (model.webError) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''当前在 Web 平台上运行，内置 SQLite 数据库不可用。
请在 Windows/Android/iOS/macOS/Linux 等受支持平台运行此应用。''',
          textAlign: TextAlign.center,
        ),
      ));
    }

    final q = model.currentQuestion;
    if (q == null) return const Center(child: Text('没有题目'));

    // filter control
    final filterOptions = ['All', 'Know', 'DontKnow', 'Favorite'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
                  }),
            ],
          ),
          Text('第${model.currentIndex + 1}/${model.questions.length} 题',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: model.fontSize)),
          if (model.status != null)
            Text('状态: ${model.status}',
                style: TextStyle(fontSize: model.fontSize)),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (q.stemZh != null)
                    Text('【中文题干】\n${q.stemZh}\n',
                        style: TextStyle(fontSize: model.fontSize)),
                  if (q.optionsZh != null)
                    Text('【中文选项】\n${q.optionsZh!.join('\n')}\n',
                        style: TextStyle(fontSize: model.fontSize)),
                  if (q.stemEn != null)
                    Text('【English Stem】\n${q.stemEn}\n',
                        style: TextStyle(fontSize: model.fontSize)),
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
          )
        ],
      ),
    );
  }
}

// AI问答页
class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _output = '';

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendQuestion(String text) {
    if (text.isEmpty) return;
    setState(() {
      _output += '\n[用户] $text\n';
    });
    // TODO: send to AI provider using key from settings
    setState(() {
      _output += '[AI] (回答将在此处显示)\n';
    });
    _inputController.clear();
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                  onPressed: () => _sendQuestion('这题用到了什么知识？'),
                  child: const Text('知识点')),
              const SizedBox(width: 8),
              ElevatedButton(
                  onPressed: () => _sendQuestion('这道题是什么意思？'),
                  child: const Text('题意')),
              const SizedBox(width: 8),
              ElevatedButton(
                  onPressed: () => _sendQuestion('为什么是这个结果？'),
                  child: const Text('解析')),
            ],
          ),
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
                labelText: '自定义问题', hintText: '输入提问然后回车'),
            onSubmitted: _sendQuestion,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Text(_output),
            ),
          )
        ],
      ),
    );
  }
}

// 刷题进度页
class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppModel>(context);
    final total = model.questions.length;
    int know = 0, dont = 0, fav = 0;
    for (var q in model.questions) {
      // naive count by querying status synchronously is hard; instead fetch all statuses
    }

    return FutureBuilder<void>(
      future: _computeStats(),
      builder: (ctx, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final stats = snap.data as Map<String, int>?;
        know = stats?['Know'] ?? 0;
        dont = stats?['DontKnow'] ?? 0;
        fav = stats?['Favorite'] ?? 0;
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
    // delegate to AppDatabase platform implementation
    return await AppDatabase.countByStatus();
  }

  Widget _buildOverviewGrid(BuildContext context, AppModel model) {
    return LayoutBuilder(builder: (ctx, cons) {
      final cross = (cons.maxWidth / 80).floor().clamp(4, 20);
      return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cross),
        itemCount: model.questions.length,
        itemBuilder: (ctx, idx) {
          final q = model.questions[idx];
          return InkWell(
            onTap: () {
              model.currentIndex = idx;
              model.loadStatus();
              // switch to quiz tab if possible
              final parent = context.findAncestorStateOfType<_MainScaffoldState>();
              if (parent != null) parent.setTab(0);
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
    });
  }
}

// 设置页
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _keyController = TextEditingController();
  String _provider = 'deepseek';
  double _fontSize = 11;

  @override
  void initState() {
    super.initState();
    final model = Provider.of<AppModel>(context, listen: false);
    _provider = model.aiProvider;
    _keyController.text = model.apiKey;
    _fontSize = model.fontSize;
  }

  Future<void> _savePrefs() async {
    final model = Provider.of<AppModel>(context, listen: false);
    model.aiProvider = _provider;
    model.apiKey = _keyController.text;
    model.fontSize = _fontSize;
    // filter and order already stored when changed
    await model.saveSettings();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('保存成功')));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              if (v != null) setState(() => _provider = v);
            },
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
          ElevatedButton(onPressed: _savePrefs, child: const Text('保存'))
        ],
      ),
    );
  }
}
