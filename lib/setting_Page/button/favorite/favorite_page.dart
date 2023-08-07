import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../content_entity.dart';
import 'favorite_button.dart';
import 'favorite_view.dart'; // 导入FavoriteProvider

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context); // 获取FavoriteProvider
    final favorite = favoriteProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
        shape: const CircleBorder(),
        child: const Icon(Icons.delete),
      ),
    );
  }
}
