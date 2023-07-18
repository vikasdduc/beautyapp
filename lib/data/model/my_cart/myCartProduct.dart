import 'dart:convert';

import 'package:equatable/equatable.dart';

class MyCartProduct extends Equatable {
  final String? serviceId;
  final String? servicePrice;
  final String? serviceName;
  final dynamic serviceDiscount;
  final dynamic serviceOriginalPrice;
  final String? type;
  final String? serviceImage;
  final String? serviceQuantity;

  const MyCartProduct({
    this.serviceId,
    this.servicePrice,
    this.serviceName,
    this.serviceDiscount,
    this.serviceOriginalPrice,
    this.type,
    this.serviceImage,
    this.serviceQuantity,
  });

  factory MyCartProduct.fromMap(Map<String, dynamic> data) => MyCartProduct(
        serviceId: data['serviceID'] as String?,
        servicePrice: data['servicePrice'] as String?,
        serviceName: data['serviceName'] as String?,
        serviceDiscount: data['serviceDiscount'] as dynamic,
        serviceOriginalPrice: data['serviceOriginalPrice'] as dynamic,
        type: data['type'] as String?,
        serviceImage: data['serviceImage'] as String?,
        serviceQuantity: data['serviceQuantity'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'serviceID': serviceId,
        'servicePrice': servicePrice,
        'serviceName': serviceName,
        'serviceDiscount': serviceDiscount,
        'serviceOriginalPrice': serviceOriginalPrice,
        'type': type,
        'serviceImage': serviceImage,
        'serviceQuantity': serviceQuantity,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MyCartProduct].
  factory MyCartProduct.fromJson(String data) {
    return MyCartProduct.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MyCartProduct] to a JSON string.
  String toJson() => json.encode(toMap());

  MyCartProduct copyWith({
    String? serviceId,
    String? servicePrice,
    String? serviceName,
    dynamic serviceDiscount,
    dynamic serviceOriginalPrice,
    String? type,
    String? serviceImage,
    String? serviceQuantity,
  }) {
    return MyCartProduct(
      serviceId: serviceId ?? this.serviceId,
      servicePrice: servicePrice ?? this.servicePrice,
      serviceName: serviceName ?? this.serviceName,
      serviceDiscount: serviceDiscount ?? this.serviceDiscount,
      serviceOriginalPrice: serviceOriginalPrice ?? this.serviceOriginalPrice,
      type: type ?? this.type,
      serviceImage: serviceImage ?? this.serviceImage,
      serviceQuantity: serviceQuantity ?? this.serviceQuantity,
    );
  }

  @override
  List<Object?> get props {
    return [
      serviceId,
      servicePrice,
      serviceName,
      serviceDiscount,
      serviceOriginalPrice,
      type,
      serviceImage,
      serviceQuantity,
    ];
  }
}
