class UserAddressModels {
  String? status;
  String? address;
  String? latitudeLongitude;

  UserAddressModels({this.status, this.address, this.latitudeLongitude});

  UserAddressModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    address = json['address'];
    latitudeLongitude = json['latitude.longitude'];
  }

  Map<String, dynamic> toJson(jsonDecode) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['address'] = address;
    data['latitude.longitude'] = latitudeLongitude;
    return data;
  }
}
