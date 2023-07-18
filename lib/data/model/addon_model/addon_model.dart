import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'addon_datum.dart';

class AddonModel extends Equatable {
  final String? status;
  final String? message;
  final List<AddonDatum>? addonData;

  const AddonModel({this.status, this.message, this.addonData});

  factory AddonModel.fromMap(Map<String, dynamic> data) => AddonModel(
        status: data['status'] as String?,
        message: data['message'] as String?,
        addonData: (data['addonData'] as List<dynamic>?)
            ?.map((e) => AddonDatum.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'addonData': addonData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddonModel].
  factory AddonModel.fromJson(String data) {
    return AddonModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddonModel] to a JSON string.
  String toJson() => json.encode(toMap());

  AddonModel copyWith({
    String? status,
    String? message,
    List<AddonDatum>? addonData,
  }) {
    return AddonModel(
      status: status ?? this.status,
      message: message ?? this.message,
      addonData: addonData ?? this.addonData,
    );
  }

  @override
  List<Object?> get props => [status, message, addonData];
}
