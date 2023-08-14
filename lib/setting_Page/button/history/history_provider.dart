import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../dio/ConcretePage/content_entity.dart';

class HistoryProvider with ChangeNotifier {
  List<ContentEntity> _history = [];

  List<ContentEntity> get history => _history;

  Future<void> loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getStringList('history') ?? [];
      _history = historyJson.map((json) => ContentEntity.fromJson(Map<String, dynamic>.from(jsonDecode(json)))).toList();
    } catch (e) {
      print('Error loading history: $e');
    }
  }

  Future<void> addToHistory(ContentEntity content) async {
    bool flag = true;
    for (int i = 0; i < _history.length; i++) {
      if (_history[i].data!.id == content.data!.id &&
          _history[i].data!.title == content.data!.title &&
          _history[i].data!.content == content.data!.content) {
        flag = false;
        break;
      }
    }

    if (flag) {
      _history.add(content);
      await _saveHistoryToPrefs();
      notifyListeners();
    }
  }

  Future<void> removeFromHistory(ContentEntity content) async {
    bool flag = false;
    int index = -1;
    for (int i = 0; i < _history.length; i++) {
      if (_history[i].data!.id == content.data!.id &&
          _history[i].data!.title == content.data!.title &&
          _history[i].data!.content == content.data!.content) {
        flag = true;
        index = i;
        break;
      }
    }

    if (flag) {
      _history.removeAt(index);
      await _saveHistoryToPrefs();
      notifyListeners();
    }
  }

  Future<void> clearHistory() async {
    _history.clear();
    await _saveHistoryToPrefs();
    notifyListeners();
  }

  Future<void> _saveHistoryToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = _history.map((content) => jsonEncode(content.toJson())).toList();
      await prefs.setStringList('history', historyJson);
    } catch (e) {
      print('Error saving history: $e');
    }
  }
}
