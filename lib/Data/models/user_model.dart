class UserModel {
  UserModel({
    required this.success,
    required this.data,
    required this.message,
  });

  late final bool success;
  late final Data data;
  late final String message;

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.token,
    required this.name,
    required this.hasMedia,
    required this.media,
  });

  late final String token;
  late final String name;
  late final bool hasMedia;
  late final List<Media> media;

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    hasMedia = json['has_media'];
    media = List.from(json['media']).map((e) => Media.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['name'] = name;
    _data['has_media'] = hasMedia;
    _data['media'] = media.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Media {
  Media({
    required this.id,
    required this.thumb,
  });

  late final int id;

  late final dynamic thumb;

  Media.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];

    thumb = json['thumb'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['id'] = id;

    _data['thumb'] = thumb;

    return _data;
  }
}
