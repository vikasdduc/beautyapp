import 'dart:core';

import 'package:equatable/equatable.dart';

class WalletData extends Equatable {
  final String? status;
  final List<int>? wallet;
  final List<Usage>? usage;

  const WalletData(
      {required this.status, required this.wallet, required this.usage});

  factory WalletData.fromJson(Map<String, dynamic> json) {
    return WalletData(
        status: json['status'],
        wallet: json['wallet'].cast<int>(),
        usage: json['usage'] != null
            ? (json['usage'] as List).map((e) => Usage.fromJson(e)).toList()
            : []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['wallet'] = wallet;
    data['usage'] = usage?.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props => [status, wallet, usage];
}

class Usage extends Equatable {
  final int id;
  final int price;
  final int max;
  final int min;
  final String createdAt;
  final String updatedAt;

  const Usage(
      this.id,
      this.price,
      this.max,
      this.min,
      this.createdAt,
      this.updatedAt);

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
        json['id'] as int,
        int.parse(json['price']),
        int.parse(json['max']),
        int.parse(json['min']),
        json['created_at'],
        json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['max'] = max;
    data['min'] = min;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  List<Object?> get props => [id, price, max, min, createdAt, updatedAt];
}
