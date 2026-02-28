import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db.dart';
import 'models.dart';

class AppModel extends ChangeNotifier {
  List<Question> questions = [];
  int currentIndex = 0;
  String? status;

  // settings
  String aiProvider = 'deepseek';
  String apiKey = '';
  double fontSize = 11;

  String filterMode = 'All';
  bool randomOrder = false;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    aiProvider = prefs.getString('ai_provider') ?? 'deepseek';
    apiKey = prefs.getString('api_key') ?? '';
    fontSize = prefs.getDouble('font_size') ?? 11;
    filterMode = prefs.getString('filter_mode') ?? 'All';
    randomOrder = prefs.getBool('random_order') ?? false;
    notifyListeners();
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ai_provider', aiProvider);
    await prefs.setString('api_key', apiKey);
    await prefs.setDouble('font_size', fontSize);
    await prefs.setString('filter_mode', filterMode);
    await prefs.setBool('random_order', randomOrder);
  }

  Future<void> loadQuestions() async {
    String? dbFilter;
    if (filterMode != 'All') dbFilter = filterMode;
    final rows = await AppDatabase.fetchQuestions(filterStatus: dbFilter);
    questions = rows.map((r) => Question.fromMap(r)).toList();
    if (randomOrder) {
      questions.shuffle();
    }
    currentIndex = 0;
    await loadStatus();
    notifyListeners();
  }

  Future<void> loadStatus() async {
    if (questions.isEmpty) return;
    status = await AppDatabase.getStatus(currentQuestion!.id);
    notifyListeners();
  }

  Question? get currentQuestion {
    if (questions.isEmpty) return null;
    if (currentIndex < 0 || currentIndex >= questions.length) return null;
    return questions[currentIndex];
  }

  void next() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
      loadStatus();
      notifyListeners();
    }
  }

  void prev() {
    if (currentIndex > 0) {
      currentIndex--;
      loadStatus();
      notifyListeners();
    }
  }

  Future<void> mark(String st) async {
    if (currentQuestion == null) return;
    await AppDatabase.setStatus(currentQuestion!.id, st);
    await loadStatus();
    if (filterMode != 'All') {
      // reload questions to reflect filter
      await loadQuestions();
    }
    notifyListeners();
  }
}
