import 'package:dio/dio.dart';

import 'content_entity.dart';
class ContentModel{
  ContentEntity? data;
  Future<ContentEntity?> getData()async{
    if(data==null){
      try{
        Response res=await Dio().get('http://ekkosblog.online:9999/articleDetails/1');
        data=ContentEntity.fromJson(res.data);
        return data;
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