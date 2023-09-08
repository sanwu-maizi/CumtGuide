import 'package:cumt_guide/HomePage/component/button_index.dart';
import 'package:cumt_guide/dio/search/search_provider.dart';
import 'package:cumt_guide/dio/search/search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../SettingPage/settings.dart';
import '../../util/config.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPage();
}

toSearchPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const SearchPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class _SearchPage extends State<SearchPage> {
  List<String> items = [
    '教务信息',
    '医保',
    '转专业',
    '新生指南',
    '教务信息1',
    '教务信息2',
    '教务信息3',
    '教务信息4',
    '教务信息',
  ];

  final TextEditingController _searchController = TextEditingController();

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
    if (searchText.length >= 20) {
      String result = "";
      for (int i = 0; i < 20; i++) {
        result += searchText[i];
      }
      searchText = result;
    }
    Provider.of<SearchProvider>(context, listen: false)
        .addToHistory(searchText);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchResult(s: searchText),
      fullscreenDialog: true, // 路由为全屏模式
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardTheme.color,
      body: Column(
        children: [
          Expanded(
            flex: 90,
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                children: [
                  Expanded(
                    flex: 21,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width *
                                    0.21 *
                                    0.45,
                                backgroundImage: AssetImage("assets/2.jpg"),
                              ),
                              Material(
                                color: Colors.transparent,
                                shape: CircleBorder(), //圆形
                                child: Container(
                                  height: MediaQuery.of(context).size.width *
                                      0.21 *
                                      0.45,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(1000),
                                    radius: MediaQuery.of(context).size.width *
                                        0.21 *
                                        0.45,
                                    onTap: () {
                                      toSettingPage(context);
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: ButtonIndex(
                            outerColor: Theme.of(context).canvasColor,
                            innerColor: Theme.of(context).colorScheme.onSecondary,
                            onPressed: () {},
                            child: Icon(
                              Icons.search,
                              size: 40,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: List.generate(items.length, (index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.008,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.008),
                                  child: InkWell(
                                    child: ButtonIndex(
                                      outerColor: Theme.of(context).canvasColor,
                                      innerColor: Theme.of(context).colorScheme.onSecondary,
                                      onPressed: () {Navigator.pop(context);},
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          items[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: UIConfig.fontSizeSidebar,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 79,
                      child: Container(
                        color: Theme.of(context).colorScheme.background,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.all(5), // Adjust the padding as needed
                                child: Image.asset("assets/img.png", fit: BoxFit.fill),
                              ),
                            ),
                            Expanded(
                              flex:8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0), // Add left and right padding
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Container(
                                      height: 40, // Set the height for the square input box
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _searchController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.grey[200],
                                                hintText: 'Search',
                                                contentPadding: const EdgeInsets.all(10),
                                                prefixIcon: const Icon(Icons.search),
                                                border: const OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(5)),
                                                ),
                                              ),
                                              onSubmitted: (value) {
                                                _performSearch(_searchController.text);
                                                _searchController.text = "";
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "搜索历史",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Wrap(
                                      spacing: MediaQuery.of(context).size.height * 0.01,
                                      runSpacing: MediaQuery.of(context).size.width * 0.01,
                                      children: Provider.of<SearchProvider>(context, listen: false)
                                          .history
                                          .map((tag) => CustomTag(text: tag))
                                          .toList(),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Provider.of<SearchProvider>(context, listen: false).history.length != 0
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
                                                  title: Text('清除搜索历史'),
                                                  content: Text('确定要清除搜索历史吗？'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text('取消'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Provider.of<SearchProvider>(context, listen: false).clearHistory();
                                                        setState(() {});
                                                        Navigator.of(context).pop(); // 关闭对话框
                                                      },
                                                      child: Text('确定'),
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
                              ),

                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.star),
                      Text("指南"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.refresh),
                      Text("动态"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTag extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomTag({required this.text, this.onPressed, Key? key})
      : super(key: key);

  void _performSearch(String searchText) {
    if (searchText.length >= 20) {
      String result = "";
      for (int i = 0; i < 20; i++) {
        result += searchText[i];
      }
      searchText = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        InkWell(
          onTap: () {
            _performSearch(text);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
