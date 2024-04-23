class ResponseSubCategories {
  ResponseSubCategories({
      this.status,
      this.message,
      this.data,
  });

  ResponseSubCategories.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataSubCategories.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<DataSubCategories>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DataSubCategories {
  DataSubCategories({
      this.id,
      this.categoriesId,
      this.subCategoriesName,
      // this.categories,
  });

  DataSubCategories.fromJson(dynamic json) {
    id = json['_id'];
    categoriesId = json['categories_id'];
    subCategoriesName = json['sub_categories_name'];
    // categories = json['categories'] != null ? Categories.fromJson(json['categories']) : null;
  }
  String? id;
  String? categoriesId;
  String? subCategoriesName;
  // Categories? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['categories_id'] = categoriesId;
    map['sub_categories_name'] = subCategoriesName;
    // if (categories != null) {
    //   map['categories'] = categories?.toJson();
    // }
    return map;
  }

}

class Categories {
  Categories({
    this.id,
    this.categoriesName,});

  Categories.fromJson(dynamic json) {
    id = json['_id'];
    categoriesName = json['categories_name'];
  }
  String? id;
  String? categoriesName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['categories_name'] = categoriesName;
    return map;
  }
}


// class SubCategory {
//   final String id;
//   final String categoryId;
//   final String name;
//   final Category category;
//
//   SubCategory({
//     required this.id,
//     required this.categoryId,
//     required this.name,
//     required this.category,
//   });
//
//   factory SubCategory.fromJson(Map<String, dynamic> json) {
//     return SubCategory(
//       id: json['_id'],
//       categoryId: json['categories_id'],
//       name: json['sub_categories_name'],
//       category: Category.fromJson(json['categories'][0]),
//     );
//   }
// }
//
// class Category {
//   final String id;
//   final String name;
//
//   Category({
//     required this.id,
//     required this.name,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['_id'],
//       name: json['categories_name'],
//     );
//   }
// }
