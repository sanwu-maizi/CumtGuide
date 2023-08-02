import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main1.dart';
import '../prefs.dart';
import '../theme/theme_color.dart';
import 'drawer_button.dart';
import '../config.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 80.0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius:
                                MediaQuery.of(context).size.width * 0.21 * 0.8,
                            backgroundImage: AssetImage("assets/2.jpg"),
                          ),
                          Text('maizi',
                              style: TextStyle(
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
                        icon: Icon(Icons.close),
                        iconSize:
                            MediaQuery.of(context).size.width * 0.21 * 0.5,
                        onPressed: () {
                          toMyHomePage(context);
                        })),
              ],
            ),
          ),
          Expanded(
            flex: 4,
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
                      AboutButton(),
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
                      UpdatecheckButton(),
                      Divider(
                        color: Colors.black12,
                        thickness: 1,
                      ),
                      QQButtom(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Expanded(
              flex: 1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.nightlight_round),
                          onPressed: () {
                            setState(() {
                              Prefs.isDark=(Prefs.isDark=='true')?'false':'true';
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .setThemeData(Prefs.isDark=='false'
                                  ? AppTheme.darkTheme().themeData
                                  : AppTheme.LightTheme().themeData);
                            });
                          },
                        ),
                        Text("夜间模式"),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Image.asset('assets/qq.png'),
                          onPressed: () {},
                        ),
                        Text("内测群"),
                      ],
                    ),
                  ]))
        ],
      ),
    );
  }
}
