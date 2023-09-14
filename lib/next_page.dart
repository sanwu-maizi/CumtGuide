import 'package:cumt_guide/SettingPage/button/favorite/favorite_button.dart';
import 'package:cumt_guide/SettingPage/button/favorite/favorite_page.dart';
import 'package:cumt_guide/SettingPage/button/history/history_page.dart';
import 'package:cumt_guide/SettingPage/button/history/history_provider.dart';
import 'package:cumt_guide/SettingPage/button/like_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


import 'dio/ConcretePage/content_entity.dart';
import 'dio/ConcretePage/content_model.dart';

class NextPage extends StatefulWidget {
  final String articleId;

  const NextPage({Key? key, required this.articleId}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> with AutomaticKeepAliveClientMixin{
  final ContentModel _model = ContentModel();
  final ScrollController _controller = ScrollController();
  bool flag2 = true;
  var _futureBuilderFuture;

  final Debouncer _debouncer = Debouncer();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteProvider>(context, listen: false).loadFavorites();
    Provider.of<HistoryProvider>(context, listen: false).loadHistory();
    String s='http://ekkosblog.online:9999/articleDetails/${widget.articleId}';
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
    final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
    favoriteProvider.addToFavorites(news);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ContentEntity?>(
        key: UniqueKey(),
        initialData: null,
        future: _futureBuilderFuture,
        builder: (BuildContext context, AsyncSnapshot<ContentEntity?> snapshot) {
           if (snapshot.hasData) {
            FavoriteProvider favoriteProvider=Provider.of<FavoriteProvider>(context);
            favoriteProvider.check(snapshot.data!);
            Provider.of<HistoryProvider>(context, listen: false).addHistory(snapshot.data!);
            return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: AppBar(
                  elevation: 0.3,
                  backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
                              backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.012), // 设置四个角的圆角半径为 10.0
                              ),
                              content: SingleChildScrollView( // 使用SingleChildScrollView包裹内容
                                child: Container(
                                  color: Theme.of(context).colorScheme.primary,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:EdgeInsets.all(MediaQuery.of(context).size.height*0.008),
                                        child: Text(
                                          '功能尚未开放，若你需要使用这个功能，请联系我们!\nヾ(❀╹◡╹)ﾉﾞ❀~\n(也可以留下您的联系方式，方便我们及时联络您)',
                                          style: TextStyle(
                                              color: Theme.of(context).textTheme.headline1!.color
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context).dialogTheme.backgroundColor, // 设置按钮的背景颜色为蓝色
                                  ),
                                  child: Text('取消',style: TextStyle(
                                      color: Theme.of(context).textTheme.headline1!.color
                                  ),),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context).dialogTheme.backgroundColor, // 设置按钮的背景颜色为蓝色
                                  ),
                                  child: Text('确定',style: TextStyle(
                                      color: Theme.of(context).textTheme.headline1!.color
                                  )),
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
                                    child: MarkdownBody(data: snapshot.data!.data!.content!)
                                )
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
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Consumer<LikeProvider>(
                          builder: (context, likeProvider, child) {
                            return InkWell(
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
                                    color: likeProvider.isLiked ? Colors.blue : Theme.of(context).iconTheme.color,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.014,
                                  ),
                                  Text(snapshot.data!.data!.likes!.toString())
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.032),
                        Consumer<FavoriteProvider>(
                          builder: (context, favoriteProvider, child) {
                            return InkWell(
                              onTap: () {
                                if (favoriteProvider.isLiked) {
                                  favoriteProvider.unlike();
                                } else {
                                  favoriteProvider.like();
                                }
                                if (favoriteProvider.isLiked) {
                                  _onNewsSelected(context, snapshot.data!);
                                } else {
                                  _onNewsDeselected(context, snapshot.data!);
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_border,
                                    color: favoriteProvider.isLiked ? Colors.blue : Theme.of(context).iconTheme.color,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.01,
                                  ),
                                  Text(snapshot.data!.data!.likes!.toString())
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.032),
                      ],
                    )),
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                      heroTag: "btn1",
                      onPressed: () {
                        _debouncer.debounce(const Duration(milliseconds: 500),(){
                          _controller.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                      },
                      shape: const CircleBorder(),
                      child: const Icon(Icons.arrow_upward),
                    )
                  ],
                )
            );
          } else {
            return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: AppBar(
                  elevation: 0.3,
                  backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
                                  child: const Column(
                                    children: [
                                      Text(
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
                body: Center(
                  child: Image.asset("assets/1.gif"),
                ),
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      foregroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
                      backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                      heroTag: "btn1",
                      onPressed: () {
                        _controller.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      shape: const CircleBorder(),
                      child: Icon(Icons.arrow_upward),
                    )
                  ],
                )
            );
          }
        });
  }
}
