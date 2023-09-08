import 'package:cumt_guide/dio/search/search_dio.dart';
import 'package:cumt_guide/dio/search/search_entity.dart';
import 'package:flutter/material.dart';

import '../../next_page.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key, required this.s}) : super(key: key);
  final String s;
  @override
  State<SearchResult> createState() => _SearchResult();
}

class _SearchResult extends State<SearchResult> {
  search_Model _model=search_Model();
  var futureBuild;
  @override
  void initState(){
    super.initState();
    futureBuild=_model.getData(query: widget.s, type: "0");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text('搜索结'),
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
                      ),
                      margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 13.0),
                      padding: EdgeInsets.fromLTRB(15.0,5.0,5.0,5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.data!.pageSize!.toString(),
                            style: TextStyle(
                              fontSize: 18, // 标题字体大小偏大
                              fontWeight: FontWeight.bold, // 标题字体加粗
                              color: Colors.grey[600], // 标题字体颜色
                            ),
                          ),
                          SizedBox(height: 5), // 间距
                          Text(
                            "Date: ",
                            style: TextStyle(
                              fontSize: 14, // 内容字体大小偏小
                              color: Colors.grey[300], // 内容字体颜色
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );

            }else{
              return Container(height:MediaQuery.of(context).size.height * 0.75,
                  color: Colors.white
              );
            }
          })
    );
  }
}
