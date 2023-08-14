import 'package:cumt_guide/dio/search/search_entity.dart';
import 'package:dio/dio.dart';
class DioModel{
  SearchEntity? model;
  Future<SearchEntity?> getData()async{
    if(model==null){
      try{
        Response res=await Dio().get("http://ekkosblog.online:9999/search",queryParameters: {
          "query":"apple",
          "type":"0",
          "page":1,
          "limit":10
        },);
        model=SearchEntity.fromJson(res.data);
        print(model!.data);
        return model;
      }catch(e){
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