import 'dart:convert';

/// currency_id : "2"
/// booking_id : "0"
/// amount : 1234.0
/// gateway : "cash"
/// transaction_id : "cash"
/// status : "cash"
/// paid_on : "sadsd"

PaymentsDataModel paymentsDataModelFromJson(String str) =>
    PaymentsDataModel.fromJson(json.decode(str));
String paymentsDataModelToJson(PaymentsDataModel data) =>
    json.encode(data.toJson());

class PaymentsDataModel {
  PaymentsDataModel({
    this.currencyId,
    this.bookingId,
    this.amount,
    this.gateway,
    this.transactionId,
    this.status,
    this.paidOn,
  });

  PaymentsDataModel.fromJson(dynamic json) {
    currencyId = json['currency_id'];
    bookingId = json['booking_id'];
    amount = json['amount'];
    gateway = json['gateway'];
    transactionId = json['transaction_id'];
    status = json['status'];
    paidOn = json['paid_on'];
  }

  String? currencyId;
  String? bookingId;
  num? amount;
  String? gateway;
  String? transactionId;
  String? status;
  String? paidOn;

  PaymentsDataModel copyWith({
    String? currencyId,
    String? bookingId,
    num? amount,
    String? gateway,
    String? transactionId,
    String? status,
    String? paidOn,
  }) =>
      PaymentsDataModel(
        currencyId: currencyId ?? this.currencyId,
        bookingId: bookingId ?? this.bookingId,
        amount: amount ?? this.amount,
        gateway: gateway ?? this.gateway,
        transactionId: transactionId ?? this.transactionId,
        status: status ?? this.status,
        paidOn: paidOn ?? this.paidOn,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency_id'] = currencyId;
    map['booking_id'] = bookingId;
    map['amount'] = amount;
    map['gateway'] = gateway;
    map['transaction_id'] = transactionId;
    map['status'] = status;
    map['paid_on'] = paidOn;
    return map;
  }
}
