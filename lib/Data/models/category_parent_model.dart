class CategoryParentModel {
  List<CategoryParentData>? data;
  int? status;
  String? message;

  CategoryParentModel({this.data, this.status, this.message});

  CategoryParentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryParentData>[];
      json['data'].forEach((v) {
        data!.add(CategoryParentData.fromJson(v));
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

class CategoryParentData {
  int? id;
  String? name;
  List<Children>? children;
  int? parentId;
  bool? selected;

  CategoryParentData({this.id, this.name, this.children, this.parentId, this.selected});

  CategoryParentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
    parentId = json['parent_id'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    data['parent_id'] = parentId;
    data['selected'] = selected;
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
