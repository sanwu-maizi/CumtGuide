import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../util/prefs.dart';
import '../theme/theme_color.dart';
import '../util/config.dart';
import 'dart:io';

toDynamicsPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const DynamicsPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class DynamicsPage extends StatefulWidget {
  const DynamicsPage({Key? key}) : super(key: key);

  @override
  State<DynamicsPage> createState() => _DynamicsPageState();
}

class _DynamicsPageState extends State<DynamicsPage> {
  TextEditingController nameController = TextEditingController();
  String avatarImagePath = ''; // 添加这一行来保存头像路径


  @override
  void initState() {
    Prefs.init();
    nameController.text = Prefs.cumtLoginUsername;
    avatarImagePath = Prefs.avatarImagePath; // 初始化avatarImagePathController
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: Text("该功能暂未开放"),
        )
    );
  }
}
