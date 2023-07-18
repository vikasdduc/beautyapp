/// status : "success"
/// message : "Loction Details"
/// loction : [{"id":2,"name":"3/34, Ground Floor, Vineet Khand, Gomti Nagar, Lucknow","latitude":26.849656599999999428973751491867005825042724609375,"longitude":81.013612999999992325683706440031528472900390625,"state":"Uttar Pradesh","city":"Lucknow","zip":"226010","image":"0adaf2d5fb72a739bc6368b54c074586.png.webp","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2020-08-22 01:38:24","updated_at":"2022-12-11 07:29:35","image_base_url":"https://www.glamcode.in/public/user-uploads/locations/0adaf2d5fb72a739bc6368b54c074586.png.webp"},{"id":6,"name":"Amrapali Zodiac, Sector 120, Noida, Uttar Pradesh, India","latitude":28.584116800000000324644133797846734523773193359375,"longitude":77.3973941999999937024767859838902950286865234375,"state":"Uttar Pradesh","city":"Noida","zip":"203202","image":"4538886349b8773c157e3472ae3fccdc.png.webp","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-11-15 00:11:33","updated_at":"2022-12-11 07:29:50","image_base_url":"https://www.glamcode.in/public/user-uploads/locations/4538886349b8773c157e3472ae3fccdc.png.webp"},{"id":12,"name":"Delhi, India","latitude":28.686273799999998601606421289034187793731689453125,"longitude":77.2217830999999961250068736262619495391845703125,"state":"Delhi","city":"Delhi","zip":"110001","image":"136cef10bac741d3484a139a5047747c.png.webp","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-13 01:06:43","updated_at":"2022-12-11 07:30:05","image_base_url":"https://www.glamcode.in/public/user-uploads/locations/136cef10bac741d3484a139a5047747c.png.webp"},{"id":13,"name":"Gurgaon, Haryana, India","latitude":28.4594965000000001964508555829524993896484375,"longitude":77.02663830000000189102138392627239227294921875,"state":"Haryana","city":"Gurugram","zip":"122004","image":"289150da28cdd707146979aa18ef6eb4.png.webp","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-13 01:10:00","updated_at":"2022-12-11 07:58:59","image_base_url":"https://www.glamcode.in/public/user-uploads/locations/289150da28cdd707146979aa18ef6eb4.png.webp"},{"id":14,"name":"Ghaziabad, Uttar Pradesh, India","latitude":28.6691564999999997098711901344358921051025390625,"longitude":77.4537577999999911071427050046622753143310546875,"state":"Uttar Pradesh","city":"Ghaziabad","zip":"2201001","image":"afe8e8ded33f779d12e3f7147c22e9b0.png.webp","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-13 01:13:37","updated_at":"2022-12-11 07:59:13","image_base_url":"https://www.glamcode.in/public/user-uploads/locations/afe8e8ded33f779d12e3f7147c22e9b0.png.webp"},{"id":15,"name":"Greater Noida, Uttar Pradesh, India","latitude":28.474387899999999973488229443319141864776611328125,"longitude":77.503990399999992177981766872107982635498046875,"state":"Uttar Pradesh","city":"G.Noida","zip":"201310","image":"23256aea2c436478b22f2120c7f6d96b.png.webp","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-13 01:19:01","updated_at":"2022-12-11 07:59:31","image_base_url":"https://www.glamcode.in/public/user-uploads/locations/23256aea2c436478b22f2120c7f6d96b.png.webp"}]

class LocationModel {
  LocationModel({
    String? status,
    String? message,
    List<Loction>? loction,
  }) {
    _status = status;
    _message = message;
    _loction = loction;
  }

  LocationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['loction'] != null) {
      _loction = [];
      json['loction'].forEach((v) {
        _loction?.add(Loction.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
 static List<Loction>? _loction;
  LocationModel copyWith({
    String? status,
    String? message,
    List<Loction>? loction,
  }) =>
      LocationModel(
        status: status ?? _status,
        message: message ?? _message,
        loction: loction ?? _loction,
      );
  String? get status => _status;
  String? get message => _message;
  List<Loction>? get loction => _loction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_loction != null) {
      map['loction'] = _loction?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 2
/// name : "3/34, Ground Floor, Vineet Khand, Gomti Nagar, Lucknow"
/// latitude : 26.849656599999999428973751491867005825042724609375
/// longitude : 81.013612999999992325683706440031528472900390625
/// state : "Uttar Pradesh"
/// city : "Lucknow"
/// zip : "226010"
/// image : "0adaf2d5fb72a739bc6368b54c074586.png.webp"
/// seo_title : null
/// seo_desc : null
/// seo_key : null
/// created_at : "2020-08-22 01:38:24"
/// updated_at : "2022-12-11 07:29:35"
/// image_base_url : "https://www.glamcode.in/public/user-uploads/locations/0adaf2d5fb72a739bc6368b54c074586.png.webp"

class Loction {
  Loction({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    String? state,
    String? city,
    String? zip,
    String? image,
    dynamic seoTitle,
    dynamic seoDesc,
    dynamic seoKey,
    String? createdAt,
    String? updatedAt,
    String? imageBaseUrl,
  }) {
    _id = id;
    _name = name;
    _latitude = latitude;
    _longitude = longitude;
    _state = state;
    _city = city;
    _zip = zip;
    _image = image;
    _seoTitle = seoTitle;
    _seoDesc = seoDesc;
    _seoKey = seoKey;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imageBaseUrl = imageBaseUrl;
  }

  Loction.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _state = json['state'];
    _city = json['city'];
    _zip = json['zip'];
    _image = json['image'];
    _seoTitle = json['seo_title'];
    _seoDesc = json['seo_desc'];
    _seoKey = json['seo_key'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imageBaseUrl = json['image_base_url'];
  }
  int? _id;
  String? _name;
  double? _latitude;
  double? _longitude;
  String? _state;
  String? _city;
  String? _zip;
  String? _image;
  dynamic _seoTitle;
  dynamic _seoDesc;
  dynamic _seoKey;
  String? _createdAt;
  String? _updatedAt;
  String? _imageBaseUrl;
  Loction copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    String? state,
    String? city,
    String? zip,
    String? image,
    dynamic seoTitle,
    dynamic seoDesc,
    dynamic seoKey,
    String? createdAt,
    String? updatedAt,
    String? imageBaseUrl,
  }) =>
      Loction(
        id: id ?? _id,
        name: name ?? _name,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        state: state ?? _state,
        city: city ?? _city,
        zip: zip ?? _zip,
        image: image ?? _image,
        seoTitle: seoTitle ?? _seoTitle,
        seoDesc: seoDesc ?? _seoDesc,
        seoKey: seoKey ?? _seoKey,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        imageBaseUrl: imageBaseUrl ?? _imageBaseUrl,
      );
  int? get id => _id;
  String? get name => _name;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get state => _state;
  String? get city => _city;
  String? get zip => _zip;
  String? get image => _image;
  dynamic get seoTitle => _seoTitle;
  dynamic get seoDesc => _seoDesc;
  dynamic get seoKey => _seoKey;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imageBaseUrl => _imageBaseUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['state'] = _state;
    map['city'] = _city;
    map['zip'] = _zip;
    map['image'] = _image;
    map['seo_title'] = _seoTitle;
    map['seo_desc'] = _seoDesc;
    map['seo_key'] = _seoKey;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['image_base_url'] = _imageBaseUrl;
    return map;
  }
}
