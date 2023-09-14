import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../util/prefs.dart';
import '../theme/theme_color.dart';
import 'drawer_button.dart';
import '../util/config.dart';
import 'dart:io';

toSettingPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const SettingPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController nameController = TextEditingController();

  String avatarImagePath = ''; // 添加这一行来保存头像路径

  File? _imageFile;

  @override
  void initState() {
    Prefs.init();
    nameController.text = Prefs.cumtLoginUsername;
    avatarImagePath = Prefs.avatarImagePath;
    _imageFile = File(avatarImagePath); // 初始化avatarImagePathController
    super.initState();
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      Prefs.avatarImagePath = pickedFile.path;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 75.0, 0, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // if (_imageFile == null)
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width *
                                  0.21 *
                                  0.8,
                              backgroundImage: const AssetImage('assets/2.jpg'),
                            ),
                          // else
                            // Container(
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //   ),
                            // ),
                            // CircleAvatar(
                            //   radius: MediaQuery.of(context).size.width *
                            //       0.21 *
                            //       0.8,
                            //   child: PhotoView(
                            //     imageProvider: FileImage(_imageFile!),
                            //   ),
                            // ),
                          Text(Prefs.cumtLoginUsername,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                fontSize: UIConfig.fontSizeUsername,
                                fontWeight: FontWeight.bold,
                                height: 1.5, //设置高度居中
                              )),
                        ],
                      ),
                      // 右侧关闭按钮
                    ],
                  ),
                ),
                Positioned(
                    right: MediaQuery.of(context).size.width * 0.21 * 0.3,
                    top: MediaQuery.of(context).size.width * 0.21 * 0.5,
                    child: IconButton(
                        icon: const Icon(Icons.close),
                        color: Theme.of(context).textTheme.headline1!.color,
                        iconSize:
                            MediaQuery.of(context).size.width * 0.21 * 0.5,
                        onPressed: () {
                          Navigator.of(context).pop();
                        })),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.21 * 0.38,
                  top: MediaQuery.of(context).size.width * 0.21 * 1.6,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                    color: Theme.of(context).iconTheme.color,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              title: Text(
                                '编辑资料',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: nameController,
                                    decoration:
                                        InputDecoration(hintText: '用户名'),
                                  ),
                                  SizedBox(height: 16),
                                  // ElevatedButton(
                                  //   style: ElevatedButton.styleFrom(
                                  //     backgroundColor: Theme.of(context)
                                  //         .dialogTheme
                                  //         .backgroundColor,
                                  //     textStyle: TextStyle(
                                  //         fontSize: UIConfig
                                  //             .fontAlertText), // 调整按钮字体大小
                                  //   ),
                                  //   child: Text(
                                  //     '选择头像',
                                  //     style: TextStyle(
                                  //         color: Theme.of(context)
                                  //             .textTheme
                                  //             .headline1!
                                  //             .color),
                                  //   ),
                                  //   onPressed: () async {
                                  //     final picker = ImagePicker();
                                  //     final pickedFile = await picker.pickImage(
                                  //         source: ImageSource.gallery);
                                  //     if (pickedFile != null) {
                                  //       final newImagePath = pickedFile.path;
                                  //       // 保存新的本地路径到Prefs
                                  //       Prefs.avatarImagePath = newImagePath;
                                  //       setState(() {
                                  //         // 更新头像显示
                                  //         avatarImagePath = newImagePath;
                                  //       });
                                  //     }
                                  //   },
                                  // ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .dialogTheme
                                          .backgroundColor,
                                      textStyle: TextStyle(
                                          fontSize: UIConfig
                                              .fontAlertText), // 调整按钮字体大小
                                    ),
                                    child: Text(
                                      '确认',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .color),
                                    ),
                                    onPressed: () {
                                      // 保存用户名和头像路径到本地
                                      Prefs.cumtLoginUsername =
                                          nameController.text;
                                      Navigator.pop(context);
                                      setState(() {}); // 刷新页面
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Container(
                    padding: EdgeInsets.all(UIConfig.paddingAll),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(UIConfig.borderRadiusEntry),
                        color: Theme.of(context).colorScheme.primary),
                    child: Column(
                      children: const [
                        FavoriteButton(),
                        Divider(
                          color: Colors.black12,
                          thickness: 1,
                        ),
                        HistoryButton(),
                        Divider(
                          color: Colors.black12,
                          thickness: 1,
                        ),
                        FeedBackButton(),
                        Divider(
                          color: Colors.black12,
                          thickness: 1,
                        ),
                        ShareApp(),
                        Divider(
                          color: Colors.black12,
                          thickness: 1,
                        ),
                        AboutButton(),
                        Divider(
                          color: Colors.black12,
                          thickness: 1,
                        ),
                        UpdatecheckButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Expanded(
              flex: 1,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.nightlight_round,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                      onPressed: () {
                        setState(() {
                          Prefs.isDark =
                              (Prefs.isDark == 'true') ? 'false' : 'true';
                          Provider.of<ThemeProvider>(context, listen: false)
                              .setThemeData(Prefs.isDark == 'false'
                                  ? AppTheme.darkTheme().themeData
                                  : AppTheme.LightTheme().themeData);
                        });
                      },
                    ),
                    Text(
                      "夜间模式",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color),
                    ),
                  ],
                ),
                SizedBox(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.08,
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/qq.png'),
                      onPressed: () {
                        launchUrl(
                            Uri.parse('https://jq.qq.com/?_wv=1027&k=RPprjgMn'),
                            mode: LaunchMode.externalApplication);
                      },
                    ),
                    Text(
                      "内测群",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color),
                    ),
                  ],
                ),
              ]))
        ],
      ),
    );
  }
}
