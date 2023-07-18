import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddonDatum extends Equatable {
  final String? name;
  final String? price;

  const AddonDatum({this.name, this.price});

  factory AddonDatum.fromMap(Map<String, dynamic> data) => AddonDatum(
        name: data['name'] as String?,
        price: data['price'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'price': price,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddonDatum].
  factory AddonDatum.fromJson(String data) {
    return AddonDatum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddonDatum] to a JSON string.
  String toJson() => json.encode(toMap());

  AddonDatum copyWith({
    String? name,
    String? price,
  }) {
    return AddonDatum(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [name, price];
}
