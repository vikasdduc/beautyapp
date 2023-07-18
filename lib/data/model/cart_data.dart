import 'dart:convert';

import 'package:equatable/equatable.dart';

class CartData extends Equatable {
  final num? couponId;
  final num? userId;
  final String? bookingDateTime;
  final String? status;
  final String? paymentGateway;
  final num? originalAmount;
  final num? discount;
  final num? couponDiscount;
  final num? discountPercent;
  final String? taxName;
  final num? taxPercent;
  final num? extraFees;
  final num? distanceFee;
  final int? amountToPay;
  final num? mincheck;
  final String? paymentStatus;
  final String? source;
  final String? additionalNotes;
  final bool isWalletUsed;
  final num walletBalance;

  const CartData({
    this.couponId,
    this.userId,
    this.bookingDateTime,
    this.status,
    this.paymentGateway,
    this.originalAmount,
    this.discount,
    this.couponDiscount,
    this.discountPercent,
    this.taxName,
    this.taxPercent,
    this.extraFees,
    this.distanceFee,
    this.amountToPay,
    this.mincheck,
    this.paymentStatus,
    this.source,
    this.additionalNotes,
    this.isWalletUsed = true,
    this.walletBalance = 0.0,
  });

  factory CartData.fromMap(Map<String, dynamic> data) => CartData(
        couponId: data['coupon_id'] as num?,
        userId: data['user_id'] as num?,
        bookingDateTime: data['booking_date_time'] as String?,
        status: data['status'] as String?,
        paymentGateway: data['payment_gateway'] as String?,
        originalAmount: data['original_amount'] as num?,
        discount: data['discount'] as num?,
        couponDiscount: data['coupon_discount'] as num?,
        discountPercent: data['discount_percent'] as num?,
        taxName: data['tax_name'] as String?,
        taxPercent: data['tax_percent'] as num?,
        extraFees: data['extra_fees'] as num?,
        distanceFee: data['distance_fee'] as num?,
        amountToPay: data['amount_to_pay'] as int?,
        mincheck: data['mincheck'] as num?,
        paymentStatus: data['payment_status'] as String?,
        source: data['source'] as String?,
        additionalNotes: data['additional_notes'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'coupon_id': couponId,
        'user_id': userId,
        'booking_date_time': bookingDateTime,
        'status': status,
        'payment_gateway': paymentGateway,
        'original_amount': originalAmount,
        'discount': discount,
        'coupon_discount': couponDiscount,
        'discount_percent': discountPercent,
        'tax_name': taxName,
        'tax_percent': taxPercent,
        'extra_fees': extraFees,
        'distance_fee': distanceFee,
        'amount_to_pay': amountToPay,
        'mincheck': mincheck,
        'payment_status': paymentStatus,
        'source': source,
        'additional_notes': additionalNotes,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CartData].
  factory CartData.fromJson(String data) {
    return CartData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CartData] to a JSON string.
  String toJson() => json.encode(toMap());

  CartData copyWith({
    num? couponId,
    num? userId,
    String? bookingDateTime,
    String? status,
    String? paymentGateway,
    num? originalAmount,
    num? discount,
    num? couponDiscount,
    num? discountPercent,
    String? taxName,
    num? taxPercent,
    num? extraFees,
    num? distanceFee,
    int? amountToPay,
    num? mincheck,
    String? paymentStatus,
    String? source,
    String? additionalNotes,
    bool couponCheck = false,
    bool? isWalletUsed,
    num? walletBalance,
  }) {
    return CartData(
      couponId: couponCheck ? couponId : this.couponId,
      userId: userId ?? this.userId,
      bookingDateTime: bookingDateTime ?? this.bookingDateTime,
      status: status ?? this.status,
      paymentGateway: paymentGateway ?? this.paymentGateway,
      originalAmount: originalAmount ?? this.originalAmount,
      discount: discount ?? this.discount,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      discountPercent: discountPercent ?? this.discountPercent,
      taxName: taxName ?? this.taxName,
      taxPercent: taxPercent ?? this.taxPercent,
      extraFees: extraFees ?? this.extraFees,
      distanceFee: distanceFee ?? this.distanceFee,
      amountToPay: amountToPay ?? this.amountToPay,
      mincheck: mincheck ?? this.mincheck,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      source: source ?? this.source,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      isWalletUsed: isWalletUsed ?? this.isWalletUsed,
      walletBalance: walletBalance ?? this.walletBalance,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      couponId,
      userId,
      bookingDateTime,
      status,
      paymentGateway,
      originalAmount,
      discount,
      couponDiscount,
      discountPercent,
      taxName,
      taxPercent,
      extraFees,
      distanceFee,
      amountToPay,
      mincheck,
      paymentStatus,
      source,
      additionalNotes,
      walletBalance,
      isWalletUsed
    ];
  }
}
