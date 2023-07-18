import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'myCartProduct.dart';

class ProductsArray extends Equatable {
  final Map<String, MyCartProduct>? myCartProduct;

  const ProductsArray({this.myCartProduct});

  factory ProductsArray.fromMap(Map<String, dynamic> data) {
    Map<String, MyCartProduct> map = {};
    data.forEach((key, value) {
      map[key] = MyCartProduct.fromMap(value);
    });
    return ProductsArray(myCartProduct: map);
  }

  Map<String, dynamic> toMap() => {};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductsArray].
  factory ProductsArray.fromJson(String data) {
    return ProductsArray.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductsArray] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [myCartProduct];
}
