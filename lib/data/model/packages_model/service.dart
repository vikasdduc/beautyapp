import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:glamcode/data/model/packages_model/category.dart';

class ServicePackage extends Equatable {
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final dynamic mobileLongDescription;
  final dynamic mobileLongDescription2;
  final dynamic mobileLongDescription3;
  final dynamic mobileLongDescription4;
  final String? longDescription;
  final num? price;
  final int? time;
  final int? sort;
  final String? timeType;
  final num? discount;
  final String? discountType;
  final int? mainCategoryId;
  final int? categoryId;
  final dynamic subCategoryId;
  final int? packagesId;
  final int? locationId;
  final List<dynamic>? image;
  final String? defaultImage;
  final String? status;
  final String? preferedService;
  final String? locationCity;
  final dynamic seoTitle;
  final dynamic seoDesc;
  final dynamic seoKey;
  final String? createdAt;
  final String? updatedAt;
  final String? ratingPer;
  final int? ratingPop;
  final String? serviceImageUrl;
  final String? serviceDetailUrl;
  final num? discountedPrice;
  final Category? category;

  const ServicePackage({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.mobileLongDescription,
    this.mobileLongDescription2,
    this.mobileLongDescription3,
    this.mobileLongDescription4,
    this.longDescription,
    this.price,
    this.time,
    this.sort,
    this.timeType,
    this.discount,
    this.discountType,
    this.mainCategoryId,
    this.categoryId,
    this.subCategoryId,
    this.packagesId,
    this.locationId,
    this.image,
    this.defaultImage,
    this.status,
    this.preferedService,
    this.locationCity,
    this.seoTitle,
    this.seoDesc,
    this.seoKey,
    this.createdAt,
    this.updatedAt,
    this.ratingPer,
    this.ratingPop,
    this.serviceImageUrl,
    this.serviceDetailUrl,
    this.discountedPrice,
    this.category,
  });

