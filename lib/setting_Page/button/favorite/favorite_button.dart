import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../content_entity.dart';

class FavoriteProvider with ChangeNotifier {
  List<ContentEntity> _favorites = [];

  List<ContentEntity> get favorites => _favorites;

  bool _isLiked = false;

  bool get isLiked => _isLiked;

  void like() {
    _isLiked = true;
    notifyListeners();
  }

  void unlike() {
    _isLiked = false;
    notifyListeners();
  }

  Future<void> check(ContentEntity content)async {
    bool flag=true;
    for(int i=0;i<favorites.length;i++){
      if(favorites[i].data!.id==content.data!.id&&favorites[i].data!.title==content.data!.title&&favorites[i].data!.content==content.data!.content){
        flag=false;
        break;
      }
    }
    if(flag){
      _isLiked=false;
    }else{
      _isLiked=true;
    }
  }

  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList('favorites') ?? [];
      _favorites = favoritesJson.map((json) => ContentEntity.fromJson(Map<String, dynamic>.from(jsonDecode(json)))).toList();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  Future<void> addToFavorites(ContentEntity content) async {
    bool flag=true;
    for(int i=0;i<favorites.length;i++){
      if(favorites[i].data!.id==content.data!.id&&favorites[i].data!.title==content.data!.title&&favorites[i].data!.content==content.data!.content){
        flag=false;
        break;
      }
    }

    if (flag&&_isLiked==true) {
      _favorites.add(content);
      await _saveFavoritesToPrefs();
      notifyListeners();
    }
  }

  Future<void> removeFromFavorites(ContentEntity content) async {
    bool flag=false;
    int m=0;
    for(int i=0;i<favorites.length;i++){
      if(favorites[i].data!.id==content.data!.id&&favorites[i].data!.title==content.data!.title&&favorites[i].data!.content==content.data!.content){
        flag=true;m=i;
        break;
      }
    }
    if (flag) {
      _favorites.remove(favorites[m]);
      await _saveFavoritesToPrefs();
      notifyListeners();
    }
  }

  Future<void> clearFavorites() async {
    _favorites.clear();
    await _saveFavoritesToPrefs();
    notifyListeners();
  }

  Future<void> _saveFavoritesToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = _favorites.map((content) => jsonEncode(content.toJson())).toList();
      await prefs.setStringList('favorites', favoritesJson);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

}
