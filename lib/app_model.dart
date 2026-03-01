import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db.dart';
import 'models.dart';

class AppModel extends ChangeNotifier {
  List<Question> allQuestions = [];
  List<Question> questions = [];
  int currentIndex = 0;
  Map<int, String> statusByQuestionId = {};
  bool answerVisible = false;

  // web-specific flag when DB can't be opened
  bool webError = false;

  // settings
  String aiProvider = 'deepseek';
  String apiKey = '';
  String aiModel = 'deepseek-chat';
  String aiBaseUrl = '';
  double fontSize = 11;

  String filterMode = 'All';
  bool randomOrder = false;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    aiProvider = prefs.getString('ai_provider') ?? 'deepseek';
    apiKey = prefs.getString('api_key') ?? '';
    aiModel = prefs.getString('ai_model') ?? _defaultModelFor(aiProvider);
    aiBaseUrl = prefs.getString('ai_base_url') ?? '';
    fontSize = prefs.getDouble('font_size') ?? 11;
    filterMode = prefs.getString('filter_mode') ?? 'All';
    randomOrder = prefs.getBool('random_order') ?? false;
    notifyListeners();
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ai_provider', aiProvider);
    await prefs.setString('api_key', apiKey);
    await prefs.setString('ai_model', aiModel);
    await prefs.setString('ai_base_url', aiBaseUrl);
    await prefs.setDouble('font_size', fontSize);
    await prefs.setString('filter_mode', filterMode);
    await prefs.setBool('random_order', randomOrder);
  }

  Future<void> applySettings({
    required String provider,
    required String key,
    required String model,
    required String baseUrl,
    required double font,
  }) async {
    aiProvider = provider;
    apiKey = key;
    aiModel = model;
    aiBaseUrl = baseUrl;
    fontSize = font;

    await saveSettings();
    notifyListeners();
  }

  String _defaultModelFor(String provider) {
    switch (provider.trim().toLowerCase()) {
      case 'openai':
        return 'gpt-4o-mini';
      case 'deepseek':
      default:
        return 'deepseek-chat';
    }
  }

  Future<void> loadQuestions() async {
    try {
      final rows = await AppDatabase.fetchQuestions();
      allQuestions = rows
          .map((r) => Question.fromMap(r))
          .where((q) {
            final qNum = int.tryParse((q.qNum ?? '').trim());
            return qNum != null && qNum > 0;
          })
          .toList();

      allQuestions.sort((a, b) {
        final qa = int.tryParse((a.qNum ?? '').trim()) ?? 1 << 30;
        final qb = int.tryParse((b.qNum ?? '').trim()) ?? 1 << 30;
        return qa.compareTo(qb);
      });

      statusByQuestionId = await AppDatabase.getLatestStatuses();

      _applyFilterAndRandom();
      if (questions.isEmpty) {
        currentIndex = 0;
      } else if (currentIndex >= questions.length) {
        currentIndex = questions.length - 1;
      }

      webError = false;
    } on UnsupportedError catch (_) {
      allQuestions = [];
      questions = [];
      webError = true;
    } catch (e) {
      allQuestions = [];
      questions = [];
      debugPrint('loadQuestions failed: $e');
    }
    notifyListeners();
  }

  void _applyFilterAndRandom() {
    final filtered = allQuestions.where((q) {
      if (filterMode == 'All') return true;
      return statusByQuestionId[q.id] == filterMode;
    }).toList();

    if (randomOrder) {
      filtered.shuffle();
    }
    questions = filtered;
    answerVisible = false;
  }

  Question? get currentQuestion {
    if (questions.isEmpty) return null;
    if (currentIndex < 0 || currentIndex >= questions.length) return null;
    return questions[currentIndex];
  }

  String? get currentStatus {
    final q = currentQuestion;
    if (q == null) return null;
    return statusByQuestionId[q.id];
  }

  void next() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
      answerVisible = false;
      notifyListeners();
    }
  }

  void prev() {
    if (currentIndex > 0) {
      currentIndex--;
      answerVisible = false;
      notifyListeners();
    }
  }

  Future<void> mark(String st) async {
    if (currentQuestion == null) return;
    final questionId = currentQuestion!.id;
    await AppDatabase.setStatus(questionId, st);
    statusByQuestionId[questionId] = st;

    if (filterMode != 'All') {
      final currentId = questionId;
      _applyFilterAndRandom();
      if (questions.isEmpty) {
        currentIndex = 0;
      } else {
        final idx = questions.indexWhere((q) => q.id == currentId);
        currentIndex = idx >= 0 ? idx : 0;
      }
    }
    notifyListeners();
  }

  Future<void> setFilterMode(String mode) async {
    filterMode = mode;
    await saveSettings();
    _applyFilterAndRandom();
    currentIndex = 0;
    notifyListeners();
  }

  Future<void> setRandomOrder(bool value) async {
    randomOrder = value;
    await saveSettings();
    _applyFilterAndRandom();
    currentIndex = 0;
    notifyListeners();
  }

  void jumpToDisplayIndex(int index) {
    if (index < 0 || index >= questions.length) return;
    currentIndex = index;
    answerVisible = false;
    notifyListeners();
  }

  bool jumpToNumber(int oneBasedNumber) {
    final idx = oneBasedNumber - 1;
    if (idx < 0 || idx >= questions.length) return false;
    currentIndex = idx;
    answerVisible = false;
    notifyListeners();
    return true;
  }

  Future<void> jumpToQuestionIdFromOverview(int questionId) async {
    if (filterMode != 'All') {
      filterMode = 'All';
      await saveSettings();
      _applyFilterAndRandom();
    }
    final idx = questions.indexWhere((q) => q.id == questionId);
    if (idx >= 0) {
      currentIndex = idx;
      answerVisible = false;
      notifyListeners();
    }
  }

  Future<void> clearProgress() async {
    await AppDatabase.clearStatuses();
    statusByQuestionId = {};
    _applyFilterAndRandom();
    currentIndex = 0;
    notifyListeners();
  }

  void showAnswer() {
    answerVisible = true;
    notifyListeners();
  }
}
