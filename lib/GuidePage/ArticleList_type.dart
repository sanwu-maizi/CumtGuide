import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../dio/Articletype/Articletype_entity.dart';
import '../next_page.dart'; // Make sure to import Dio

class MyListViewWidget extends StatelessWidget {
  final Future<DioEntity?> _futureBuilder;

  MyListViewWidget(this._futureBuilder);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: FutureBuilder<DioEntity?>(
        future: _futureBuilder,
        builder: (BuildContext context, AsyncSnapshot<DioEntity?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return buildListViewItem(context, snapshot.data!.data![index]);
              },
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              color: Colors.white,
            );
          }
        },
      ),
    );
  }

  Widget buildListViewItem(BuildContext context, Data data) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(3, 3),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 13.0),
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.id!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Date: ${data.id}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Rest of your code remains the same
