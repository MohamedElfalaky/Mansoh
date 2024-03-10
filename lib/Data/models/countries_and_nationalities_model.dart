class CountriesAndNationalitiesModel {
  Data? data;
  int? status;
  String? message;

  CountriesAndNationalitiesModel({this.data, this.status, this.message});

  CountriesAndNationalitiesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }
}

class Data {
  List<Countries>? countries;
  List<Nationailties>? nationailties;

  Data({this.countries, this.nationailties});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    }
    if (json['nationailties'] != null) {
      nationailties = <Nationailties>[];
      json['nationailties'].forEach((v) {
        nationailties!.add(Nationailties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    if (nationailties != null) {
      data['nationailties'] = nationailties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  int? id;
  String? name;

  Countries({this.id, this.name});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Nationailties {
  int? id;
  String? name;
  String? code;
  String? logo;

  Nationailties({this.id, this.name, this.code, this.logo});

  Nationailties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['logo'] = logo;
    return data;
  }
}
