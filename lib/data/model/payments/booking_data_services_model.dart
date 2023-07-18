import 'dart:convert';

/// service_data : [{"booking_id":"0","business_service_id":1234.0,"quantity":2,"unit_price":1234.0,"amount":1234.0},{"booking_id":"0","business_service_id":1234.0,"quantity":2,"unit_price":1234.0,"amount":1234.0}]
/// add_on : [{"booking_id":"0","add_name":"sdf","quantity":1,"amount":1234.0}]

BookingDataServicesModel bookingDataServicesFromJson(String str) =>
    BookingDataServicesModel.fromJson(json.decode(str));
String bookingDataServicesToJson(BookingDataServicesModel data) =>
    json.encode(data.toJson());

class BookingDataServicesModel {
  BookingDataServicesModel({
    this.serviceData,
    this.addOn,
  });

  BookingDataServicesModel.fromJson(dynamic json) {
    if (json['service_data'] != null) {
      serviceData = [];
      json['service_data'].forEach((v) {
        serviceData?.add(ServiceData.fromJson(v));
      });
    }
    if (json['add_on'] != null) {
      addOn = [];
      json['add_on'].forEach((v) {
        addOn?.add(AddOn.fromJson(v));
      });
    }
  }
  List<ServiceData>? serviceData;
  List<AddOn>? addOn;
  BookingDataServicesModel copyWith({
    List<ServiceData>? serviceData,
    List<AddOn>? addOn,
  }) =>
      BookingDataServicesModel(
        serviceData: serviceData ?? this.serviceData,
        addOn: addOn ?? this.addOn,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (serviceData != null) {
      map['service_data'] = serviceData?.map((v) => v.toJson()).toList();
    }
    if (addOn != null) {
      map['add_on'] = addOn?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// booking_id : "0"
/// add_name : "sdf"
/// quantity : 1
/// amount : 1234.0

AddOn addOnFromJson(String str) => AddOn.fromJson(json.decode(str));
String addOnToJson(AddOn data) => json.encode(data.toJson());

class AddOn {
  AddOn({
    this.bookingId,
    this.addName,
    this.quantity,
    this.amount,
  });

  AddOn.fromJson(dynamic json) {
    bookingId = json['booking_id'];
    addName = json['add_name'];
    quantity = json['quantity'];
    amount = json['amount'];
  }
  String? bookingId;
  String? addName;
  num? quantity;
  num? amount;
  AddOn copyWith({
    String? bookingId,
    String? addName,
    num? quantity,
    num? amount,
  }) =>
      AddOn(
        bookingId: bookingId ?? this.bookingId,
        addName: addName ?? this.addName,
        quantity: quantity ?? this.quantity,
        amount: amount ?? this.amount,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['booking_id'] = bookingId;
    map['add_name'] = addName;
    map['quantity'] = quantity;
    map['amount'] = amount;
    return map;
  }
}

/// booking_id : "0"
/// business_service_id : 1234.0
/// quantity : 2
/// unit_price : 1234.0
/// amount : 1234.0

ServiceData serviceDataFromJson(String str) =>
    ServiceData.fromJson(json.decode(str));
String serviceDataToJson(ServiceData data) => json.encode(data.toJson());

class ServiceData {
  ServiceData({
    this.bookingId,
    this.businessServiceId,
    this.quantity,
    this.unitPrice,
    this.amount,
  });

  ServiceData.fromJson(dynamic json) {
    bookingId = json['booking_id'];
    businessServiceId = json['business_service_id'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    amount = json['amount'];
  }
  String? bookingId;
  num? businessServiceId;
  num? quantity;
  num? unitPrice;
  num? amount;
  ServiceData copyWith({
    String? bookingId,
    num? businessServiceId,
    num? quantity,
    num? unitPrice,
    num? amount,
  }) =>
      ServiceData(
        bookingId: bookingId ?? this.bookingId,
        businessServiceId: businessServiceId ?? this.businessServiceId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        amount: amount ?? this.amount,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['booking_id'] = bookingId;
    map['business_service_id'] = businessServiceId;
    map['quantity'] = quantity;
    map['unit_price'] = unitPrice;
    map['amount'] = amount;
    return map;
  }
}
