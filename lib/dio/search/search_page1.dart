import 'package:cumt_guide/dio/search/search_provider.dart';
import 'package:cumt_guide/dio/search/search_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SearchPage1 extends StatefulWidget {
  const SearchPage1({super.key});

  @override
  State<SearchPage1> createState() => _SearchPageState();
}

toSearchPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const SearchPage1(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class _SearchPageState extends State<SearchPage1> {
  final TextEditingController _searchController = TextEditingController();

  bool isDelete=false;
  final List<String> hotSearches = [
    '震惊，矿大学子都用的App竟',
    '这就是矿大食堂.........',
    '震惊，矿大竟然有这样一个.',
    'Flystudio,欢迎你.....',
    '你好，矿大............',
    '这就是我们............',
    '小煤球的世界..........',
    '大家一起加油..........',
    '小东西的心里历程.......',
    '老东西的心里历程.......',
  ];

  @override
  void initState() {
    Provider.of<SearchProvider>(context, listen: false).loadHistory();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String searchText) {
    if(searchText!=""){
      if (searchText.length >= 20) {
        String result = "";
        for (int i = 0; i < 20; i++) {
          result += searchText[i];
        }
        searchText = result;
      }
      isDelete=false;
      Provider.of<SearchProvider>(context, listen: false)
          .addToHistory(searchText);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchResult(s: searchText),
        fullscreenDialog: true, // 路由为全屏模式
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01,left: MediaQuery.of(context).size.height * 0.012,right: MediaQuery.of(context).size.width*0.012),
        child: Column(
          children: [
            Expanded(
              flex: 55,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.04,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.055,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios_new_outlined),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.012,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height*0.04,
                            child: TextField(
                              cursorColor: Colors.blue,
                              controller: _searchController,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context).colorScheme.primary,
                                contentPadding: const EdgeInsets.all(10),
                                prefixIcon: const Icon(Icons.search,color: Colors.grey),
                                enabledBorder:  OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height*0.04)),// 未获取焦点时的边框颜色
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary), // 获取焦点时的边框颜色
                                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height*0.04)),
                                ),
                              ),
                              onSubmitted: (value) {
                                _performSearch(_searchController.text);
                                _searchController.text = "";
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.035,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.008),
                          child: InkWell(
                            onTap: () {
                              _performSearch(_searchController.text);
                              _searchController.text = "";
                              setState(() {});
                            },
                            child: Text(
                              "搜索",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: MediaQuery.of(context).size.width*0.0455,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.035,
                    child: Row(
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01,left: MediaQuery.of(context).size.width*0.01),
                          child: Text("信息平台热搜",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width*0.034
                          ),),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.54),
                        Padding(
                          padding:
                          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                          child: InkWell(
                            onTap: (){
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("完整榜单🎈",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: MediaQuery.of(context).size.width*0.034
                                ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.256,
                    child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01,left: MediaQuery.of(context).size.width*0.01),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: GridView.builder(
                          // shrinkWrap: true, // 让 GridView 自适应内容高度
                          itemCount: hotSearches.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 5, // 控制子项高度
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){

                              },
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.06,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    hotSearches[index],
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width*0.036
                                    ),),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.035,
                    child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01,left: MediaQuery.of(context).size.width*0.01),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "搜索历史",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width*0.034
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ],
              ),
            ),
            Expanded(
              flex: 70,
              child: Column(
                children: [
                  Wrap(
                    spacing: MediaQuery.of(context).size.height * 0.01,
                    runSpacing: MediaQuery.of(context).size.width * 0,
                    children: Provider.of<SearchProvider>(context, listen: false)
                        .history
                        .map((tag){
                      return InkWell(
                          onTap: (){
                            _performSearch(tag);
                            setState(() {});
                          },
                          child: GestureDetector(
                            onLongPress: () {
                              setState(() {
                                isDelete = !isDelete;
                              });
                            },
                            child: Stack(
                                children:[
                                  Chip(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5), // 设置圆角半径
                                    ),
                                    label: Text(tag),
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    deleteIcon:  null,
                                  ),
                                  if(isDelete)
                                    Positioned(
                                      top: MediaQuery.of(context).size.height*0.008,
                                      right: 0,
                                      child: InkWell(
                                        onTap: (){
                                          Provider.of<SearchProvider>(context, listen: false).removeFromHistory(tag);
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.dangerous_outlined, // 按钮图标
                                          color: Colors.grey, // 按钮图标颜色
                                          size: MediaQuery.of(context).size.height*0.02, // 按钮图标大小
                                        ),
                                      ))
                                ]
                            ),
                          ));
                    })
                        .toList(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Provider.of<SearchProvider>(context, listen: false).history.length !=
                      0
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.grey,
                        size: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
                                title: Text('清除搜索历史',style: TextStyle(
                                color: Theme.of(context).textTheme.headline1!.color
                              ),),
                                content: Text('确定要清除搜索历史吗？',style: TextStyle(
                                    color: Theme.of(context).textTheme.headline1!.color
                                ),),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Theme.of(context).dialogTheme.backgroundColor, // 设置按钮的背景颜色为蓝色
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('取消',style: TextStyle(
                                        color: Theme.of(context).textTheme.headline1!.color
                                    ),),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Theme.of(context).dialogTheme.backgroundColor, // 设置按钮的背景颜色为蓝色
                                    ),
                                    onPressed: () {
                                      Provider.of<SearchProvider>(context,
                                          listen: false)
                                          .clearHistory();
                                      setState(() {});
                                      Navigator.of(context).pop(); // 关闭对话框
                                    },
                                    child: Text('确定',style: TextStyle(
                                        color: Theme.of(context).textTheme.headline1!.color
                                    ),),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          '清除搜索历史',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  )
                      : SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

