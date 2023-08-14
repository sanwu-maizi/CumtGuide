import 'package:cumt_guide/setting_Page/button/favorite/favorite_button.dart';
import 'package:cumt_guide/setting_Page/button/favorite/favorite_page.dart';
import 'package:cumt_guide/setting_Page/button/history/history_page.dart';
import 'package:cumt_guide/setting_Page/button/history/history_provider.dart';
import 'package:cumt_guide/setting_Page/button/like_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dio/ConcretePage/content_entity.dart';
import 'dio/ConcretePage/content_model.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> with AutomaticKeepAliveClientMixin{
  final ContentModel _model = ContentModel();
  final ScrollController _controller = ScrollController();
  bool flag2 = true;
  var _futureBuilderFuture;
  String s='http://ekkosblog.online:9999/articleDetails/1';


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteProvider>(context, listen: false).loadFavorites();
    Provider.of<HistoryProvider>(context, listen: false).loadHistory();
    _futureBuilderFuture = _model.getData(s);
  }

  void _onNewsDeselected(BuildContext context, ContentEntity news) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
    favoriteProvider.removeFromFavorites(news);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNewsSelected(BuildContext context, ContentEntity news) {
    // Add the selected news to the history
    // 使用Provider.of获取FavoriteProvider实例
    final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);

    // 添加到收藏列表
    favoriteProvider.addToFavorites(news);

  }
  @override
  Widget build(BuildContext context) {
    LikeProvider likeProvider = Provider.of<LikeProvider>(context);
    FavoriteProvider favoriteProvider=Provider.of<FavoriteProvider>(context);
    return FutureBuilder<ContentEntity?>(
        key: UniqueKey(),
        future: _futureBuilderFuture,
        builder: (BuildContext context, AsyncSnapshot<ContentEntity?> snapshot) {
          if (snapshot.hasData) {
            favoriteProvider.check(snapshot.data!);
            Provider.of<HistoryProvider>(context, listen: false).addToHistory(snapshot.data!);
            return Scaffold(
                backgroundColor: Theme.of(context).cardTheme.color,
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Theme.of(context).iconTheme.color,
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.share),
                      color: Theme.of(context).iconTheme.color,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SingleChildScrollView( // 使用SingleChildScrollView包裹内容
                                child: Container(
                                  child: Column(
                                    children: [
                                      const Text(
                                        '功能尚未开放，若你需要使用这个功能，请联系我们!\nヾ(❀╹◡╹)ﾉﾞ❀~\n(也可以留下您的联系方式，方便我们及时联络您)',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                    color: Theme.of(context).cardTheme.color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (likeProvider.isLiked) {
                              likeProvider.unlike();
                            } else {
                              likeProvider.like();
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up_alt_outlined,
                                color: likeProvider.isLiked ? Colors.blue : Colors.white,
                              ),
                              SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width * 0.014),
                              Text(snapshot.data!.data!.likes!.toString())
                            ],
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.032),
                        InkWell(
                          onTap: () {
                            if (favoriteProvider.isLiked) {
                              favoriteProvider.unlike();
                            } else {
                              favoriteProvider.like();
                            }
                            if(favoriteProvider.isLiked){
                              _onNewsSelected(context, snapshot.data!);
                            }else{
                              _onNewsDeselected(context, snapshot.data!);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_border,
                                color: favoriteProvider.isLiked ? Colors.blue : Colors.white,
                              ),
                              SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width * 0.01),
                              Text(snapshot.data!.data!.likes!.toString())
                            ],
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.032),
                      ],
                    )),
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Theme.of(context).canvasColor,
                      heroTag: "btn1",
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
                    FloatingActionButton(
                      heroTag: "btn2",
                      backgroundColor: Theme.of(context).canvasColor,
                      onPressed: () {
                        toFavoritePage(context);
                      },
                      shape: const CircleBorder(),
                      child: const Icon(Icons.star_border),
                    ),
                    FloatingActionButton(
                      heroTag: "btn3",
                      backgroundColor: Theme.of(context).canvasColor,
                      onPressed: () {
                        toHistoryPage(context);
                      },
                      shape: const CircleBorder(),
                      child: const Icon(Icons.history),
                    ),
                  ],
                )
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
              body: const Text(" "),
              bottomNavigationBar: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: Row(
                          children: [
                            Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Colors.white
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
                backgroundColor: Theme.of(context).canvasColor,
                child: const Icon(Icons.arrow_upward),
              ),
            );
          }
        });
  }
}
