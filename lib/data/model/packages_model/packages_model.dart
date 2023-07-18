import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'packages_category.dart';
import 'main_category.dart';

class PackagesModel extends Equatable {
  final String? status;
  final String? message;
  final MainCategory? mainCategory;
  final List<PackagesCategory>? categories;

  const PackagesModel({
    this.status,
    this.message,
    this.mainCategory,
    this.categories,
  });

  factory PackagesModel.fromMap(Map<String, dynamic> data) => PackagesModel(
        status: data['status'] as String?,
        message: data['message'] as String?,
        mainCategory: data['mainCategory'] == null
            ? null
            : MainCategory.fromMap(
                data['mainCategory'] as Map<String, dynamic>),
        categories: (data['categories'] as List<dynamic>?)
            ?.map((e) => PackagesCategory.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'mainCategory': mainCategory?.toMap(),
        'categories': categories?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PackagesModel].
  factory PackagesModel.fromJson(String data) {
    return PackagesModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PackagesModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PackagesModel copyWith({
    String? status,
    String? message,
    MainCategory? mainCategory,
    List<PackagesCategory>? categories,
  }) {
    return PackagesModel(
      status: status ?? this.status,
      message: message ?? this.message,
      mainCategory: mainCategory ?? this.mainCategory,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [status, message, mainCategory, categories];
}
