import 'package:cumt_guide/SettingPage/button/favorite/favorite_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dio/ConcretePage/content_entity.dart';
import 'history_provider.dart';

toHistoryPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const HistoryPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context); // 获取HistoryProvider
    final history = historyProvider.history;

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0.3,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text('浏览历史'),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            final news = history[index];
            return Dismissible(
              key: Key(news.data!.id!), // 使用唯一标识作为key
              direction: DismissDirection.endToStart, // 向右滑动删除
              onDismissed: (direction) {
                if(direction==DismissDirection.endToStart) historyProvider.removeFromHistory(news); // 从浏览历史中移除
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
          historyProvider.clearHistory();
        },
        backgroundColor: Theme.of(context).canvasColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.delete),
      ),
    );
  }
}
