/// status : "success"
/// message : "Home Page Records"
/// slider_images : [{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/cf4b29ed9d8bcdafe479091ae63483b7.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/b1bfb827946e3b597dd38c8e72649ace.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/112e1c7f4bd55bf8186867c05911e9c9.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/31d5459ac6daafb674e0e6814508c1a1.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/0da44ff776e092e673cecaf6eef2b18a.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/4b29523066199b1b6f4462599e155582.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/37a8408f1ee689d19f20868aaeda5b06.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/6d2b7d140d71bf5c4a0121e2a6c890f1.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/51cc665ef4817e8e2d786203a6264e2c.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/d1cc9a5ca02cbe44120a0a165bbf8f83.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/4799f885ccec7f72daa25a96814bf084.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/58e0ec0ef3abeae14481aa7a6d52c80f.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/71fc58b9cb1dd0b9c253b0e4c39f6dec.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/4d9909c9fa4df8f1645c00537cacb3a1.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/abf90f85ea16751123ae30f8efd28f42.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/53fd84c867059a6fc2ce425e75ed7de1.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/5a695e32f9e5659b615932550eb38985.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/5748a358cf4c256fefcf0df44319562c.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/49745b6c9cbccb67dd9fbdc36d8b4b63.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/390c77c893fb36ea074610920042d07f.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/4ebb9dabce92bbd4ad301f52ebadc04c.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/97e75b7de73d8815e1f4a2bd46463729.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/a9617d1c00b6a83b08c8dc4a1b65ee19.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/9b819f4da778dc7fd1372b0471d8c8de.png.webp"},{"slider_image_base_url":"https://glamcode.in/user-uploads/carousel-images/fe0247388c58c954aa2ffd600801e731.jpeg.webp"}]
/// reviews : [{"id":2,"name":"Anushree: Developer","slug":"anushree-developer","description":"It was just a wow experience. Thanks Glam Code for an amazing Service.","image":"a07a6f1d8e9bcc43c2120c6c4e468394.jpg.webp","status":"active","created_at":"2020-11-17 05:33:46","updated_at":"2022-01-02 03:17:49","reviews_image_url":"https://glamcode.in/user-uploads/reviews/a07a6f1d8e9bcc43c2120c6c4e468394.jpg.webp"},{"id":6,"name":"Shilpi Shukla","slug":"shilpi-shukla","description":"Thanks Glam Code. You Know what you do. Thanks for the amazing Makeup.","image":"5e4e9d58b65f67ed49d99e4912e171a1.jpg.webp","status":"active","created_at":"2020-12-03 05:57:03","updated_at":"2022-01-02 03:20:57","reviews_image_url":"https://glamcode.in/user-uploads/reviews/5e4e9d58b65f67ed49d99e4912e171a1.jpg.webp"},{"id":10,"name":"Pratibha Singh","slug":"pratibha-singh","description":"Thanks GlamCode for making my Pre Bridal & Care and Sangeet Make up, a \" WOW\". Thank You So much.","image":"3ec7fbc23e25ee144a9aa33283814ed5.jpeg.webp","status":"active","created_at":"2020-12-13 04:44:54","updated_at":"2020-12-13 04:44:54","reviews_image_url":"https://glamcode.in/user-uploads/reviews/3ec7fbc23e25ee144a9aa33283814ed5.jpeg.webp"}]
/// videos : {"home_page_video_url":"https://www.youtube.com/embed/i-X4wtDprY8"}

class HomePageModel {
  HomePageModel({
    String? status,
    String? message,
    List<SliderImages>? sliderImages,
    List<Reviews>? reviews,
    Videos? videos,
  }) {
    _status = status;
    _message = message;
    _sliderImages = sliderImages;
    _reviews = reviews;
    _videos = videos;
  }

  HomePageModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['slider_images'] != null) {
      _sliderImages = [];
      json['slider_images'].forEach((v) {
        _sliderImages?.add(SliderImages.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
    _videos = json['videos'] != null ? Videos.fromJson(json['videos']) : null;
  }
  String? _status;
  String? _message;
  List<SliderImages>? _sliderImages;
  List<Reviews>? _reviews;
  Videos? _videos;
  HomePageModel copyWith({
    String? status,
    String? message,
    List<SliderImages>? sliderImages,
    List<Reviews>? reviews,
    Videos? videos,
  }) =>
      HomePageModel(
        status: status ?? _status,
        message: message ?? _message,
        sliderImages: sliderImages ?? _sliderImages,
        reviews: reviews ?? _reviews,
        videos: videos ?? _videos,
      );
  String? get status => _status;
  String? get message => _message;
  List<SliderImages>? get sliderImages => _sliderImages;
  List<Reviews>? get reviews => _reviews;
  Videos? get videos => _videos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_sliderImages != null) {
      map['slider_images'] = _sliderImages?.map((v) => v.toJson()).toList();
    }
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    if (_videos != null) {
      map['videos'] = _videos?.toJson();
    }
    return map;
  }
}

/// home_page_video_url : "https://www.youtube.com/embed/i-X4wtDprY8"

class Videos {
  Videos({
    String? homePageVideoUrl,
  }) {
    _homePageVideoUrl = homePageVideoUrl;
  }

  Videos.fromJson(dynamic json) {
    _homePageVideoUrl = json['home_page_video_url'];
  }
  String? _homePageVideoUrl;
  Videos copyWith({
    String? homePageVideoUrl,
  }) =>
      Videos(
        homePageVideoUrl: homePageVideoUrl ?? _homePageVideoUrl,
      );
  String? get homePageVideoUrl => _homePageVideoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['home_page_video_url'] = _homePageVideoUrl;
    return map;
  }
}

/// id : 2
/// name : "Anushree: Developer"
/// slug : "anushree-developer"
/// description : "It was just a wow experience. Thanks Glam Code for an amazing Service."
/// image : "a07a6f1d8e9bcc43c2120c6c4e468394.jpg.webp"
/// status : "active"
/// created_at : "2020-11-17 05:33:46"
/// updated_at : "2022-01-02 03:17:49"
/// reviews_image_url : "https://glamcode.in/user-uploads/reviews/a07a6f1d8e9bcc43c2120c6c4e468394.jpg.webp"

class Reviews {
  Reviews({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? image,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? reviewsImageUrl,
  }) {
    _id = id;
    _name = name;
    _slug = slug;
    _description = description;
    _image = image;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _reviewsImageUrl = reviewsImageUrl;
  }

  Reviews.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _description = json['description'];
    _image = json['image'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _reviewsImageUrl = json['reviews_image_url'];
  }
  int? _id;
  String? _name;
  String? _slug;
  String? _description;
  String? _image;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _reviewsImageUrl;
  Reviews copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? image,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? reviewsImageUrl,
  }) =>
      Reviews(
        id: id ?? _id,
        name: name ?? _name,
        slug: slug ?? _slug,
        description: description ?? _description,
        image: image ?? _image,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        reviewsImageUrl: reviewsImageUrl ?? _reviewsImageUrl,
      );
  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get description => _description;
  String? get image => _image;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get reviewsImageUrl => _reviewsImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['description'] = _description;
    map['image'] = _image;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['reviews_image_url'] = _reviewsImageUrl;
    return map;
  }
}

/// slider_image_base_url : "https://glamcode.in/user-uploads/carousel-images/cf4b29ed9d8bcdafe479091ae63483b7.png.webp"

class SliderImages {
  SliderImages({
    String? sliderImageBaseUrl,
  }) {
    _sliderImageBaseUrl = sliderImageBaseUrl;
  }

  SliderImages.fromJson(dynamic json) {
    _sliderImageBaseUrl = json['slider_image_base_url'];
  }
  String? _sliderImageBaseUrl;
  SliderImages copyWith({
    String? sliderImageBaseUrl,
  }) =>
      SliderImages(
        sliderImageBaseUrl: sliderImageBaseUrl ?? _sliderImageBaseUrl,
      );
  String? get sliderImageBaseUrl => _sliderImageBaseUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slider_image_base_url'] = _sliderImageBaseUrl;
    return map;
  }
}
