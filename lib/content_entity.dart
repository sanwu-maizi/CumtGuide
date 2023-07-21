/// code : 1
/// message : null
/// data : {"id":"article12","typeId":"type12","title":"Title12","content":"Content12","createTime":"2023-07-16T05:12:41.000+00:00","updateTime":"2023-07-16T05:12:41.000+00:00","likes":47}

class ContentEntity {
  ContentEntity({
      num? code, 
      dynamic message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  ContentEntity.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  dynamic _message;
  Data? _data;
ContentEntity copyWith({  num? code,
  dynamic message,
  Data? data,
}) => ContentEntity(  code: code ?? _code,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get code => _code;
  dynamic get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : "article12"
/// typeId : "type12"
/// title : "Title12"
/// content : "Content12"
/// createTime : "2023-07-16T05:12:41.000+00:00"
/// updateTime : "2023-07-16T05:12:41.000+00:00"
/// likes : 47

class Data {
  Data({
      String? id, 
      String? typeId, 
      String? title, 
      String? content, 
      String? createTime, 
      String? updateTime, 
      num? likes,}){
    _id = id;
    _typeId = typeId;
    _title = title;
    _content = content;
    _createTime = createTime;
    _updateTime = updateTime;
    _likes = likes;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _typeId = json['typeId'];
    _title = json['title'];
    _content = json['content'];
    _createTime = json['createTime'];
    _updateTime = json['updateTime'];
    _likes = json['likes'];
  }
  String? _id;
  String? _typeId;
  String? _title;
  String? _content;
  String? _createTime;
  String? _updateTime;
  num? _likes;
Data copyWith({  String? id,
  String? typeId,
  String? title,
  String? content,
  String? createTime,
  String? updateTime,
  num? likes,
}) => Data(  id: id ?? _id,
  typeId: typeId ?? _typeId,
  title: title ?? _title,
  content: content ?? _content,
  createTime: createTime ?? _createTime,
  updateTime: updateTime ?? _updateTime,
  likes: likes ?? _likes,
);
  String? get id => _id;
  String? get typeId => _typeId;
  String? get title => _title;
  String? get content => _content;
  String? get createTime => _createTime;
  String? get updateTime => _updateTime;
  num? get likes => _likes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['typeId'] = _typeId;
    map['title'] = _title;
    map['content'] = _content;
    map['createTime'] = _createTime;
    map['updateTime'] = _updateTime;
    map['likes'] = _likes;
    return map;
  }

}