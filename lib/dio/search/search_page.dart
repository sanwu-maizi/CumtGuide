import 'package:flutter/material.dart';
import 'package:cumt_guide/dio/search/search_provider.dart';
import 'package:cumt_guide/HomePage/button/button_index.dart';
import 'package:cumt_guide/dio/Articletype/Articletype_model.dart';
import 'package:cumt_guide/setting_Page/settings.dart';
import 'package:cumt_guide/util/config.dart';
import 'package:provider/provider.dart';

class SearchContent extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback performSearch;
  final List<String> history;
  final VoidCallback clearHistory;

  SearchContent({
    required this.searchController,
    required this.performSearch,
    required this.history,
    required this.clearHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: 'Search',
            contentPadding: const EdgeInsets.all(10),
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          onSubmitted: (value) {
            performSearch();
            searchController.text = "";
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
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
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: history.map((tag) => CustomTag(text: tag)).toList(),
        ),
        SizedBox(height: 8.0),
        history.length != 0
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.delete,
              color: Colors.grey,
              size: 16,
            ),
            SizedBox(width: 8.0),
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
                            clearHistory();
                            Navigator.of(context).pop();
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
            : SizedBox(height: 8.0),
      ],
    );
  }
}

class CustomTag extends StatelessWidget {
  final String text;

  const CustomTag({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        InkWell(
          onTap: () {
            // Perform your search action here
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
