import 'package:cumt_guide/dio/search/search_dio.dart';
import 'package:cumt_guide/dio/search/search_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../GuidePage/component/articleListInkwell.dart';
import '../../next_page.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key, required this.s}) : super(key: key);
  final String s;
  @override
  State<SearchResult> createState() => _SearchResult();
}

class _SearchResult extends State<SearchResult> {
  search_Model _model = search_Model();
  var futureBuild;
  @override
  void initState() {
    super.initState();
    futureBuild = _model.getData(query: widget.s, type: "0");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
      backgroundColor: Theme.of(context).cardTheme.color,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text('搜索结果'),
      ),
      body: FutureBuilder<SearchEntity?>(
          future: futureBuild,
          builder: (BuildContext context, AsyncSnapshot<SearchEntity?> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage(articleId: snapshot.data!.data?.list?[index]['id'])),
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
=======
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0.3,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_outlined)),
          iconTheme: IconThemeData(
            color: Theme.of(context).iconTheme.color,
          ),
          title: const Text('搜索结果'),
        ),
        body: FutureBuilder<SearchEntity?>(
            future: futureBuild,
            builder:
                (BuildContext context, AsyncSnapshot<SearchEntity?> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.data?.list?.isEmpty ?? true) {
                  // 列表为空时显示一条消息
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20), // 顶部留出一些空间
                        child: Center(
                          child: Text("什么都没找到啊QAQ", style: TextStyle(fontSize: 16,color: Colors.grey,))
                        ),
>>>>>>> Stashed changes
                      ),
                    ],
                  );
<<<<<<< Updated upstream
                },
              );

            }else{
              return Container(height:MediaQuery.of(context).size.height * 0.75,
                  color: Colors.white
              );
            }
          })
    );
=======
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data?.list?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return ArticleListInkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => NextPage(articleId: snapshot.data!.data?.list?[index]['id']),
                            ),
                          );
                        },
                        title: snapshot.data!.data?.list?[index]['title'] ?? "",
                        author: "信息平台官方",
                        createTime: snapshot.data!.data?.list?[index]['createTime'] ?? "",
                        content: snapshot.data!.data?.list?[index]['content'] ?? "",
                        likes: snapshot.data!.data?.list?[index]['likes'] ?? 0,
                      );
                    },
                  );
                }
              } else {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    color: Colors.white);
              }
            }));
>>>>>>> Stashed changes
  }
}
