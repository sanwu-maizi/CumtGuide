import 'package:flutter/material.dart';
import 'package:cumt_guide/HomePage/button_index/button_index.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 90,
            child: Container(
              color: Color(0xFFF4FAFF),
              child: Row(
                children: [
                  Expanded(
                    flex: 21,
                    child: Column(
                      children: [
                        // Container(
                        //   height:
                        //
                        //   child: CircleAvatar(
                        //     radius:
                        //         MediaQuery.of(context).size.width * 0.21 * 0.9,
                        //     backgroundImage: AssetImage("assets/2.jpg"),
                        //   ),
                        // ),
                        Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *
                        0.03, bottom: MediaQuery.of(context).size.height *
                  0.03),
                          child: CircleAvatar(
                            radius:
                            MediaQuery.of(context).size.width * 0.21 * 0.45,
                            backgroundImage: AssetImage("assets/2.jpg"),
                          ),),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *
                              0.01, bottom: MediaQuery.of(context).size.height *
                              0.02),
                          child: ButtonIndex(
                            outerColor: Color(0xFFD1EBFF),
                            innerColor: Colors.white,
                            child: Icon(
                              Icons.search,
                              size: 40,
                              color: Color(0xFF88ABDA),
                            ),
                          ),),
                        Expanded(
                          child: ListView(
                            children: List.generate(items.length, (index) {
                              return Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *
                                    0.008, bottom: MediaQuery.of(context).size.height *
                                    0.008),
                                child: ButtonIndex(
                                  outerColor: Color(0xFFD1EBFF),
                                  innerColor: Colors.white,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:
                                    Text(
                                        items[index],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlueAccent,
                                        ),
                                      ),
                                  ),
                                ),);
                            }),
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
