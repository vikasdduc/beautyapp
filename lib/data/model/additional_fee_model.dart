import 'dart:convert';

/// status : "success"
/// message : "Data Found"
/// extraFees : [{"id":1,"name":"Safety & Hygiene Fee","amount":49,"status":"active","created_at":"2020-11-16 00:55:00","updated_at":"2021-12-14 10:09:16"}]
/// tax : [{"id":1,"tax_name":"GST","percent":18,"status":"deactive","created_at":"2020-08-22 00:37:07","updated_at":"2020-12-15 04:10:36"}]
/// mincheck : [{"id":1,"amount":"599"}]
/// distancefees : []

AdditionalFeeModel additionalFeeModelFromJson(String str) =>
    AdditionalFeeModel.fromJson(json.decode(str));
String additionalFeeModelToJson(AdditionalFeeModel data) =>
    json.encode(data.toJson());

class AdditionalFeeModel {
  AdditionalFeeModel({
    this.status,
    this.message,
    this.extraFees,
    this.tax,
    this.mincheck,
    this.distancefees,
  });

  AdditionalFeeModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['extraFees'] != null) {
      extraFees = [];
      json['extraFees'].forEach((v) {
        extraFees?.add(ExtraFees.fromJson(v));
      });
    }
    if (json['tax'] != null) {
      tax = [];
      json['tax'].forEach((v) {
        tax?.add(Tax.fromJson(v));
      });
    }
    if (json['mincheck'] != null) {
      mincheck = [];
      json['mincheck'].forEach((v) {
        mincheck?.add(Mincheck.fromJson(v));
      });
    }
    if (json['distancefees'] != null) {
      distancefees = [];
      json['distancefees'].forEach((v) {
        distancefees?.add(v);
      });
    }
  }
  String? status;
  String? message;
  List<ExtraFees>? extraFees;
  List<Tax>? tax;
  List<Mincheck>? mincheck;
  List<dynamic>? distancefees;
  AdditionalFeeModel copyWith({
    String? status,
    String? message,
    List<ExtraFees>? extraFees,
    List<Tax>? tax,
    List<Mincheck>? mincheck,
    List<String>? distancefees,
  }) =>
      AdditionalFeeModel(
        status: status ?? this.status,
        message: message ?? this.message,
        extraFees: extraFees ?? this.extraFees,
        tax: tax ?? this.tax,
        mincheck: mincheck ?? this.mincheck,
        distancefees: distancefees ?? this.distancefees,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (extraFees != null) {
      map['extraFees'] = extraFees?.map((v) => v.toJson()).toList();
    }
    if (tax != null) {
      map['tax'] = tax?.map((v) => v.toJson()).toList();
    }
    if (mincheck != null) {
      map['mincheck'] = mincheck?.map((v) => v.toJson()).toList();
    }
    if (distancefees != null) {
      map['distancefees'] = distancefees?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// amount : "599"

Mincheck mincheckFromJson(String str) => Mincheck.fromJson(json.decode(str));
String mincheckToJson(Mincheck data) => json.encode(data.toJson());

class Mincheck {
  Mincheck({
    this.id,
    this.amount,
  });

  Mincheck.fromJson(dynamic json) {
    id = json['id'];
    amount = json['amount'];
  }
  num? id;
  String? amount;
  Mincheck copyWith({
    num? id,
    String? amount,
  }) =>
      Mincheck(
        id: id ?? this.id,
        amount: amount ?? this.amount,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['amount'] = amount;
    return map;
  }
}

/// id : 1
/// tax_name : "GST"
/// percent : 18
/// status : "deactive"
/// created_at : "2020-08-22 00:37:07"
/// updated_at : "2020-12-15 04:10:36"

Tax taxFromJson(String str) => Tax.fromJson(json.decode(str));
String taxToJson(Tax data) => json.encode(data.toJson());

class Tax {
  Tax({
    this.id,
    this.taxName,
    this.percent,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Tax.fromJson(dynamic json) {
    id = json['id'];
    taxName = json['tax_name'];
    percent = json['percent'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? taxName;
  num? percent;
  String? status;
  String? createdAt;
  String? updatedAt;
  Tax copyWith({
    num? id,
    String? taxName,
    num? percent,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Tax(
        id: id ?? this.id,
        taxName: taxName ?? this.taxName,
        percent: percent ?? this.percent,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['tax_name'] = taxName;
    map['percent'] = percent;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

/// id : 1
/// name : "Safety & Hygiene Fee"
/// amount : 49
/// status : "active"
/// created_at : "2020-11-16 00:55:00"
/// updated_at : "2021-12-14 10:09:16"

ExtraFees extraFeesFromJson(String str) => ExtraFees.fromJson(json.decode(str));
String extraFeesToJson(ExtraFees data) => json.encode(data.toJson());

class ExtraFees {
  ExtraFees({
    this.id,
    this.name,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  ExtraFees.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  num? amount;
  String? status;
  String? createdAt;
  String? updatedAt;
  ExtraFees copyWith({
    num? id,
    String? name,
    num? amount,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      ExtraFees(
        id: id ?? this.id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['amount'] = amount;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
