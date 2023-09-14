import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../../dio/ConcretePage/content_entity.dart';
import '../like_button.dart';
import 'favorite_button.dart';

class FavoriteView extends StatefulWidget {
  final ContentEntity news;
  FavoriteView({super.key, required this.news});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final ScrollController _controller = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteProvider>(context, listen: false).loadFavorites();
  }

  void _onNewsDeselected(BuildContext context, ContentEntity news) {
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
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
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);

    // 添加到收藏列表
    favoriteProvider.addToFavorites(news);
  }

  @override
  Widget build(BuildContext context) {
    LikeProvider likeProvider = Provider.of<LikeProvider>(context);
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);
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
                        left: MediaQuery.of(context).size.height * 0.00125,
                        top: MediaQuery.of(context).size.height * 0.00125),
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
                          top: MediaQuery.of(context).size.height * 0.019),
                      height: MediaQuery.of(context).size.height * 0.094,
                      child: Text(
                        widget.news.data!.title!,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.030,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.001),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Text(
                        widget.news.data!.updateTime!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    Center(
                      child: Column(children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: MarkdownBody(data: widget.news.data!.content!))
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
                        color:
                            likeProvider.isLiked ? Colors.blue : Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.014),
                      Text(widget.news.data!.likes!.toString())
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.032),
                InkWell(
                  onTap: () {
                    if (favoriteProvider.isLiked) {
                      favoriteProvider.unlike();
                    } else {
                      favoriteProvider.like();
                    }
                    if (favoriteProvider.isLiked) {
                      _onNewsSelected(context, widget.news);
                    } else {
                      _onNewsDeselected(context, widget.news);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        color: favoriteProvider.isLiked
                            ? Colors.blue
                            : Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(widget.news.data!.likes!.toString())
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.032),
              ],
            )),
        floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
          backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          onPressed: () {
            _controller.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_upward),
        ));
  }
}
