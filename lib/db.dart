import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> getInstance() async {
    if (_db != null) return _db!;

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'data.db');

    // copy from asset if not yet present
    if (!await File(path).exists()) {
      await _copyAssetDb(path);
    }

    _db = await openDatabase(path);
    return _db!;
  }

  static Future<void> _copyAssetDb(String path) async {
    final data = await rootBundle.load('assets/data.db');
    final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);
  }

  // questions
  static Future<List<Map<String, dynamic>>> fetchQuestions({String? filterStatus}) async {
    final db = await getInstance();
    // if filtering by status, join with user_status
    if (filterStatus != null) {
      return await db.rawQuery('''
        SELECT q.* FROM questions q
        JOIN user_status s ON s.question_id=q.id
        WHERE s.status=?
      ''', [filterStatus]);
    }
    return await db.query('questions');
  }

  // user status operations
  static Future<String?> getStatus(int questionId) async {
    final db = await getInstance();
    final res = await db.query('user_status',
        columns: ['status'],
        where: 'question_id = ?',
        whereArgs: [questionId],
        orderBy: 'rowid DESC',
        limit: 1);
    if (res.isNotEmpty) return res.first['status'] as String;
    return null;
  }

  static Future<void> setStatus(int questionId, String status) async {
    final db = await getInstance();
    await db.delete('user_status', where: 'question_id=?', whereArgs: [questionId]);
    await db.insert('user_status', {
      'question_id': questionId,
      'status': status,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}
