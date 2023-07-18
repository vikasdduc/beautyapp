import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final dynamic groupId;
  final dynamic refcode;
  final dynamic wallet;
  final dynamic parentId;
  final String? name;
  final String? email;
  final String? address;
  final String? detailedAddress;
  final double? latitude;
  final double? longitude;
  final String? mobile;
  final dynamic venderLoctionId;
  final String? callingCode;
  final int? mobileVerified;
  final dynamic image;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final String? userImageUrl;
  final String? mobileWithCode;
  final String? formattedMobile;

  const User({
    this.id,
    this.groupId,
    this.refcode,
    this.wallet,
    this.parentId,
    this.name,
    this.email,
    this.address,
    this.detailedAddress,
    this.latitude,
    this.longitude,
    this.mobile,
    this.venderLoctionId,
    this.callingCode,
    this.mobileVerified,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userImageUrl,
    this.mobileWithCode,
    this.formattedMobile,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as int?,
        groupId: data['group_id'] as dynamic,
        refcode: data['refcode'] as dynamic,
        wallet: data['wallet'] as dynamic,
        parentId: data['parent_id'] as dynamic,
        name: data['name'] as String?,
        email: data['email'] as String?,
        address: data['address'] as String?,
        detailedAddress: data['detailed_address'] as String?,
        latitude: (data['latitude'] as num?)?.toDouble(),
        longitude: (data['longitude'] as num?)?.toDouble(),
        mobile: data['mobile'] as String?,
        venderLoctionId: data['vender_loction_id'] as dynamic,
        callingCode: data['calling_code'] as String?,
        mobileVerified: data['mobile_verified'] as int?,
        image: data['image'] as dynamic,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        deletedAt: data['deleted_at'] as dynamic,
        userImageUrl: data['user_image_url'] as String?,
        mobileWithCode: data['mobile_with_code'] as String?,
        formattedMobile: data['formatted_mobile'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'group_id': groupId,
        'refcode': refcode,
        'wallet': wallet,
        'parent_id': parentId,
        'name': name,
        'email': email,
        'address': address,
        'detailed_address': detailedAddress,
        'latitude': latitude,
        'longitude': longitude,
        'mobile': mobile,
        'vender_loction_id': venderLoctionId,
        'calling_code': callingCode,
        'mobile_verified': mobileVerified,
        'image': image,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
        'user_image_url': userImageUrl,
        'mobile_with_code': mobileWithCode,
        'formatted_mobile': formattedMobile,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

  User copyWith({
    int? id,
    dynamic groupId,
    dynamic refcode,
    dynamic wallet,
    dynamic parentId,
    String? name,
    String? email,
    String? address,
    String? detailedAddress,
    double? latitude,
    double? longitude,
    String? mobile,
    dynamic venderLoctionId,
    String? callingCode,
    int? mobileVerified,
    dynamic image,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    String? userImageUrl,
    String? mobileWithCode,
    String? formattedMobile,
  }) {
    return User(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      refcode: refcode ?? this.refcode,
      wallet: wallet ?? this.wallet,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      detailedAddress: detailedAddress ?? this.detailedAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      mobile: mobile ?? this.mobile,
      venderLoctionId: venderLoctionId ?? this.venderLoctionId,
      callingCode: callingCode ?? this.callingCode,
      mobileVerified: mobileVerified ?? this.mobileVerified,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      userImageUrl: userImageUrl ?? this.userImageUrl,
      mobileWithCode: mobileWithCode ?? this.mobileWithCode,
      formattedMobile: formattedMobile ?? this.formattedMobile,
    );
  }

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: 0);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props {
    return [
      id,
      groupId,
      refcode,
      wallet,
      parentId,
      name,
      email,
      address,
      detailedAddress,
      latitude,
      longitude,
      mobile,
      venderLoctionId,
      callingCode,
      mobileVerified,
      image,
      createdAt,
      updatedAt,
      deletedAt,
      userImageUrl,
      mobileWithCode,
      formattedMobile,
    ];
  }
}
