class ProductModel {
  int id;
  String name;
  String? description;
  // final String slug;
  // final String productSlug;
  // final int taxId;
  // final String type;
  // final int enableStock;
  // final String alertQuantity;
  // final String arabicName;
  // final double? calories;
  final ProductImage image;
  final double price;
  final ProductCategory category;
  //final SubCategory? subCategory; // Nullable field
  // final ProductTax? productTax; // Nullable field
  final List<Variation> variations;
//  final List<ProductLocation>? productLocations; // Nullable field
  // final String merchantName;
  // final String city;
  // final List<String> tags;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    // required this.slug,
    // required this.productSlug,
    // required this.taxId,
    // required this.type,
    required this.variations,
    // required this.enableStock,
    // required this.alertQuantity,
    // required this.arabicName,
    // this.calories,
    required this.image,
    required this.price,
    required this.category,
    // this.subCategory,
    // this.productTax,
    // this.productLocations,
    // required this.merchantName,
    // required this.city,
    // required this.tags,

    //required List<dynamic> productLocations,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json["description"] as String?,
      // slug: json["slug"] as String? ?? '',
      // productSlug: json['product_slug'] ?? '',
      // taxId: json['tax_id'] ?? 0,
      // type: json['type'] ?? '',
      // enableStock: json['enable_stock'] ?? 0,
      // alertQuantity: json['alert_quantity'] ?? '0.00',
      // arabicName: json['arabic_name'] ?? '',
      // calories: (json["calories"] as num?)?.toDouble(),
      image: ProductImage.fromJson(json['image'] ?? {}),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: ProductCategory.fromJson(json['category'] ?? {}),
      // subCategory: json['sub_category'] != null
      //     ? SubCategory.fromJson(json['sub_category'])
      //     : null,
      // productTax: json['product_tax'] != null
      //     ? ProductTax.fromJson(json['product_tax'])
      //     : null,
      variations: (json['variations'] as List<dynamic>? ?? [])
          .map((item) => Variation.fromJson(item))
          .toList(),
      // productLocations: (json['product_locations'] as List<dynamic>? ?? [])
      //     .map((item) => ProductLocation.fromJson(item))
      //     .toList(),
      // merchantName: json['merchant_name'] ?? '',
      // city: json['city'] ?? '',
      // tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      // 'slug': slug,
      // 'product_slug': productSlug,
      // 'tax_id': taxId,
      // 'type': type,
      // 'enable_stock': enableStock,
      // 'alert_quantity': alertQuantity,
      // 'arabic_name': arabicName,
      // 'calories': calories,
      'image': image.toJson(),
      'price': price,
      'category': category.toJson(),
      // 'sub_category': subCategory?.toJson(),
      // 'product_tax': productTax?.toJson(),
      'variations': variations.map((item) => item.toJson()).toList(),
      // 'product_locations':
      //     productLocations?.map((item) => item.toJson()).toList(),
      // 'merchant_name': merchantName,
      // 'city': city,
      // 'tags': tags,
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

// class GalleryItem {
//   final int id;
//   final String thumbnail;
//   final String original;

//   GalleryItem({
//     required this.id,
//     required this.thumbnail,
//     required this.original,
//   });

//   factory GalleryItem.fromJson(Map<String, dynamic> json) {
//     return GalleryItem(
//       id: json['id'],
//       thumbnail: json['thumbnail'],
//       original: json['original'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'thumbnail': thumbnail,
//       'original': original,
//     };
//   }
// }

class ProductCategory {
  final int id;
  final String name;
  // final int businessId;
  // final String? shortCode;
  // final int parentId;
  // final int createdBy;
  // final int featured;
  // final String? woocommerceCatId;
  // final String? categoryType;
  final String description;
  // final String? catImage;
  // final String? slug;
  // final String? deletedAt;
  // final String createdAt;
  // final String updatedAt;
  // final String arabicName;
  // final int showOnStorefront;
  // final int sort;
  // final String? darazCategoryId;

