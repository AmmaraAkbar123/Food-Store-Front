class ProductModel {
  int id;
  String name;
  String? description;
  final ProductImage image;
  final double price;
  final ProductCategory category;
  final List<Variation> variations;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.variations,
    required this.image,
    required this.price,
    required this.category,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json["description"] as String?,
      image: ProductImage.fromJson(json['image'] ?? {}),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: ProductCategory.fromJson(json['category'] ?? {}),
      variations: (json['variations'] as List<dynamic>? ?? [])
          .map((item) => Variation.fromJson(item))
          .toList(),
    );
  }

  get code => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image.toJson(),
      'price': price,
      'category': category.toJson(),
      'variations': variations.map((item) => item.toJson()).toList(),
    };
  }
}

class ProductImage {
  final int id;
  final String thumbnail;
  final String original;

  ProductImage({
    required this.id,
    required this.thumbnail,
    required this.original,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      thumbnail: json['thumbnail'],
      original: json['original'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'original': original,
    };
  }
}

class ProductCategory {
  final int id;
  final String name;

  final String description;

  ProductCategory({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

class Variation {
  final int id;
  final String value;
  final String sku;
  final String defaultSellPrice;
  final String sellPriceIncTax;
  final String compareAtPrice;

  Variation({
    required this.id,
    required this.value,
    required this.sku,
    required this.defaultSellPrice,
    required this.sellPriceIncTax,
    required this.compareAtPrice,
    // required this.attribute,
    // required this.variationDetails,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      id: json['id'],
      value: json['value'],
      sku: json['sku'],
      defaultSellPrice: json['default_sell_price'],
      sellPriceIncTax: json['sell_price_inc_tax'],
      compareAtPrice: json['compare_at_price'],
      // attribute: Attribute.fromJson(json['attribute']),
      // variationDetails: (json['variation_details'] as List<dynamic>)
      //     .map((item) => VariationDetail.fromJson(item))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'sku': sku,
      'default_sell_price': defaultSellPrice,
      'sell_price_inc_tax': sellPriceIncTax,
      'compare_at_price': compareAtPrice,
      // 'attribute': attribute.toJson(),
      // 'variation_details':
      //     variationDetails.map((item) => item.toJson()).toList(),
    };
  }
}
