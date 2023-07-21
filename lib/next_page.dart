import 'package:cumt_guide/content_entity.dart';
import 'package:cumt_guide/content_model.dart';
import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final ContentModel _model = ContentModel();
  final ScrollController _controller = ScrollController();
  bool flag1 = true;
  bool flag2 = true;
  var _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = _model.getData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ContentEntity?>(
        key: UniqueKey(),
        future: _futureBuilderFuture,
        builder:
            (BuildContext context, AsyncSnapshot<ContentEntity?> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      print(snapshot.data!.toString());
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
                                child: Column(children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  const Text(
                                      '功能尚未开放，若你需要使用这个功能，请联系我们!\nヾ(❀╹◡╹)ﾉﾞ❀~\n(也可以留下您的联系方式，方便我们及时联络您)')
                                ])),
                            actions: [
                              TextButton(
                                child: const Text('取消'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('确定'),
                                onPressed: () {
                                  // 执行确定操作
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  children: [
                    Row(children: [
                      Container(
                          padding: EdgeInsets.only(
                              left:
                                  MediaQuery.of(context).size.height * 0.00125,
                              top:
                                  MediaQuery.of(context).size.height * 0.00125),
                          height: MediaQuery.of(context).size.height * 0.035,
                          child: const Text(
                            "目录:教务信息>xxx>xxxx",
                            style: TextStyle(color: Colors.grey),
                          ))
                    ]),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.019),
                            height: MediaQuery.of(context).size.height * 0.094,
                            child: Text(
                              snapshot.data!.data != null
                                  ? _model.data!.data!.title!
                                  : "文章标题",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.030,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.001),
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Text(
                              snapshot.data!.data != null
                                  ? "更新时间:" + _model.data!.data!.updateTime!
                                  : '更新时间:xxxx年xx月xx日',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          Center(
                            child: Column(children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                  child: Text(snapshot.data!.data!.content!))
                            ]),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            flag1 = !flag1;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_up_alt_outlined,
                              color: flag1 ? Colors.white : Colors.blue,
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.014),
                            Text("999")
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.032),
                      InkWell(
                        onTap: () {
                          setState(() {
                            flag2 = !flag2;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              color: flag2 ? Colors.white : Colors.blue,
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.01),
                            Text("999")
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.032),
                    ],
                  )),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _controller.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                shape: const CircleBorder(),
                child: const Icon(Icons.arrow_upward),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          print(snapshot.data!.data);
                          return AlertDialog(
                            content: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                child: Column(children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  const Text(
                                      '功能尚未开放，若你需要使用这个功能，请联系我们!\nヾ(❀╹◡╹)ﾉﾞ❀~\n(也可以留下您的联系方式，方便我们及时联络您)')
                                ])),
                            actions: [
                              TextButton(
                                child: const Text('取消'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('确定'),
                                onPressed: () {
                                  // 执行确定操作
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              body: Text(" "),
              bottomNavigationBar: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            flag1 = !flag1;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_up_alt_outlined,
                              color: flag1 ? Colors.white : Colors.blue,
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.014),
                            Text("999")
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.032),
                      InkWell(
                        onTap: () {
                          setState(() {
                            flag2 = !flag2;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              color: flag2 ? Colors.white : Colors.blue,
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.01),
                            Text("999")
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.032),
                    ],
                  )),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _controller.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                shape: const CircleBorder(),
                child: const Icon(Icons.arrow_upward),
              ),
            );
          }
        });
  }
}
