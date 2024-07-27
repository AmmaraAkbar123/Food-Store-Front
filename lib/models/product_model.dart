class ProductModel {
  int id;
  String name;
  String? description;
  String slug;
  String? productSlug; // Changed to String? based on the API response
  int taxId;
  String type;
  int enableStock;
  String alertQuantity;
  String? arabicName;
  String? calories;
  ImageModel image;
  List<dynamic> gallery;
  double price;
  ProductCategory category;
  List<dynamic> sizeChart;
  dynamic subCategory;
  ProductTax productTax;
  List<Variation> variations;
  List<ProductLocation> productLocations;
  dynamic domain;
  Brand brands;
  String merchantName;
  dynamic city;
  dynamic promotions;
  List<dynamic> tags;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.slug,
    this.productSlug,
    required this.taxId,
    required this.type,
    required this.enableStock,
    required this.alertQuantity,
    this.arabicName,
    this.calories,
    required this.image,
    required this.gallery,
    required this.price,
    required this.category,
    required this.sizeChart,
    this.subCategory,
    required this.productTax,
    required this.variations,
    required this.productLocations,
    this.domain,
    required this.brands,
    required this.merchantName,
    this.city,
    this.promotions,
    required this.tags,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      slug: json['slug'].toString(), // Ensuring slug is a string
      productSlug: json['product_slug'],
      taxId: json['tax_id'],
      type: json['type'],
      enableStock: json['enable_stock'],
      alertQuantity:
          json['alert_quantity'].toString(), // Handling possible type mismatch
      arabicName: json['arabic_name'],
      calories: json['calories'],
      image: ImageModel.fromJson(json['image']),
      gallery: List<dynamic>.from(json['gallery']),
      price: json['price'].toDouble(), // Ensuring the price is a double
      category: ProductCategory.fromJson(json['category']),
      sizeChart: List<dynamic>.from(json['size_chart']),
      subCategory: json['sub_category'],
      productTax: ProductTax.fromJson(json['product_tax']),
      variations: List<Variation>.from(
          json['variations'].map((x) => Variation.fromJson(x))),
      productLocations: List<ProductLocation>.from(
          json['product_locations'].map((x) => ProductLocation.fromJson(x))),
      domain: json['domain'],
      brands: Brand.fromJson(json['brands']),
      merchantName: json['merchant_name'],
      city: json['city'],
      promotions: json['promotions'],
      tags: List<dynamic>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'slug': slug,
      'product_slug': productSlug,
      'tax_id': taxId,
      'type': type,
      'enable_stock': enableStock,
      'alert_quantity': alertQuantity,
      'arabic_name': arabicName,
      'calories': calories,
      'image': image.toJson(),
      'gallery': List<dynamic>.from(gallery),
      'price': price,
      'category': category.toJson(),
      'size_chart': List<dynamic>.from(sizeChart),
      'sub_category': subCategory,
      'product_tax': productTax.toJson(),
      'variations': List<dynamic>.from(variations.map((x) => x.toJson())),
      'product_locations':
          List<dynamic>.from(productLocations.map((x) => x.toJson())),
      'domain': domain,
      'brands': brands.toJson(),
      'merchant_name': merchantName,
      'city': city,
      'promotions': promotions,
      'tags': List<dynamic>.from(tags),
    };
  }
}

class ImageModel {
  int id;
  String thumbnail;
  String original;

