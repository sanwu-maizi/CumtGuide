/// code : 1
/// message : null
/// data : [{"id":"1","typeName":"学分1"},{"id":"10","typeName":"学分10"},{"id":"1686254538200715264","typeName":"学分1000"},{"id":"1686254538808889344","typeName":"h4"},{"id":"1686263406918111232","typeName":"故事"},{"id":"1686267716636774400","typeName":null},{"id":"1686267716804546560","typeName":null},{"id":"1686267716959735808","typeName":null},{"id":"1686267717144285184","typeName":null},{"id":"1686267717303668736","typeName":null},{"id":"1686267717517578240","typeName":null},{"id":"1686267717664378880","typeName":null},{"id":"1686267717823762432","typeName":null},{"id":"1686267718041866240","typeName":null},{"id":"1686267718205444096","typeName":null},{"id":"1686267718364827648","typeName":null},{"id":"2","typeName":"学分2"},{"id":"3","typeName":"学分3"},{"id":"4","typeName":"学分4"},{"id":"5","typeName":"学分5"},{"id":"6","typeName":"学分6"},{"id":"7","typeName":"学分7"},{"id":"8","typeName":"学分8"},{"id":"9","typeName":"学分9"}]

class DioEntity {
  DioEntity({
      num? code, 
      dynamic message, 
      List<Data>? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  DioEntity.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _code;
  dynamic _message;
  List<Data>? _data;
DioEntity copyWith({  num? code,
  dynamic message,
  List<Data>? data,
}) => DioEntity(  code: code ?? _code,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get code => _code;
  dynamic get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// typeName : "学分1"

class Data {
  Data({
      String? id, 
      String? typeName,}){
    _id = id;
    _typeName = typeName;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _typeName = json['typeName'];
  }
  String? _id;
  String? _typeName;
Data copyWith({  String? id,
  String? typeName,
}) => Data(  id: id ?? _id,
  typeName: typeName ?? _typeName,
);
  String? get id => _id;
  String? get typeName => _typeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['typeName'] = _typeName;
    return map;
  }

}