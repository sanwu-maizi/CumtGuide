import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite_button.dart';
import 'favorite_view.dart'; // 导入FavoriteProvider

toFavoritePage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const FavoritePage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context); // 获取FavoriteProvider
    final favorite = favoriteProvider.favorites;

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text('收藏页面'),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: favorite.length,
          itemBuilder: (context, index) {
            final news = favorite[index];
            return Dismissible(
              key: Key(news.data!.id!), // 使用唯一标识作为key
              direction: DismissDirection.endToStart, // 向右滑动删除
              onDismissed: (direction) {
                if(direction==DismissDirection.endToStart) favoriteProvider.removeFromFavorites(news); // 从收藏列表中移除
              },
              background: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.close)
                  ),
                ),
              ),
              child: ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoriteView(news: news)),
                  );
                },
                title: Text(news.data!.title!),
                subtitle: Text(news.data!.updateTime!),// 在ListTile中显示新闻标题
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          favoriteProvider.clearFavorites();
        },
        backgroundColor: Theme.of(context).canvasColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.delete),
      ),
    );
  }
}