  ImageModel({
    required this.id,
    required this.thumbnail,
    required this.original,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
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
  int id;
  String name;
  int businessId;
  String? shortCode;
  int parentId;
  int createdBy;
  int featured;
  String? woocommerceCatId;
  String categoryType;
  String? description;
  String? catImage;
  String? slug;
  String? deletedAt;
  String createdAt;
  String updatedAt;
  String? arabicName;
  int showOnStorefront;
  int sort;
  String? darazCategoryId;
  List<dynamic> sizeChart;
  List<dynamic> customFields;

  ProductCategory({
    required this.id,
    required this.name,
    required this.businessId,
    this.shortCode,
    required this.parentId,
    required this.createdBy,
    required this.featured,
    this.woocommerceCatId,
    required this.categoryType,
    this.description,
    this.catImage,
    this.slug,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.arabicName,
    required this.showOnStorefront,
    required this.sort,
    this.darazCategoryId,
    required this.sizeChart,
    required this.customFields,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
      businessId: json['business_id'],
      shortCode: json['short_code'],
      parentId: json['parent_id'],
      createdBy: json['created_by'],
      featured: json['featured'],
      woocommerceCatId: json['woocommerce_cat_id'],
      categoryType: json['category_type'],
      description: json['description'],
      catImage: json['cat_image'],
      slug: json['slug'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      arabicName: json['arabic_name'],
      showOnStorefront: json['show_on_storefront'],
      sort: json['sort'],
      darazCategoryId: json['daraz_category_id'],
      sizeChart: List<dynamic>.from(json['size_chart']),
      customFields: List<dynamic>.from(json['custom_fields']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'business_id': businessId,
      'short_code': shortCode,
      'parent_id': parentId,
      'created_by': createdBy,
      'featured': featured,
      'woocommerce_cat_id': woocommerceCatId,
      'category_type': categoryType,
      'description': description,
      'cat_image': catImage,
      'slug': slug,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'arabic_name': arabicName,
      'show_on_storefront': showOnStorefront,
      'sort': sort,
      'daraz_category_id': darazCategoryId,
      'size_chart': List<dynamic>.from(sizeChart),
      'custom_fields': List<dynamic>.from(customFields),
    };
  }
}

class ProductTax {
  int id;
  int businessId;
  String name;
  int amount;
  int isTaxGroup;
  int forTaxGroup;
  int createdBy;
  String? woocommerceTaxRateId;
  String? altName;
  String? deletedAt;
  String createdAt;
  String updatedAt;
  int isDefault;

  ProductTax({
    required this.id,
    required this.businessId,
    required this.name,
    required this.amount,
    required this.isTaxGroup,
    required this.forTaxGroup,
    required this.createdBy,
    this.woocommerceTaxRateId,
    this.altName,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isDefault,
  });

  factory ProductTax.fromJson(Map<String, dynamic> json) {
    return ProductTax(
      id: json['id'],
      businessId: json['business_id'],
      name: json['name'],
      amount: json['amount'],
      isTaxGroup: json['is_tax_group'],
      forTaxGroup: json['for_tax_group'],
      createdBy: json['created_by'],
      woocommerceTaxRateId: json['woocommerce_tax_rate_id'],
      altName: json['alt_name'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isDefault: json['is_default'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'name': name,
      'amount': amount,
      'is_tax_group': isTaxGroup,
      'for_tax_group': forTaxGroup,
      'created_by': createdBy,
      'woocommerce_tax_rate_id': woocommerceTaxRateId,
      'alt_name': altName,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_default': isDefault,
    };
  }
}

class Variation {
  int id;
  String value;
  String sku;
  double defaultSellPrice;
  double sellPriceIncTax;
  String compareAtPrice;
  Attribute attribute;
  List<VariationDetail> variationDetails;

  Variation({
    required this.id,
    required this.value,
    required this.sku,
    required this.defaultSellPrice,
    required this.sellPriceIncTax,
    required this.compareAtPrice,
    required this.attribute,
    required this.variationDetails,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      id: json['id'],
      value: json['value'],
      sku: json['sku'],
      defaultSellPrice: json['default_sell_price'].toDouble(),
      sellPriceIncTax: json['sell_price_inc_tax'].toDouble(),
      compareAtPrice: json['compare_at_price'],
      attribute: Attribute.fromJson(json['attribute']),
      variationDetails: List<VariationDetail>.from(
          json['variation_details'].map((x) => VariationDetail.fromJson(x))),
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
      'attribute': attribute.toJson(),
      'variation_details':
          List<dynamic>.from(variationDetails.map((x) => x.toJson())),
    };
  }
}

class Attribute {
  int id;
  String name;
  String slug;

  Attribute({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}

class VariationDetail {
  int id;
  int productId;
  int productVariationId;
  int variationId;
  int locationId;
  String qtyAvailable;
  String createdAt;
  String updatedAt;

  VariationDetail({
    required this.id,
    required this.productId,
    required this.productVariationId,
    required this.variationId,
    required this.locationId,
    required this.qtyAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VariationDetail.fromJson(Map<String, dynamic> json) {
    return VariationDetail(
      id: json['id'],
      productId: json['product_id'],
      productVariationId: json['product_variation_id'],
      variationId: json['variation_id'],
      locationId: json['location_id'],
      qtyAvailable: json['qty_available'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_variation_id': productVariationId,
      'variation_id': variationId,
      'location_id': locationId,
      'qty_available': qtyAvailable,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class ProductLocation {
  int id;
  int businessId;
  String locationId;
  String name;
  String? landmark;
  String country;
  String? state;
  String? city;
  String zipCode;
  String? longitude;
  String? latitude;
  int invoiceSchemeId;
  int invoiceLayoutId;
  int saleInvoiceLayoutId;
  int? sellingPriceGroupId;
  int printReceiptOnInvoice;
  String receiptPrinterType;
  int? printerId;
  String mobile;
  String? alternateNumber;
  String email;
  String? website;
  String? featuredProducts;
  int isActive;
  String defaultPaymentAccounts;
  String customField1;
  String customField2;
  String customField3;
  String? customField4;
  String? deletedAt;
  String createdAt;
  String updatedAt;
  String? einvoiceSettings;
  String? ccsid;
  String? pcsid;
  String? image;
  String? description;
  String? shopifyLocationId;
  String? darazWarehouseCode;
  Pivot pivot;

  ProductLocation({
    required this.id,
    required this.businessId,
    required this.locationId,
    required this.name,
    this.landmark,
    required this.country,
    this.state,
    this.city,
    required this.zipCode,
    this.longitude,
    this.latitude,
    required this.invoiceSchemeId,
    required this.invoiceLayoutId,
    required this.saleInvoiceLayoutId,
    this.sellingPriceGroupId,
    required this.printReceiptOnInvoice,
    required this.receiptPrinterType,
    this.printerId,
    required this.mobile,
    this.alternateNumber,
    required this.email,
    this.website,
    this.featuredProducts,
    required this.isActive,
    required this.defaultPaymentAccounts,
    required this.customField1,
    required this.customField2,
    required this.customField3,
    this.customField4,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.einvoiceSettings,
    this.ccsid,
    this.pcsid,
    this.image,
    this.description,
    this.shopifyLocationId,
    this.darazWarehouseCode,
    required this.pivot,
  });

  factory ProductLocation.fromJson(Map<String, dynamic> json) {
    return ProductLocation(
      id: json['id'],
      businessId: json['business_id'],
      locationId: json['location_id'],
      name: json['name'],
      landmark: json['landmark'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      zipCode: json['zip_code'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      invoiceSchemeId: json['invoice_scheme_id'],
      invoiceLayoutId: json['invoice_layout_id'],
      saleInvoiceLayoutId: json['sale_invoice_layout_id'],
      sellingPriceGroupId: json['selling_price_group_id'],
      printReceiptOnInvoice: json['print_receipt_on_invoice'],
      receiptPrinterType: json['receipt_printer_type'],
      printerId: json['printer_id'],
      mobile: json['mobile'],
      alternateNumber: json['alternate_number'],
      email: json['email'],
      website: json['website'],
      featuredProducts: json['featured_products'],
      isActive: json['is_active'],
      defaultPaymentAccounts: json['default_payment_accounts'],
      customField1: json['custom_field1'],
      customField2: json['custom_field2'],
      customField3: json['custom_field3'],
      customField4: json['custom_field4'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      einvoiceSettings: json['einvoice_settings'],
      ccsid: json['ccsid'],
      pcsid: json['pcsid'],
      image: json['image'],
      description: json['description'],
      shopifyLocationId: json['shopify_location_id'],
      darazWarehouseCode: json['daraz_warehouse_code'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'location_id': locationId,
      'name': name,
      'landmark': landmark,
      'country': country,
      'state': state,
      'city': city,
      'zip_code': zipCode,
      'longitude': longitude,
      'latitude': latitude,
      'invoice_scheme_id': invoiceSchemeId,
      'invoice_layout_id': invoiceLayoutId,
      'sale_invoice_layout_id': saleInvoiceLayoutId,
      'selling_price_group_id': sellingPriceGroupId,
      'print_receipt_on_invoice': printReceiptOnInvoice,
      'receipt_printer_type': receiptPrinterType,
      'printer_id': printerId,
      'mobile': mobile,
      'alternate_number': alternateNumber,
      'email': email,
      'website': website,
      'featured_products': featuredProducts,
      'is_active': isActive,
      'default_payment_accounts': defaultPaymentAccounts,
      'custom_field1': customField1,
      'custom_field2': customField2,
      'custom_field3': customField3,
      'custom_field4': customField4,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'einvoice_settings': einvoiceSettings,
      'ccsid': ccsid,
      'pcsid': pcsid,
      'image': image,
      'description': description,
      'shopify_location_id': shopifyLocationId,
      'daraz_warehouse_code': darazWarehouseCode,
      'pivot': pivot.toJson(),
    };
  }
}

class Pivot {
  int productId;
  int locationId;

  Pivot({
    required this.productId,
    required this.locationId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      productId: json['product_id'],
      locationId: json['location_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'location_id': locationId,
    };
  }
}

class Brand {
  int id;
  int businessId;
  String name;
  String? description;
  int createdBy;
  String? image;
  String? deletedAt;
  String createdAt;
  String updatedAt;
  String? arabicName;
  String? darazBrandId;

  Brand({
    required this.id,
    required this.businessId,
    required this.name,
    this.description,
    required this.createdBy,
    this.image,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.arabicName,
    this.darazBrandId,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      businessId: json['business_id'],
      name: json['name'],
      description: json['description'],
      createdBy: json['created_by'],
      image: json['image'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      arabicName: json['arabic_name'],
      darazBrandId: json['daraz_brand_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'name': name,
      'description': description,
      'created_by': createdBy,
      'image': image,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'arabic_name': arabicName,
      'daraz_brand_id': darazBrandId,
    };
  }
}
