class SubCategoryModel {
  List<SubCategoryData>? data;
  int? status;
  String? message;

  SubCategoryModel({this.data, this.status, this.message});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubCategoryData>[];
      json['data'].forEach((v) {
        data!.add(SubCategoryData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;

    return data;
  }
}

class SubCategoryData {
  int? id;
  String? name;
  int? parentId;
  bool? selected;
  List<Children>? children;

  SubCategoryData(
      {this.id, this.name, this.parentId, this.selected, this.children});

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    selected = json['selected'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent_id'] = parentId;
    data['selected'] = selected;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? id;
  String? name;
  int? parentId;
  bool? selected;

  Children({this.id, this.name, this.parentId, this.selected});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent_id'] = parentId;
    data['selected'] = selected;

    return data;
  }
}
