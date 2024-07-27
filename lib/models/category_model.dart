import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<Category> data;

  CategoryModel({
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        data:
            List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  String name;
  String? slug;
  String? arabicName;
  int productCount;
  String image;
  List<dynamic> subCategories;

  Category({
    required this.id,
    required this.name,
    this.slug,
    this.arabicName,
    required this.productCount,
    required this.image,
    required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        arabicName: json["arabic_name"],
        productCount: json["productCount"],
        image: json["image"],
        subCategories: List<dynamic>.from(json["sub_categories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "arabic_name": arabicName,
        "productCount": productCount,
        "image": image,
        "sub_categories": List<dynamic>.from(subCategories.map((x) => x)),
      };
}
