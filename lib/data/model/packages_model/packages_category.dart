import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'service.dart';

class PackagesCategory extends Equatable {
  final int? id;
  final String? mainCategoryId;
  final String? name;
  final String? slug;
  final String? image;
  final String? status;
  final int? sortOrder;
  final String? createdAt;
  final String? updatedAt;
  final String? ratingPer;
  final int? ratingPop;
  final List<ServicePackage>? service;
  final String? categoryImageUrl;

  const PackagesCategory({
    this.id,
    this.mainCategoryId,
    this.name,
    this.slug,
    this.image,
    this.status,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.ratingPer,
    this.ratingPop,
    this.service,
    this.categoryImageUrl,
  });

  factory PackagesCategory.fromMap(Map<String, dynamic> data) =>
      PackagesCategory(
        id: data['id'] as int?,
        mainCategoryId: data['main_category_id'] as String?,
        name: data['name'] as String?,
        slug: data['slug'] as String?,
        image: data['image'] as String?,
        status: data['status'] as String?,
        sortOrder: data['sort_order'] as int?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        ratingPer: data['rating_per'] as String?,
        ratingPop: data['rating_pop'] as int?,
        service: (data['service'] as List<dynamic>?)
            ?.map((e) => ServicePackage.fromMap(e as Map<String, dynamic>))
            .toList(),
        categoryImageUrl: data['category_image_url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'main_category_id': mainCategoryId,
        'name': name,
        'slug': slug,
        'image': image,
        'status': status,
        'sort_order': sortOrder,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'rating_per': ratingPer,
        'rating_pop': ratingPop,
        'service': service?.map((e) => e.toMap()).toList(),
        'category_image_url': categoryImageUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PackagesCategory].
  factory PackagesCategory.fromJson(String data) {
    return PackagesCategory.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PackagesCategory] to a JSON string.
  String toJson() => json.encode(toMap());

  PackagesCategory copyWith({
    int? id,
    String? mainCategoryId,
    String? name,
    String? slug,
    String? image,
    String? status,
    int? sortOrder,
    String? createdAt,
    String? updatedAt,
    String? ratingPer,
    int? ratingPop,
    List<ServicePackage>? service,
    String? categoryImageUrl,
  }) {
    return PackagesCategory(
      id: id ?? this.id,
      mainCategoryId: mainCategoryId ?? this.mainCategoryId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ratingPer: ratingPer ?? this.ratingPer,
      ratingPop: ratingPop ?? this.ratingPop,
      service: service ?? this.service,
      categoryImageUrl: categoryImageUrl ?? this.categoryImageUrl,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      mainCategoryId,
      name,
      slug,
      image,
      status,
      sortOrder,
      createdAt,
      updatedAt,
      ratingPer,
      ratingPop,
      service,
      categoryImageUrl,
    ];
  }
}
