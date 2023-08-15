class SearchEntity {
  SearchEntity({
    this.code,
    this.message,
    this.data,
  });

  SearchEntity.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null && json['data'] is Map) {
      data = Data.fromJson(json['data']);
    }

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

class Data {
  Data({
    this.total,
    this.list,
    this.pageNum,
    this.pageSize,
    this.size,
    this.navigateLastPage,
  });

  Data.fromJson(dynamic json) {
    total = json['total'];
    if (json['list'] != null && json['list'] is List) {
      list = List<Map<String, dynamic>>.from(json['list'].map((item) {
        return Map<String, dynamic>.from(item);
      }));
    }
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    size = json['size'];
    navigateLastPage = json['navigateLastPage'];
  }

  int? total;
  List<Map<String, dynamic>>? list;
  int? pageNum;
  int? pageSize;
  int? size;
  int? navigateLastPage;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (list != null) {
      map['list'] = list;
    }
    map['pageNum'] = pageNum;
    map['pageSize'] = pageSize;
    map['size'] = size;
    map['navigateLastPage'] = navigateLastPage;
    return map;
  }
}
