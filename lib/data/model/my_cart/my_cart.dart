import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'extra_fee.dart';
import 'products_array.dart';

class MyCart extends Equatable {
  final String? status;
  final String? message;
  final List<ProductsArray>? productsArray;
  final dynamic tax;
  final List<ExtraFee>? extraFees;

  const MyCart({
    this.status,
    this.message,
    this.productsArray,
    this.tax,
    this.extraFees,
  });

  factory MyCart.fromMap(Map<String, dynamic> data) => MyCart(
        status: data['status'] as String?,
        message: data['message'] as String?,
        productsArray: (data['productsArray'] as List<dynamic>?)
            ?.map((e) => ProductsArray.fromMap(e as Map<String, dynamic>))
            .toList(),
        tax: data['tax'] as dynamic,
        extraFees: (data['extraFees'] as List<dynamic>?)
            ?.map((e) => ExtraFee.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'productsArray': productsArray?.map((e) => e.toMap()).toList(),
        'tax': tax,
        'extraFees': extraFees?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MyCart].
  factory MyCart.fromJson(String data) {
    return MyCart.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MyCart] to a JSON string.
  String toJson() => json.encode(toMap());

  MyCart copyWith({
    String? status,
    String? message,
    List<ProductsArray>? productsArray,
    dynamic tax,
    List<ExtraFee>? extraFees,
  }) {
    return MyCart(
      status: status ?? this.status,
      message: message ?? this.message,
      productsArray: productsArray ?? this.productsArray,
      tax: tax ?? this.tax,
      extraFees: extraFees ?? this.extraFees,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      message,
      productsArray,
      tax,
      extraFees,
    ];
  }
}
