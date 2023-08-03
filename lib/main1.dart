import 'package:bot_toast/bot_toast.dart';
import 'package:cumt_guide/util/prefs.dart';
import 'package:cumt_guide/setting_Page/settings.dart';
import 'package:cumt_guide/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:cumt_guide/HomePage/button_index/button_index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'util/config.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();
  runApp((MultiProvider(
    providers: [
      //用于主题切换
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(UIConfig.designWidth, UIConfig.designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          //主题切换
          theme: Provider.of<ThemeProvider>(context).themeData,
          debugShowCheckedModeBanner: false,
          builder: BotToastInit(),
          //toast弹窗的初始化
          navigatorObservers: [BotToastNavigatorObserver()],
          home: child,
        );
      },
      //判断是否选择学校
      child:  const MyHomePage(),
    );
  }
}

toMyHomePage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const MyHomePage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = [
    '教务信息',
    '医保',
    '转专业',
    '新生指南',
    '教务信息1',
    '教务信息2',
    '教务信息3',
    '教务信息4',
    '教务信息',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Theme.of(context).cardTheme.color,
      body: Column(
        children: [
          Expanded(
            flex: 90,
            child: Container(
              color: Theme.of(context).cardTheme.color,
              child: Row(
                children: [
                  Expanded(
                    flex: 21,
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *
                        0.03, bottom: MediaQuery.of(context).size.height *
                  0.03),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width * 0.21 * 0.45,
                                backgroundImage: AssetImage("assets/2.jpg"),
                              ),
                              Material(
                                color: Colors.transparent,
                                shape: CircleBorder(), //圆形
                                child: Container(
                                  height: MediaQuery.of(context).size.width * 0.21 * 0.45,
                                  child:InkWell(
                                  borderRadius: BorderRadius.circular(1000),
                                  radius :MediaQuery.of(context).size.width * 0.21 * 0.45,
                                  onTap: () {
                                    toSettingPage(context);
                                  },
                                ),),
                              )
                            ],
                          ),),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *
                              0.01, bottom: MediaQuery.of(context).size.height *
                              0.02),
                          child: ButtonIndex(
                            outerColor: Theme.of(context).canvasColor,
                            innerColor: Colors.white,
                            child: Icon(
                              Icons.search,
                              size: 40,
                              color: Color(0xFF88ABDA),
                            ),
                          ),),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                            children: List.generate(items.length, (index) {
                              return Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *
                                    0.008, bottom: MediaQuery.of(context).size.height *
                                    0.008),
                                child: ButtonIndex(
                                  outerColor: Theme.of(context).canvasColor,
                                  innerColor: Colors.white,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:
                                    Text(
                                        items[index],
                                        style: TextStyle(
                                          fontSize: UIConfig.fontSizeSidebar,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlueAccent,
                                        ),
                                      ),
                                  ),
                                ),);
                            }),
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    width: 1,
                  ),
                  Expanded(
                    flex: 79,
                    child: Container(
                      // 右侧顶部图片
                      height: MediaQuery.of(context).size.height * 0.90,
                      color: Colors.white,
                      child: Text("part4"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              color: Color(0xFFE9F4FC),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.star),
                      Text("指南"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.refresh),
                      Text("动态"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