  factory ServicePackage.fromMap(Map<String, dynamic> data) => ServicePackage(
        id: data['id'] as int?,
        name: data['name'] as String?,
        slug: data['slug'] as String?,
        description: data['description'] as String?,
        mobileLongDescription: data['mobile_long_description'] as dynamic,
        mobileLongDescription2: data['mobile_long_description2'] as dynamic,
        mobileLongDescription3: data['mobile_long_description3'] as dynamic,
        mobileLongDescription4: data['mobile_long_description4'] as dynamic,
        longDescription: data['long_description'] as String?,
        price: data['price'] as num?,
        time: data['time'] as int?,
        sort: data['sort'] as int?,
        timeType: data['time_type'] as String?,
        discount: data['discount'] as num?,
        discountType: data['discount_type'] as String?,
        mainCategoryId: data['main_category_id'] as int?,
        categoryId: data['category_id'] as int?,
        subCategoryId: data['sub_category_id'] as dynamic,
        packagesId: data['packages_id'] as int?,
        locationId: data['location_id'] as int?,
        image: data['image'] as List<dynamic>?,
        defaultImage: data['default_image'] as String?,
        status: data['status'] as String?,
        preferedService: data['prefered_service'] as String?,
        locationCity: data['location_city'] as String?,
        seoTitle: data['seo_title'] as dynamic,
        seoDesc: data['seo_desc'] as dynamic,
        seoKey: data['seo_key'] as dynamic,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        ratingPer: data['rating_per'] as String?,
        ratingPop: data['rating_pop'] as int?,
        serviceImageUrl: data['service_image_url'] as String?,
        serviceDetailUrl: data['service_detail_url'] as String?,
        discountedPrice: data['discounted_price'] as num?,
        category: data['category'] == null
            ? null
            : Category.fromMap(data['category'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'slug': slug,
        'description': description,
        'mobile_long_description': mobileLongDescription,
        'mobile_long_description2': mobileLongDescription2,
        'mobile_long_description3': mobileLongDescription3,
        'mobile_long_description4': mobileLongDescription4,
        'long_description': longDescription,
        'price': price,
        'time': time,
        'sort': sort,
        'time_type': timeType,
        'discount': discount,
        'discount_type': discountType,
        'main_category_id': mainCategoryId,
        'category_id': categoryId,
        'sub_category_id': subCategoryId,
        'packages_id': packagesId,
        'location_id': locationId,
        'image': image,
        'default_image': defaultImage,
        'status': status,
        'prefered_service': preferedService,
        'location_city': locationCity,
        'seo_title': seoTitle,
        'seo_desc': seoDesc,
        'seo_key': seoKey,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'rating_per': ratingPer,
        'rating_pop': ratingPop,
        'service_image_url': serviceImageUrl,
        'service_detail_url': serviceDetailUrl,
        'discounted_price': discountedPrice,
        'category': category?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ServicePackage].
  factory ServicePackage.fromJson(String data) {
    return ServicePackage.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ServicePackage] to a JSON string.
  String toJson() => json.encode(toMap());

  ServicePackage copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    dynamic mobileLongDescription,
    dynamic mobileLongDescription2,
    dynamic mobileLongDescription3,
    dynamic mobileLongDescription4,
    String? longDescription,
    num? price,
    int? time,
    int? sort,
    String? timeType,
    num? discount,
    String? discountType,
    int? mainCategoryId,
    int? categoryId,
    dynamic subCategoryId,
    int? packagesId,
    int? locationId,
    List<dynamic>? image,
    String? defaultImage,
    String? status,
    String? preferedService,
    String? locationCity,
    dynamic seoTitle,
    dynamic seoDesc,
    dynamic seoKey,
    String? createdAt,
    String? updatedAt,
    String? ratingPer,
    int? ratingPop,
    String? serviceImageUrl,
    String? serviceDetailUrl,
    num? discountedPrice,
    Category? category,
  }) {
    return ServicePackage(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      mobileLongDescription:
          mobileLongDescription ?? this.mobileLongDescription,
      mobileLongDescription2:
          mobileLongDescription2 ?? this.mobileLongDescription2,
      mobileLongDescription3:
          mobileLongDescription3 ?? this.mobileLongDescription3,
      mobileLongDescription4:
          mobileLongDescription4 ?? this.mobileLongDescription4,
      longDescription: longDescription ?? this.longDescription,
      price: price ?? this.price,
      time: time ?? this.time,
      sort: sort ?? this.sort,
      timeType: timeType ?? this.timeType,
      discount: discount ?? this.discount,
      discountType: discountType ?? this.discountType,
      mainCategoryId: mainCategoryId ?? this.mainCategoryId,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      packagesId: packagesId ?? this.packagesId,
      locationId: locationId ?? this.locationId,
      image: image ?? this.image,
      defaultImage: defaultImage ?? this.defaultImage,
      status: status ?? this.status,
      preferedService: preferedService ?? this.preferedService,
      locationCity: locationCity ?? this.locationCity,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDesc: seoDesc ?? this.seoDesc,
      seoKey: seoKey ?? this.seoKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ratingPer: ratingPer ?? this.ratingPer,
      ratingPop: ratingPop ?? this.ratingPop,
      serviceImageUrl: serviceImageUrl ?? this.serviceImageUrl,
      serviceDetailUrl: serviceDetailUrl ?? this.serviceDetailUrl,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      slug,
      description,
      mobileLongDescription,
      mobileLongDescription2,
      mobileLongDescription3,
      mobileLongDescription4,
      longDescription,
      price,
      time,
      sort,
      timeType,
      discount,
      discountType,
      mainCategoryId,
      categoryId,
      subCategoryId,
      packagesId,
      locationId,
      image,
      defaultImage,
      status,
      preferedService,
      locationCity,
      seoTitle,
      seoDesc,
      seoKey,
      createdAt,
      updatedAt,
      ratingPer,
      ratingPop,
      serviceImageUrl,
      serviceDetailUrl,
      discountedPrice,
      category,
    ];
  }
}
