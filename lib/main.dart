import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 78,
            child: Row(
              children: [
                Expanded(
                  flex: 21,
                  child: Column(
                    children: [
                      Container(
                        // 用户头像
                        height: MediaQuery.of(context).size.height * 0.78 * 0.21 * 0.15,
                        // 添加你的用户头像部分的代码
                      ),
                      Container(
                        // 搜索icon
                        height: MediaQuery.of(context).size.height * 0.78 * 0.21 * 0.7,
                        // 添加你的搜索icon部分的代码
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            // 可竖直拖动的list
                            // 占左侧栏的高度70%
                            height: MediaQuery.of(context).size.height * 0.78 * 0.21 * 0.7,
                            // 添加你的可竖直拖动的list部分的代码
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 79,
                  child: Container(
                    // 右侧顶部图片
                    height: MediaQuery.of(context).size.height * 0.78,
                    child: Image.asset(
                      'your_image_path',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 22,
            child: Container(
              // 导航栏
              // 添加你的导航栏部分的代码
            ),
          ),
        ],
      ),
    );
  }
}
