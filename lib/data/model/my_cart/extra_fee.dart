import 'dart:convert';

import 'package:equatable/equatable.dart';

class ExtraFee extends Equatable {
  final int? id;
  final String? name;
  final int? amount;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  const ExtraFee({
    this.id,
    this.name,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ExtraFee.fromMap(Map<String, dynamic> data) => ExtraFee(
        id: data['id'] as int?,
        name: data['name'] as String?,
        amount: data['amount'] as int?,
        status: data['status'] as String?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'amount': amount,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ExtraFee].
  factory ExtraFee.fromJson(String data) {
    return ExtraFee.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ExtraFee] to a JSON string.
  String toJson() => json.encode(toMap());

  ExtraFee copyWith({
    int? id,
    String? name,
    int? amount,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return ExtraFee(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      amount,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
