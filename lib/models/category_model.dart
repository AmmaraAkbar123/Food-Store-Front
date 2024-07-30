// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';


CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    List<Category> data;

    CategoryModel({
        required this.data,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Category {
    int id;
    String name;
    dynamic slug;
    String arabicName;
    int productCount;
    String? image;
    List<SubCategory> subCategories;

    Category({
        required this.id,
        required this.name,
        required this.slug,
        required this.arabicName,
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
        subCategories: List<SubCategory>.from(json["sub_categories"].map((x) => SubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "arabic_name": arabicName,
        "productCount": productCount,
        "image": image,
        "sub_categories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
    };
}

class SubCategory {
    int id;
    String name;
    int businessId;
    String? shortCode;
    int parentId;
    int createdBy;
    int featured;
    dynamic woocommerceCatId;
    dynamic categoryType;
    String? description;
    String? catImage;
    dynamic slug;
    dynamic deletedAt;
    DateTime createdAt;
    DateTime updatedAt;
    String arabicName;
    int showOnStorefront;
    int sort;
    dynamic darazCategoryId;

    SubCategory({
        required this.id,
        required this.name,
        required this.businessId,
        required this.shortCode,
        required this.parentId,
        required this.createdBy,
        required this.featured,
        required this.woocommerceCatId,
        required this.categoryType,
        required this.description,
        required this.catImage,
        required this.slug,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.arabicName,
        required this.showOnStorefront,
        required this.sort,
        required this.darazCategoryId,
    });

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
        businessId: json["business_id"],
        shortCode: json["short_code"],
        parentId: json["parent_id"],
        createdBy: json["created_by"],
        featured: json["featured"],
        woocommerceCatId: json["woocommerce_cat_id"],
        categoryType: json["category_type"],
        description: json["description"],
        catImage: json["cat_image"],
        slug: json["slug"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        arabicName: json["arabic_name"],
        showOnStorefront: json["show_on_storefront"],
        sort: json["sort"],
        darazCategoryId: json["daraz_category_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "business_id": businessId,
        "short_code": shortCode,
        "parent_id": parentId,
        "created_by": createdBy,
        "featured": featured,
        "woocommerce_cat_id": woocommerceCatId,
        "category_type": categoryType,
        "description": description,
        "cat_image": catImage,
        "slug": slug,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "arabic_name": arabicName,
        "show_on_storefront": showOnStorefront,
        "sort": sort,
        "daraz_category_id": darazCategoryId,
    };
}
