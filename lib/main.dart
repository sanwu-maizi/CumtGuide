import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cumt_guide/setting_Page/button/favorite/favorite_button.dart';
import 'package:cumt_guide/setting_Page/button/history/history_provider.dart';
import 'package:cumt_guide/setting_Page/button/like_button.dart';
import 'package:cumt_guide/util/prefs.dart';
import 'package:cumt_guide/setting_Page/settings.dart';
import 'package:cumt_guide/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:cumt_guide/HomePage/button/button_index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cumt_guide/dio/Articletype/Articletype_model.dart';
import 'package:cumt_guide/dio/search/search_page.dart';

import 'dio/Articletype/Articletype_entity.dart';
import 'dio/search/search_provider.dart';
import 'next_page.dart';
import 'util/config.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();
  runApp((MultiProvider(
    providers: [
      //用于主题切换
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => LikeProvider()),
      ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
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

  String  s="http://ekkosblog.online:9999/types";

  var _futureBuilder;

  final DioModel _model=DioModel();
  @override
  void initState(){
    super.initState();
    _futureBuilder=_model.getData(s);
  }

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
                                backgroundImage: FileImage(File(Prefs.avatarImagePath)),
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
                          child: FutureBuilder<DioEntity?>(
                            future: _futureBuilder,
                            builder: (BuildContext context, AsyncSnapshot<DioEntity?> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Display loading indicator while waiting
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                return SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Wrap(
                                        spacing: MediaQuery.of(context).size.width * 0.02,
                                        children: List.generate(snapshot.data!.data!.length, (index) {
                                          String text = snapshot.data!.data![index].typeName!;
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              top: MediaQuery.of(context).size.height * 0.008,
                                              bottom: MediaQuery.of(context).size.height * 0.008,
                                            ),
                                            child: ButtonIndex(
                                              outerColor: Theme.of(context).canvasColor,
                                              innerColor: Colors.white,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  text,
                                                  style: TextStyle(
                                                    fontSize: UIConfig.fontSizeSidebar,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.lightBlueAccent,
                                                  ),
                                                  overflow: TextOverflow.visible,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.75,
                                  color: Colors.white,
                                );
                              }
                            },
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
                      child: Column(
                        children: [
                          Expanded(
                            flex:2,
                            child: Image.asset("assets/img.png",fit: BoxFit.fill),
                          ),
                          Expanded(
                            flex:8,
                            child: FutureBuilder<DioEntity?>(
                                future: _futureBuilder,
                                builder: (BuildContext context, AsyncSnapshot<DioEntity?> snapshot){
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.data!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => NextPage()),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200], // 背景颜色
                                              borderRadius: BorderRadius.circular(10.0), // 圆角
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(1), // 阴影颜色
                                                  spreadRadius: 1,
                                                  blurRadius: 4,
                                                  offset: Offset(3, 3), // 阴影偏移
                                                ),
                                              ],
                                            ),
                                            margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 13.0),
                                            padding: EdgeInsets.fromLTRB(15.0,5.0,5.0,5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data!.data![index].id!,
                                                  style: TextStyle(
                                                    fontSize: 18, // 标题字体大小偏大
                                                    fontWeight: FontWeight.bold, // 标题字体加粗
                                                    color: Colors.grey[600], // 标题字体颜色
                                                  ),
                                                ),
                                                SizedBox(height: 5), // 间距
                                                Text(
                                                  "Date: ${snapshot.data!.data![index].id}",
                                                  style: TextStyle(
                                                    fontSize: 14, // 内容字体大小偏小
                                                    color: Colors.grey[300], // 内容字体颜色
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }else{
                                    return Container(height:MediaQuery.of(context).size.height * 0.75,
                                        color: Colors.white
                                    );
                                  }
                                }),
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              color: Theme.of(context).colorScheme.primary,
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
