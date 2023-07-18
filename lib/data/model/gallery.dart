/// status : "success"
/// message : "Gallery Images"
/// gallery_images : [{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/079e6de523c20aa691b40295c59ad9ad.png.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/f8fb41b4293676a9180e7f0cbd29cb96.png.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/910d93419ef5d199ef3b45ad33afe242.png.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/9daf78322d6d805631afd01b380c4a8f.jpeg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/442ba72852d24dba15f8b360f28f80f9.jpeg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/85e441933bc1b6eb4b8389145717cc50.jpeg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/5de8dcf825902fb69cb5baa78a1e053b.jpeg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/aad578468b2688b29b65eefe10798a35.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/a4b499c18c7fd34e85b3ceb07bd9610d.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/8c835dc69e8181b1209163040bb2d73c.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/a8c1aa46491cc03c13cf608346e5e67f.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/556dd1e765c471c55b57635547925b69.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/354f3e2bf95bffda20f7d892e33ee66f.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/0053b88f7a16117e60ab01f7f13bd676.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/8ef2339cc407b15afb2dd0b6435f917b.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/61b410678e3085db573927a56ee243a8.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/b332c9814552e3a3e6802e72e6e3d3dc.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/2c9e9dfc32eb46df5ae9452fdef2b157.jpeg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/1bb29a4b7df16acf402888f1f5064f44.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/51d1ad7a6ec0f8d1c04d8ac58995585d.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/c9e1539305cec6fc884d23c4bc6c3bd1.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/12c31990f967bf3ba363ec6d52d1d121.jpg.webp"},{"mediaType":"image","videoImage":"","gallery_image_base_url":"https://www.glamcode.in/user-uploads/gallery-images/e6911b01a9615ab73f2c6c80fcef26dc.jpeg.webp"}]

class Gallery {
  Gallery({
    String? status,
    String? message,
    List<GalleryImages>? galleryImages,
  }) {
    _status = status;
    _message = message;
    _galleryImages = galleryImages;
  }

  Gallery.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['gallery_images'] != null) {
      _galleryImages = [];
      json['gallery_images'].forEach((v) {
        _galleryImages?.add(GalleryImages.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<GalleryImages>? _galleryImages;
  Gallery copyWith({
    String? status,
    String? message,
    List<GalleryImages>? galleryImages,
  }) =>
      Gallery(
        status: status ?? _status,
        message: message ?? _message,
        galleryImages: galleryImages ?? _galleryImages,
      );
  String? get status => _status;
  String? get message => _message;
  List<GalleryImages>? get galleryImages => _galleryImages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_galleryImages != null) {
      map['gallery_images'] = _galleryImages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// mediaType : "image"
/// videoImage : ""
/// gallery_image_base_url : "https://www.glamcode.in/user-uploads/gallery-images/079e6de523c20aa691b40295c59ad9ad.png.webp"

class GalleryImages {
  GalleryImages({
    String? mediaType,
    String? videoImage,
    String? galleryImageBaseUrl,
  }) {
    _mediaType = mediaType;
    _videoImage = videoImage;
    _galleryImageBaseUrl = galleryImageBaseUrl;
  }

  GalleryImages.fromJson(dynamic json) {
    _mediaType = json['mediaType'];
    _videoImage = json['videoImage'];
    _galleryImageBaseUrl = json['gallery_image_base_url'];
  }
  String? _mediaType;
  String? _videoImage;
  String? _galleryImageBaseUrl;
  GalleryImages copyWith({
    String? mediaType,
    String? videoImage,
    String? galleryImageBaseUrl,
  }) =>
      GalleryImages(
        mediaType: mediaType ?? _mediaType,
        videoImage: videoImage ?? _videoImage,
        galleryImageBaseUrl: galleryImageBaseUrl ?? _galleryImageBaseUrl,
      );
  String? get mediaType => _mediaType;
  String? get videoImage => _videoImage;
  String? get galleryImageBaseUrl => _galleryImageBaseUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mediaType'] = _mediaType;
    map['videoImage'] = _videoImage;
    map['gallery_image_base_url'] = _galleryImageBaseUrl;
    return map;
  }
}
