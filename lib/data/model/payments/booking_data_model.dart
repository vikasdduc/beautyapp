import 'dart:convert';

/// coupon_id : 1234
/// user_id : 1234
/// booking_date_time : "7676"
/// status : "pending"
/// payment_gateway : "cash"
/// original_amount : 1234.0
/// discount : 1234.0
/// coupon_discount : 1234.0
/// discount_percent : 12.3
/// tax_name : "12.3"
/// tax_percent : 12.3
/// extra_fees : 123.4
/// distance_fee : 123.0
/// amount_to_pay : 123.0
/// payment_status : "cash"
/// source : "online"
/// additional_notes : ""

BookingDataModel bookingDataModelFromJson(String str) =>
    BookingDataModel.fromJson(json.decode(str));
String bookingDataModelToJson(BookingDataModel data) =>
    json.encode(data.toJson());

class BookingDataModel {
  BookingDataModel({
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
    this.paymentStatus,
    this.source,
    this.additionalNotes,
  });

  BookingDataModel.fromJson(dynamic json) {
    
    couponId = json['coupon_id'];
    userId = json['user_id'];
    bookingDateTime = json['booking_date_time'];
    status = json['status'];
    paymentGateway = json['payment_gateway'];
    originalAmount = json['original_amount'];
    discount = json['discount'];
    couponDiscount = json['coupon_discount'];
    discountPercent = json['discount_percent'];
    taxName = json['tax_name'];
    taxPercent = json['tax_percent'];
    extraFees = json['extra_fees'];
    distanceFee = json['distance_fee'];
    amountToPay = json['amount_to_pay'];
    paymentStatus = json['payment_status'];
    source = json['source'];
    additionalNotes = json['additional_notes'];
  }
  String? couponId;
  num? userId;
  String? bookingDateTime;
  String? status;
  String? paymentGateway;
  num? originalAmount;
  num? discount;
  num? couponDiscount;
  num? discountPercent;
  String? taxName;
  num? taxPercent;
  num? extraFees;
  num? distanceFee;
  num? amountToPay;
  String? paymentStatus;
  String? source;
  String? additionalNotes;
  BookingDataModel copyWith({
    String? couponId,
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
    num? amountToPay,
    String? paymentStatus,
    String? source,
    String? additionalNotes,
  }) =>
      BookingDataModel(
        couponId: couponId ?? this.couponId,
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
        paymentStatus: paymentStatus ?? this.paymentStatus,
        source: source ?? this.source,
        additionalNotes: additionalNotes ?? this.additionalNotes,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // if(couponId != "" && couponId != null) {
    //   map['coupon_id'] = couponId;
    // }
    map['coupon_id'] = couponId;
    map['user_id'] = userId;
    map['booking_date_time'] = bookingDateTime;
    map['status'] = status;
    map['payment_gateway'] = paymentGateway;
    map['original_amount'] = originalAmount;
    map['discount'] = discount;
    map['coupon_discount'] = couponDiscount;
    map['discount_percent'] = discountPercent;
    map['tax_name'] = taxName;
    map['tax_percent'] = taxPercent;
    map['extra_fees'] = extraFees;
    map['distance_fee'] = distanceFee;
    map['amount_to_pay'] = amountToPay;
    map['payment_status'] = paymentStatus;
    map['source'] = source;
    map['additional_notes'] = additionalNotes;
    return map;
  }
}