  ProductCategory({
    required this.id,
    required this.name,
    // required this.businessId,
    // this.shortCode,
    // required this.parentId,
    // required this.createdBy,
    // required this.featured,
    // this.woocommerceCatId,
    // this.categoryType,
    required this.description,
    // this.catImage,
    // this.slug,
    // this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.arabicName,
    // required this.showOnStorefront,
    // required this.sort,
    // this.darazCategoryId,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
      // businessId: json['business_id'],
      // shortCode: json['short_code'],
      // parentId: json['parent_id'],
      // createdBy: json['created_by'],
      // featured: json['featured'],
      // woocommerceCatId: json['woocommerce_cat_id'] as String?,
      // categoryType: json['category_type'] as String?,
      description: json['description'] ?? '',
      // catImage: json['cat_image'],
      // slug: json['slug'] as String?,
      // deletedAt: json['deleted_at'] as String?,
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
      // arabicName: json['arabic_name'],
      // showOnStorefront: json['show_on_storefront'],
      // sort: json['sort'],
      // darazCategoryId: json['daraz_category_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      // 'business_id': businessId,
      // 'short_code': shortCode,
      // 'parent_id': parentId,
      // 'created_by': createdBy,
      // 'featured': featured,
      // 'woocommerce_cat_id': woocommerceCatId,
      // 'category_type': categoryType,
      'description': description,
      // 'cat_image': catImage,
      // 'slug': slug,
      // 'deleted_at': deletedAt,
      // 'created_at': createdAt,
      // 'updated_at': updatedAt,
      // 'arabic_name': arabicName,
      // 'show_on_storefront': showOnStorefront,
      // 'sort': sort,
      // 'daraz_category_id': darazCategoryId,
    };
  }
}

// class SubCategory {
//   final int id;
//   final String name;
//   final int businessId;
//   final String shortCode;
//   final int parentId;
//   final int createdBy;
//   final int featured;
//   final String? woocommerceCatId;
//   final String? categoryType;
//   final String? description;
//   final String? catImage;
//   final String? slug;
//   final String? deletedAt;
//   final String createdAt;
//   final String updatedAt;
//   final String arabicName;
//   final int showOnStorefront;
//   final int sort;
//   final String? darazCategoryId;

//   SubCategory({
//     required this.id,
//     required this.name,
//     required this.businessId,
//     required this.shortCode,
//     required this.parentId,
//     required this.createdBy,
//     required this.featured,
//     this.woocommerceCatId,
//     this.categoryType,
//     this.description,
//     this.catImage,
//     this.slug,
//     this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.arabicName,
//     required this.showOnStorefront,
//     required this.sort,
//     this.darazCategoryId,
//   });

//   factory SubCategory.fromJson(Map<String, dynamic> json) {
//     return SubCategory(
//       id: json['id'],
//       name: json['name'],
//       businessId: json['business_id'],
//       shortCode: json['short_code'],
//       parentId: json['parent_id'],
//       createdBy: json['created_by'],
//       featured: json['featured'],
//       woocommerceCatId: json['woocommerce_cat_id'],
//       categoryType: json['category_type'],
//       description: json['description'],
//       catImage: json['cat_image'],
//       slug: json['slug'],
//       deletedAt: json['deleted_at'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       arabicName: json['arabic_name'],
//       showOnStorefront: json['show_on_storefront'],
//       sort: json['sort'],
//       darazCategoryId: json['daraz_category_id'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'business_id': businessId,
//       'short_code': shortCode,
//       'parent_id': parentId,
//       'created_by': createdBy,
//       'featured': featured,
//       'woocommerce_cat_id': woocommerceCatId,
//       'category_type': categoryType,
//       'description': description,
//       'cat_image': catImage,
//       'slug': slug,
//       'deleted_at': deletedAt,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'arabic_name': arabicName,
//       'show_on_storefront': showOnStorefront,
//       'sort': sort,
//       'daraz_category_id': darazCategoryId,
//     };
//   }
// }

// class ProductTax {
//   final int id;
//   final int businessId;
//   final String name;
//   final double amount;
//   final int isTaxGroup;
//   final int forTaxGroup;
//   final int createdBy;
//   final String? woocommerceTaxRateId;
//   final String? altName;
//   final String? deletedAt;
//   final String createdAt;
//   final String updatedAt;
//   final int isDefault;

//   ProductTax({
//     required this.id,
//     required this.businessId,
//     required this.name,
//     required this.amount,
//     required this.isTaxGroup,
//     required this.forTaxGroup,
//     required this.createdBy,
//     this.woocommerceTaxRateId,
//     this.altName,
//     this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isDefault,
//   });

//   factory ProductTax.fromJson(Map<String, dynamic> json) {
//     return ProductTax(
//       id: json['id'],
//       businessId: json['business_id'],
//       name: json['name'],
//       amount: json['amount'].toDouble(),
//       isTaxGroup: json['is_tax_group'],
//       forTaxGroup: json['for_tax_group'],
//       createdBy: json['created_by'],
//       woocommerceTaxRateId: json['woocommerce_tax_rate_id'] as String?,
//       altName: json['alt_name'] as String?,
//       deletedAt: json['deleted_at'] as String?,
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       isDefault: json['is_default'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'business_id': businessId,
//       'name': name,
//       'amount': amount,
//       'is_tax_group': isTaxGroup,
//       'for_tax_group': forTaxGroup,
//       'created_by': createdBy,
//       'woocommerce_tax_rate_id': woocommerceTaxRateId,
//       'alt_name': altName,
//       'deleted_at': deletedAt,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'is_default': isDefault,
//     };
//   }
// }

class Variation {
  final int id;
  final String value;
  final String sku;
  final String defaultSellPrice;
  final String sellPriceIncTax;
  final String compareAtPrice;
  // final Attribute attribute;
  // final List<VariationDetail> variationDetails;

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

// class Attribute {
//   final int id;
//   final String name;
//   final String slug;

//   Attribute({
//     required this.id,
//     required this.name,
//     required this.slug,
//   });

//   factory Attribute.fromJson(Map<String, dynamic> json) {
//     return Attribute(
//       id: json['id'],
//       name: json['name'],
//       slug: json['slug'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'slug': slug,
//     };
//   }
// }

// class VariationDetail {
//   final int id;
//   final int productId;
//   final int productVariationId;
//   final int variationId;
//   final int locationId;
//   final String qtyAvailable;
//   final String createdAt;
//   final String updatedAt;

//   VariationDetail({
//     required this.id,
//     required this.productId,
//     required this.productVariationId,
//     required this.variationId,
//     required this.locationId,
//     required this.qtyAvailable,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory VariationDetail.fromJson(Map<String, dynamic> json) {
//     return VariationDetail(
//       id: json['id'],
//       productId: json['product_id'],
//       productVariationId: json['product_variation_id'],
//       variationId: json['variation_id'],
//       locationId: json['location_id'],
//       qtyAvailable: json['qty_available'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'product_id': productId,
//       'product_variation_id': productVariationId,
//       'variation_id': variationId,
//       'location_id': locationId,
//       'qty_available': qtyAvailable,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }
// }

// class ProductLocation {
//   final int id;
//   final int businessId;
//   final String locationId;
//   final String name;
//   final String? landmark;
//   final String country;
//   final String? state;
//   final String city;
//   final String zipCode;
//   final String? longitude;
//   final String? latitude;
//   final int invoiceSchemeId;
//   final int invoiceLayoutId;
//   final int saleInvoiceLayoutId;
//   final String? sellingPriceGroupId;
//   final int printReceiptOnInvoice;
//   final String receiptPrinterType;
//   final String? printerId;
//   final String? mobile;
//   final String? alternateNumber;
//   final String? email;
//   final String? website;
//   final String featuredProducts;
//   final int isActive;
//   final String defaultPaymentAccounts;
//   final String? customField1;
//   final String? customField2;
//   final String? customField3;
//   final String? customField4;
//   final String? deletedAt;
//   final String createdAt;
//   final String updatedAt;
//   final String? einvoiceSettings;
//   final String? ccsid;
//   final String? pcsid;
//   final String? image;
//   final String? description;
//   final String? shopifyLocationId;
//   final String? darazWarehouseCode;

//   ProductLocation({
//     required this.id,
//     required this.businessId,
//     required this.locationId,
//     required this.name,
//     this.landmark,
//     required this.country,
//     this.state,
//     required this.city,
//     required this.zipCode,
//     this.longitude,
//     this.latitude,
//     required this.invoiceSchemeId,
//     required this.invoiceLayoutId,
//     required this.saleInvoiceLayoutId,
//     this.sellingPriceGroupId,
//     required this.printReceiptOnInvoice,
//     required this.receiptPrinterType,
//     this.printerId,
//     this.mobile,
//     this.alternateNumber,
//     this.email,
//     this.website,
//     required this.featuredProducts,
//     required this.isActive,
//     required this.defaultPaymentAccounts,
//     this.customField1,
//     this.customField2,
//     this.customField3,
//     this.customField4,
//     this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     this.einvoiceSettings,
//     this.ccsid,
//     this.pcsid,
//     this.image,
//     this.description,
//     this.shopifyLocationId,
//     this.darazWarehouseCode,
//   });

//   factory ProductLocation.fromJson(Map<String, dynamic> json) {
//     return ProductLocation(
//       id: json['id'],
//       businessId: json['business_id'],
//       locationId: json['location_id'],
//       name: json['name'],
//       landmark: json['landmark'] as String?,
//       country: json['country'],
//       state: json['state'] as String?,
//       city: json['city'],
//       zipCode: json['zip_code'],
//       longitude: json['longitude'] as String?,
//       latitude: json['latitude'] as String?,
//       invoiceSchemeId: json['invoice_scheme_id'],
//       invoiceLayoutId: json['invoice_layout_id'],
//       saleInvoiceLayoutId: json['sale_invoice_layout_id'],
//       sellingPriceGroupId: json['selling_price_group_id'] as String?,
//       printReceiptOnInvoice: json['print_receipt_on_invoice'],
//       receiptPrinterType: json['receipt_printer_type'],
//       printerId: json['printer_id'] as String?,
//       mobile: json['mobile'],
//       alternateNumber: json['alternate_number'] as String?,
//       email: json['email'],
//       website: json['website'] as String?,
//       featuredProducts: json['featured_products'],
//       isActive: json['is_active'],
//       defaultPaymentAccounts: json['default_payment_accounts'],
//       customField1: json['custom_field1'] as String?,
//       customField2: json['custom_field2'] as String?,
//       customField3: json['custom_field3'],
//       customField4: json['custom_field4'] as String?,
//       deletedAt: json['deleted_at'] as String?,
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       einvoiceSettings: json['einvoice_settings'] as String?,
//       ccsid: json['ccsid'] as String?,
//       pcsid: json['pcsid'] as String?,
//       image: json['image'] as String?,
//       description: json['description'] as String?,
//       shopifyLocationId: json['shopify_location_id'] as String?,
//       darazWarehouseCode: json['daraz_warehouse_code'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'business_id': businessId,
//       'location_id': locationId,
//       'name': name,
//       'landmark': landmark,
//       'country': country,
//       'state': state,
//       'city': city,
//       'zip_code': zipCode,
//       'longitude': longitude,
//       'latitude': latitude,
//       'invoice_scheme_id': invoiceSchemeId,
//       'invoice_layout_id': invoiceLayoutId,
//       'sale_invoice_layout_id': saleInvoiceLayoutId,
//       'selling_price_group_id': sellingPriceGroupId,
//       'print_receipt_on_invoice': printReceiptOnInvoice,
//       'receipt_printer_type': receiptPrinterType,
//       'printer_id': printerId,
//       'mobile': mobile,
//       'alternate_number': alternateNumber,
//       'email': email,
//       'website': website,
//       'featured_products': featuredProducts,
//       'is_active': isActive,
//       'default_payment_accounts': defaultPaymentAccounts,
//       'custom_field1': customField1,
//       'custom_field2': customField2,
//       'custom_field3': customField3,
//       'custom_field4': customField4,
//       'deleted_at': deletedAt,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'einvoice_settings': einvoiceSettings,
//       'ccsid': ccsid,
//       'pcsid': pcsid,
//       'image': image,
//       'description': description,
//       'shopify_location_id': shopifyLocationId,
//       'daraz_warehouse_code': darazWarehouseCode,
//     };
//   }
//}
