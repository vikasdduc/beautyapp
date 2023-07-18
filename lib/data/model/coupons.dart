import 'dart:convert';

import 'package:equatable/equatable.dart';

/// status : "success"
/// message : "Coupons List Records"
/// couponData : [{"id":11,"title":"gcnew","start_date_time":"2022-03-12 00:02:00","end_date_time":"2022-12-31 00:02:00","uses_limit":100,"used_time":6,"amount":200,"percent":5,"minimum_purchase_amount":900,"days":"[\"Monday\",\"Tuesday\",\"Wednesday\",\"Thursday\",\"Friday\",\"Saturday\"]","status":"active","description":null,"created_at":"2022-03-12 11:44:15","updated_at":"2022-12-16 10:26:28"},{"id":13,"title":"xmas10","start_date_time":"2022-12-24 09:18:00","end_date_time":"2023-01-01 09:18:00","uses_limit":100,"used_time":32,"amount":100,"percent":null,"minimum_purchase_amount":1599,"days":"[\"Sunday\",\"Monday\",\"Tuesday\",\"Wednesday\",\"Thursday\",\"Friday\",\"Saturday\"]","status":"active","description":null,"created_at":"2022-08-07 15:19:00","updated_at":"2022-12-24 12:46:47"}]

Coupons couponsFromJson(String str) => Coupons.fromJson(json.decode(str));
String couponsToJson(Coupons data) => json.encode(data.toJson());

class Coupons extends Equatable {
  const Coupons({
    this.status,
    this.message,
    this.couponData,
  });

  final String? status;
  final String? message;
  final List<CouponData>? couponData;

  Coupons copyWith({
    String? status,
    String? message,
    List<CouponData>? couponData,
  }) =>
      Coupons(
        status: status ?? this.status,
        message: message ?? this.message,
        couponData: couponData ?? this.couponData,
      );

  factory Coupons.fromJson(String data) {
    return Coupons.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory Coupons.fromMap(Map<String, dynamic> data) {
    return Coupons(
      status: data['status'] as String?,
      message: data['message'] as String?,
      couponData: (data['couponData'] as List<dynamic>?)
          ?.map((e) => CouponData.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'couponData': couponData?.map((e) => e.toMap()).toList(),
      };

  @override
  List<Object?> get props => [status, message, couponData];
}

/// id : 11
/// title : "gcnew"
/// start_date_time : "2022-03-12 00:02:00"
/// end_date_time : "2022-12-31 00:02:00"
/// uses_limit : 100
/// used_time : 6
/// amount : 200
/// percent : 5
/// minimum_purchase_amount : 900
/// days : "[\"Monday\",\"Tuesday\",\"Wednesday\",\"Thursday\",\"Friday\",\"Saturday\"]"
/// status : "active"
/// description : null
/// created_at : "2022-03-12 11:44:15"
/// updated_at : "2022-12-16 10:26:28"

class CouponData extends Equatable {
  const CouponData({
    this.id,
    this.title,
    this.startDateTime,
    this.endDateTime,
    this.usesLimit,
    this.usedTime,
    this.amount,
    this.percent,
    this.minimumPurchaseAmount,
    this.days,  
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory CouponData.fromMap(Map<String, dynamic> json) {
    return CouponData(
      id: json['id'] as num?,
      title: json['title'] as String?,
      startDateTime: json['start_date_time'] as String?,
      endDateTime: json['end_date_time'] as String?,
      usesLimit: json['uses_limit'] as num?,
      usedTime: json['used_time'] as num?,
      amount: json['amount'] as num?,
      percent: json['percent'] as num?,
      minimumPurchaseAmount: json['minimum_purchase_amount'] as num?,
      days: json['days'] as String?,
      status: json['status'] as String?,
      description: json['description'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
  final num? id;
  final String? title;
  final String? startDateTime;
  final String? endDateTime;
  final num? usesLimit;
  final num? usedTime;
  final num? amount;
  final num? percent;
  final num? minimumPurchaseAmount;
  final String? days;
  final String? status;
  final dynamic description;
  final String? createdAt;
  final String? updatedAt;
  CouponData copyWith({
    num? id,
    String? title,
    String? startDateTime,
    String? endDateTime,
    num? usesLimit,
    num? usedTime,
    num? amount,
    num? percent,
    num? minimumPurchaseAmount,
    String? days,
    String? status,
    dynamic description,
    String? createdAt,
    String? updatedAt,
  }) {
    return CouponData(
      id: id ?? this.id,
      title: title ?? this.title,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      usesLimit: usesLimit ?? this.usesLimit,
      usedTime: usedTime ?? this.usedTime,
      amount: amount ?? this.amount,
      percent: percent ?? this.percent,
      minimumPurchaseAmount:
          minimumPurchaseAmount ?? this.minimumPurchaseAmount,
      days: days ?? this.days,
      status: status ?? this.status,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'start_date_time': startDateTime,
        'end_date_time': endDateTime,
        'uses_limit': usesLimit,
        'used_time': usedTime,
        'amount': amount,
        'percent': percent,
        'minimum_purchase_amount': minimumPurchaseAmount,
        'days': days,
        'status': status,
        'description': description,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  factory CouponData.fromJson(String data) {
    return CouponData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PreferredPackModel] to a JSON string.
  String toJson() => json.encode(toMap());

  /// Empty user which represents an unauthenticated user.
  static const CouponData empty = CouponData(id: 0);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == CouponData.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != CouponData.empty;

  @override
  List<Object?> get props => [];
}
