import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  final ThemeData themeData;

  AppTheme(this.themeData);

  factory AppTheme.darkTheme() {
    return AppTheme(
      ThemeData(
        cardTheme: CardTheme(
          color: Colors.grey[700], // 更改Card的颜色
        ),

        dialogTheme: DialogTheme(
          backgroundColor: const Color.fromRGBO(38, 38, 38, 1), // 设置 AlertDialog 的背景颜色
          titleTextStyle: TextStyle(color: Colors.white), // 设置标题文本的颜色
          contentTextStyle: TextStyle(color: Colors.black), // 设置内容文本的颜色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // 设置对话框的圆角
          ),
        ),

        backgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),

        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1), // 设置标题文本颜色为蓝色
            fontWeight: FontWeight.bold, // 设置字体粗细
          ),
          headline2: TextStyle(
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            color: Colors.white, // 设置正文文本颜色为黑色
            fontSize: 16.0, // 设置字体大小
          ),
        ),

        //更改snakbar颜色
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.black54, //背景颜色
            contentTextStyle: TextStyle(color: Colors.white) //文字颜色
            ),

        dialogBackgroundColor: Colors.black12,
        //更改弹窗颜色
        popupMenuTheme: PopupMenuThemeData(
            //更改按钮弹窗颜色
            color: Colors.grey[700]),

        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Color.fromRGBO(235, 240, 251, 1)),
          foregroundColor: MaterialStatePropertyAll(Colors.black),
        )),

        outlinedButtonTheme: const OutlinedButtonThemeData(
            style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Color.fromRGBO(216, 227, 247, 1)),
          foregroundColor: MaterialStatePropertyAll(Colors.black),
        )),

        iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.black26),
        ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white, // 设置图标颜色为白色
          backgroundColor: Color.fromRGBO(38, 38, 38, 1), // 设置背景颜色
        ),

        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white),
        )),

        scaffoldBackgroundColor: ThemeData.dark().cardColor,
        //更改页面顶端颜色
        canvasColor: Colors.white30,
        //更改绘图颜色
        colorScheme: ColorScheme(
          primary: const Color.fromRGBO(38, 38, 38, 1),
          //Picker颜色
          secondary: const Color.fromRGBO(42, 42, 42, 1),
          error: Colors.redAccent[700]!,
          background: Colors.black,
          brightness: Brightness.dark,
          onBackground: Colors.black38,
          onError: const Color.fromRGBO(245, 244, 249, 1),
          onPrimary: Colors.white,
          onSecondary: const Color.fromRGBO(42, 42, 42, 1),
          onSurface: Colors.white,
          surface: Colors.black12,
        ),
      ),
    );
  }

  factory AppTheme.LightTheme() {
    return AppTheme(
      ThemeData(
        cardTheme: const CardTheme(
          color: Colors.white, // 更改Card的颜色
        ),
        canvasColor: Color(0xFFD1EBFF),

        dialogTheme: DialogTheme(
          backgroundColor: Colors.white, // 设置 AlertDialog 的背景颜色
          titleTextStyle: TextStyle(color: Colors.white), // 设置标题文本的颜色
          contentTextStyle: TextStyle(color: Colors.black), // 设置内容文本的颜色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // 设置对话框的圆角
          ),
        ),
        backgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.black, // 设置标题文本颜色为蓝色
            fontWeight: FontWeight.bold, // 设置字体粗细
          ),
          headline2: TextStyle(
            color: Colors.blue,
          ),
          bodyText1: TextStyle(
            color: Colors.blue, // 设置正文文本颜色为黑色
            fontSize: 16.0, // 设置字体大小
          ),
        ),

        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.white, // 设置按钮的背景颜色为蓝色
          textTheme: ButtonTextTheme.primary, // 设置文本主题为主要样式
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.black, // 设置图标颜色为白色
          backgroundColor: Colors.white, // 设置背景颜色
        ),

        //更改snackbar颜色
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: Color.fromRGBO(176, 250, 255, 0.75), //背景颜色
            contentTextStyle: TextStyle(color: Colors.white) //文字颜色
            ),

        dialogBackgroundColor: Colors.grey.shade300,
        //更改弹窗颜色
        popupMenuTheme: const PopupMenuThemeData(
          //更改按钮弹窗颜色
          color: Color.fromRGBO(216, 227, 247, 1),
        ),

        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Color.fromRGBO(235, 240, 251, 1)),
          foregroundColor: MaterialStatePropertyAll(Colors.black),
        )),

        outlinedButtonTheme: const OutlinedButtonThemeData(
            style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Color.fromRGBO(216, 227, 247, 1)),
          foregroundColor: MaterialStatePropertyAll(Colors.black),
        )),

        colorScheme: ColorScheme(
          primary: const Color.fromRGBO(245, 244, 249, 1),
          secondary: Colors.white,
          background: const Color.fromRGBO(245, 244, 249, 1),
          error: Colors.redAccent[700]!,
          brightness: Brightness.light,
          onBackground: Colors.white,
          onError: Colors.white,
          onPrimary: Colors.black,
          onSecondary: Colors.blue,
          onSurface: Colors.lightBlueAccent,
          surface: Colors.white,
        ),
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  static ThemeData _themeData = AppTheme.LightTheme().themeData;
  static Brightness _brightness = Brightness.light;
  static const String _themeKey = 'brightness';

  ThemeData get themeData => _themeData;

  ThemeProvider() {
    loadThemeData();
  }

  Future<void> saveThemeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, _brightness == Brightness.light ? 1 : 0);
  }

  Future<void> setThemeData(ThemeData themeData) async {
    _themeData = themeData;
    _brightness = _themeData.brightness;
    notifyListeners();
    await saveThemeData();
  }

  Future<void> loadThemeData() async {
    final prefs = await SharedPreferences.getInstance();
    final int? isLight = prefs.getInt(_themeKey);
    if (isLight == null || isLight == 1) {
      _brightness = Brightness.light;
    } else {
      _brightness = Brightness.dark;
    }
    updateThemeData();
    notifyListeners();
  }

  void updateThemeData() {
    if (_brightness == Brightness.light) {
      _themeData = AppTheme.LightTheme().themeData;
    } else {
      _themeData = AppTheme.darkTheme().themeData;
    }
  }
}
