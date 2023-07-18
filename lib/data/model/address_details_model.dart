import 'dart:convert';

/// status : "success"
/// message : "Data Found"
/// addressDetails : [{"address_id":2102,"address_heading":"Home","user_id":3965,"address":"Vineet Khand","street":"3/27, 3/27, Jaipuria Rd, Vineet Khand, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India","pincode":null,"lattitude":26.846693699999999438432496390305459499359130859375,"longitude":80.9461659999999909587131696753203868865966796875,"mobile_number":"6309672824","calling_code":"+91","is_primary":false,"created_at":"2022-12-22T10:34:05.000000Z","updated_at":"2022-12-22T10:34:05.000000Z"}]

AddressDetailsModel addressDetailsModelFromJson(String str) =>
    AddressDetailsModel.fromJson(json.decode(str));
String addressDetailsModelToJson(AddressDetailsModel data) =>
    json.encode(data.toJson());

class AddressDetailsModel {
  AddressDetailsModel({
    this.status,
    this.message,
    this.addressDetails,
  });

  AddressDetailsModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['addressDetails'] != null) {
      addressDetails = [];
      json['addressDetails'].forEach((v) {
        addressDetails?.add(AddressDetails.fromJson(v));
      });
    }
  }
  String? status;
  String? message;
  List<AddressDetails>? addressDetails;
  AddressDetailsModel copyWith({
    String? status,
    String? message,
    List<AddressDetails>? addressDetails,
  }) =>
      AddressDetailsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        addressDetails: addressDetails ?? this.addressDetails,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (addressDetails != null) {
      map['addressDetails'] = addressDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// address_id : 2102
/// address_heading : "Home"
/// user_id : 3965
/// address : "Vineet Khand"
/// street : "3/27, 3/27, Jaipuria Rd, Vineet Khand, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India"
/// pincode : null
/// lattitude : 26.846693699999999438432496390305459499359130859375
/// longitude : 80.9461659999999909587131696753203868865966796875
/// mobile_number : "6309672824"
/// calling_code : "+91"
/// is_primary : false
/// created_at : "2022-12-22T10:34:05.000000Z"
/// updated_at : "2022-12-22T10:34:05.000000Z"

AddressDetails addressDetailsFromJson(String str) =>
    AddressDetails.fromJson(json.decode(str));
String addressDetailsToJson(AddressDetails data) => json.encode(data.toJson());

class AddressDetails {
  AddressDetails({
    this.addressId,
    this.addressHeading,
    this.userId,
    this.address,
    this.street,
    this.pincode,
    this.lattitude,
    this.longitude,
    this.mobileNumber,
    this.callingCode,
    this.isPrimary,
    this.createdAt,
    this.updatedAt,
  });

  AddressDetails.fromJson(dynamic json) {
    addressId = json['address_id'];
    addressHeading = json['address_heading'];
    userId = json['user_id'];
    address = json['address'];
    street = json['street'];
    pincode = json['pincode'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    mobileNumber = json['mobile_number'];
    callingCode = json['calling_code'];
    isPrimary = json['is_primary'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? addressId;
  String? addressHeading;
  num? userId;
  String? address;
  String? street;
  dynamic pincode;
  num? lattitude;
  num? longitude;
  String? mobileNumber;
  String? callingCode;
  bool? isPrimary;
  String? createdAt;
  String? updatedAt;
  AddressDetails copyWith({
    num? addressId,
    String? addressHeading,
    num? userId,
    String? address,
    String? street,
    dynamic pincode,
    num? lattitude,
    num? longitude,
    String? mobileNumber,
    String? callingCode,
    bool? isPrimary,
    String? createdAt,
    String? updatedAt,
  }) =>
      AddressDetails(
        addressId: addressId ?? this.addressId,
        addressHeading: addressHeading ?? this.addressHeading,
        userId: userId ?? this.userId,
        address: address ?? this.address,
        street: street ?? this.street,
        pincode: pincode ?? this.pincode,
        lattitude: lattitude ?? this.lattitude,
        longitude: longitude ?? this.longitude,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        callingCode: callingCode ?? this.callingCode,
        isPrimary: isPrimary ?? this.isPrimary,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = addressId;
    map['address_heading'] = addressHeading;
    map['user_id'] = userId;
    map['address'] = address;
    map['street'] = street;
    map['pincode'] = pincode;
    map['lattitude'] = lattitude;
    map['longitude'] = longitude;
    map['mobile_number'] = mobileNumber;
    map['calling_code'] = callingCode;
    map['is_primary'] = isPrimary;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
