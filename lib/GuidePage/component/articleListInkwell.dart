import 'package:flutter/material.dart';

class ArticleListInkWell extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String author;
  final String createTime;
  final String content;
  final int likes;

  ArticleListInkWell({
    required this.onTap,
    required this.title,
    required this.author,
    required this.createTime,
    required this.content,
    required this.likes,
  });

  String formatTimeDifference(DateTime createTime) {
    final now = DateTime.now();
    final difference = now.difference(createTime);

    if (difference.inHours < 24) {
      if (difference.inHours == 0) {
        return "今天";
      } else {
        return "${difference.inHours}小时前";
      }
    } else if (difference.inDays <= 7) {
      return "${difference.inDays}天前";
    } else if (difference.inDays <= 28) {
      final weeks = (difference.inDays / 7).floor();
      return "${weeks}星期前";
    } else {
      final months = (difference.inDays / 30).floor();
      return "${months}月前";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 13.0),
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headline1!.color,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  author,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
                Text(
                  "  |  ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                ),
                Text(
                  formatTimeDifference(DateTime.parse(createTime)),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
