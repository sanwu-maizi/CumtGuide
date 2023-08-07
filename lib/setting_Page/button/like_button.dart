import 'package:flutter/material.dart';
class LikeProvider with ChangeNotifier{
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
}