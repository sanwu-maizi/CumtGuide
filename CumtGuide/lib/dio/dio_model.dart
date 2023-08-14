import 'package:cumt_guide/dio/dio_entity.dart';
import 'package:dio/dio.dart';
class DioModel{
  DioEntity? model;
  Future<DioEntity?> getData(String s)async{
    if(model==null){
      try{
        Response res=await Dio().get(s);
        model=DioEntity.fromJson(res.data);
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