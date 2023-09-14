import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider with ChangeNotifier {
  List<String> _history = [];

  List<String> get history => _history;

  Future<void> loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _history = prefs.getStringList('search') ?? [];
    } catch (e) {
      print('Error loading history: $e');
    }
  }

  Future<void> addToHistory(String query) async {
    if(_history.contains(query)){
      _history.remove(query);
      _history.add(query);
      await _saveHistoryToPrefs();
      notifyListeners();
    } else {
      if(query!=" "&&query!="  "&&query!="   ")_history.add(query);
      await _saveHistoryToPrefs();
      notifyListeners();

    }
  }

  Future<void> removeFromHistory(String query) async {
    if (_history.contains(query)) {
      _history.remove(query);
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
      await prefs.setStringList('search', _history);
    } catch (e) {
      print('Error saving history: $e');
    }
  }
}
