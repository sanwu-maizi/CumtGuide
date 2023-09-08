import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
      child: Column(
        children: [
          Container(
            height: 10,
            color: Colors.grey[100],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      author,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      "  |  ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[200],
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
                SizedBox(height: 5),
                Text(
                  content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 1),
                        Text(
                          " $likes",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
