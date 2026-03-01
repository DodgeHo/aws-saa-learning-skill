import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

// simple web database using sembast; questions are loaded from a JSON asset
class AppDatabase {
  static Database? _db;
  static final _questionStore = stringMapStoreFactory.store('questions');
  static final _statusStore = intMapStoreFactory.store('user_status');

  static Future<Database> getInstance() async {
    if (_db != null) return _db!;

    // open sembast database; on web it uses IndexedDB automatically
    _db = await databaseFactoryWeb.openDatabase('aws_saa_trainer.db');
    // load questions if empty
    final count = await _questionStore.count(_db!);
    if (count == 0) {
      await _importQuestionsFromJson();
    }
    return _db!;
  }

  static Future<void> _importQuestionsFromJson() async {
    final data = await rootBundle.loadString('assets/questions.json');
    final List<dynamic> list = json.decode(data);
    final records = list.map((e) => Map<String, dynamic>.from(e)).toList();
    await _questionStore.records(records.map((r) => r['id'].toString()).toList()).put(_db!, records);
  }

  static Future<List<Map<String, dynamic>>> fetchQuestions({String? filterStatus}) async {
    final db = await getInstance();
    final finder = Finder();
    if (filterStatus != null) {
      // join by status; perform separate query
      final statusMap = await _statusStore.find(db, finder: Finder(filter: Filter.equals('status', filterStatus)));
      final ids = statusMap.map((e) => e['question_id'].toString()).toList();
      if (ids.isEmpty) return [];
      finder.filter = Filter.inList('id', ids);
    }
    final records = await _questionStore.find(db, finder: finder);
    return records.map((r) => Map<String, dynamic>.from(r.value)).toList();
  }

  static Future<String?> getStatus(int questionId) async {
    final db = await getInstance();
    final recs = await _statusStore.find(db, finder: Finder(filter: Filter.equals('question_id', questionId), sortOrders: [SortOrder('timestamp', false)], limit: 1));
    if (recs.isNotEmpty) return recs.first.value['status'] as String;
    return null;
  }

  static Future<void> setStatus(int questionId, String status) async {
    final db = await getInstance();
    // remove previous for simplicity
    await _statusStore.delete(db, finder: Finder(filter: Filter.equals('question_id', questionId)));
    await _statusStore.add(db, {'question_id': questionId, 'status': status, 'timestamp': DateTime.now().toIso8601String()});
  }

  /// status counts
  static Future<Map<String,int>> countByStatus() async {
    final db = await getInstance();
    final recs = await _statusStore.find(db);
    final Map<String,int> m = {};
    for (var r in recs) {
      final st = r['status'] as String;
      m[st] = (m[st] ?? 0) + 1;
    }
    return m;
  }
}
