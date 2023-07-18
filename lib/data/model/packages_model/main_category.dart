import 'dart:convert';

import 'package:equatable/equatable.dart';

class MainCategory extends Equatable {
  final int? id;
  final String? name;
  final String? slug;
  final String? image;
  final String? city;
  final String? seoTitle;
  final String? seoDesc;
  final String? seoKey;
  final int? sortOrder;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? mainCategoryImageUrl;

  const MainCategory({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.city,
    this.seoTitle,
    this.seoDesc,
    this.seoKey,
    this.sortOrder,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.mainCategoryImageUrl,
  });

  factory MainCategory.fromMap(Map<String, dynamic> data) => MainCategory(
        id: data['id'] as int?,
        name: data['name'] as String?,
        slug: data['slug'] as String?,
        image: data['image'] as String?,
        city: data['city'] as String?,
        seoTitle: data['seo_title'] as String?,
        seoDesc: data['seo_desc'] as String?,
        seoKey: data['seo_key'] as String?,
        sortOrder: data['sort_order'] as int?,
        status: data['status'] as String?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        mainCategoryImageUrl: data['main_category_image_url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'slug': slug,
        'image': image,
        'city': city,
        'seo_title': seoTitle,
        'seo_desc': seoDesc,
        'seo_key': seoKey,
        'sort_order': sortOrder,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'main_category_image_url': mainCategoryImageUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MainCategory].
  factory MainCategory.fromJson(String data) {
    return MainCategory.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MainCategory] to a JSON string.
  String toJson() => json.encode(toMap());

  MainCategory copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    String? city,
    String? seoTitle,
    String? seoDesc,
    String? seoKey,
    int? sortOrder,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? mainCategoryImageUrl,
  }) {
    return MainCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      city: city ?? this.city,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDesc: seoDesc ?? this.seoDesc,
      seoKey: seoKey ?? this.seoKey,
      sortOrder: sortOrder ?? this.sortOrder,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mainCategoryImageUrl: mainCategoryImageUrl ?? this.mainCategoryImageUrl,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      slug,
      image,
      city,
      seoTitle,
      seoDesc,
      seoKey,
      sortOrder,
      status,
      createdAt,
      updatedAt,
      mainCategoryImageUrl,
    ];
  }
}
