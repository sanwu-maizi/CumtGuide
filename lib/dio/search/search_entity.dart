/// code : 1
/// message : null
/// data : {"total":0,"list":[],"pageNum":1,"pageSize":10,"size":0,"navigateLastPage":0}

class SearchEntity {
  SearchEntity({
      this.code, 
      this.message, 
      this.data,});

  SearchEntity.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? code;
  dynamic message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// total : 0
/// list : []
/// pageNum : 1
/// pageSize : 10
/// size : 0
/// navigateLastPage : 0

class Data {
  Data({
      this.total, 
      this.list, 
      this.pageNum, 
      this.pageSize, 
      this.size, 
      this.navigateLastPage,});

  Data.fromJson(dynamic json) {
    total = json['total'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(Dynamic.fromJson(v));
      });
    }
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    size = json['size'];
    navigateLastPage = json['navigateLastPage'];
  }
  int? total;
  List<dynamic>? list;
  int? pageNum;
  int? pageSize;
  int? size;
  int? navigateLastPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    map['pageNum'] = pageNum;
    map['pageSize'] = pageSize;
    map['size'] = size;
    map['navigateLastPage'] = navigateLastPage;
    return map;
  }

}