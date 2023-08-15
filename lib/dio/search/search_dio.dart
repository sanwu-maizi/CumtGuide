import 'package:cumt_guide/dio/search/search_entity.dart';
import 'package:dio/dio.dart';

class search_Model {
  SearchEntity? model;

  Future<SearchEntity?> getData({
    required String query,
    required String type,
  }) async {
    if (model == null) {
      try {
        final rawJsonData = {
          "query": query,
          "type": type,
          "page": 1,
          "limit": 10,
        };
        Response res = await Dio().get(
          "http://ekkosblog.online:9999/search",
          data: rawJsonData,
        );
        // 打印状态码
        print("Status Code: ${res.statusCode}");

        // 打印响应头
        print("Response Headers: ${res.headers}");

        // 打印响应数据
        print("Response Data: ${res.data}");

    if (res.statusCode == 200) {
          model = SearchEntity.fromJson(res.data);
          print("Request successful: ${model!.data}");
          return model;
        } else {
          print("Request failed with status code: ${res.statusCode}");
          return null;
        }
      } catch (e) {
        print("Request error: $e");
        return null;
      }
    }
  }



  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  ));
}
