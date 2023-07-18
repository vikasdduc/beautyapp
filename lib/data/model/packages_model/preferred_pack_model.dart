import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:glamcode/data/model/packages_model/service.dart';

class PreferredPackModel extends Equatable {
  final String? status;
  final String? message;
  final List<ServicePackage>? preferredPack;

  const PreferredPackModel({this.status, this.message, this.preferredPack});

  factory PreferredPackModel.fromMap(Map<String, dynamic> data) {
    return PreferredPackModel(
      status: data['status'] as String?,
      message: data['message'] as String?,
      preferredPack: (data['preferredPack'] as List<dynamic>?)
          ?.map((e) => ServicePackage.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'preferredPack': preferredPack?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PreferredPackModel].
  factory PreferredPackModel.fromJson(String data) {
    return PreferredPackModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PreferredPackModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PreferredPackModel copyWith({
    String? status,
    String? message,
    List<ServicePackage>? preferredPack,
  }) {
    return PreferredPackModel(
      status: status ?? this.status,
      message: message ?? this.message,
      preferredPack: preferredPack ?? this.preferredPack,
    );
  }

  @override
  List<Object?> get props => [status, message, preferredPack];
}
