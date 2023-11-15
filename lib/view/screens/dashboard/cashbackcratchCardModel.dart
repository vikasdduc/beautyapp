class ScratchCardModel {
  String? status;
  String? type;
  Data? data;

  ScratchCardModel({this.status, this.type, this.data});

  ScratchCardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<CashbackService>? cashbackService;
  List<Cashback>? cashback;
  List<ThirdPartyCoupon>? thirdPartyCoupon;

  Data({this.cashbackService, this.cashback, this.thirdPartyCoupon});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cashbackService'] != null) {
      cashbackService = <CashbackService>[];
      json['cashbackService'].forEach((v) {
        cashbackService!.add(new CashbackService.fromJson(v));
      });
    }
    if (json['cashback'] != null) {
      cashback = <Cashback>[];
      json['cashback'].forEach((v) {
        cashback!.add(new Cashback.fromJson(v));
      });
    }
    if (json['thirdPartyCoupon'] != null) {
      thirdPartyCoupon = <ThirdPartyCoupon>[];
      json['thirdPartyCoupon'].forEach((v) {
        thirdPartyCoupon!.add(new ThirdPartyCoupon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cashbackService != null) {
      data['cashbackService'] =
          this.cashbackService!.map((v) => v.toJson()).toList();
    }
    if (this.cashback != null) {
      data['cashback'] = this.cashback!.map((v) => v.toJson()).toList();
    }
    if (this.thirdPartyCoupon != null) {
      data['thirdPartyCoupon'] =
          this.thirdPartyCoupon!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CashbackService {
  int? id;
  String? name;
  String? slug;
  String? description;
  String? mobileLongDescription;
  String? mobileLongDescription2;
  String? mobileLongDescription3;
  String? mobileLongDescription4;
  String? longDescription;
  int? price;
  int? time;
  String? sort;
  String? timeType;
  int? discount;
  String? discountType;
  int? mainCategoryId;
  int? categoryId;
  String? subCategoryId;
  int? packagesId;
  int? locationId;
  List<String>? image;
  String? defaultImage;
  String? status;
  String? altImage;
  String? preferedService;
  String? locationCity;
  int? homePage;
  String? seoTitle;
  String? seoDesc;
  String? seoKey;
  String? createdAt;
  String? updatedAt;
  String? ratingPer;
  int? ratingPop;
  String? inventoryId;
  String? productUsage;
  String? scratched;
  int? cashbackId;
  String? type;
  String? serviceImageUrl;
  String? serviceDetailUrl;
  int? discountedPrice;
  Category? category;

  CashbackService(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.mobileLongDescription,
      this.mobileLongDescription2,
      this.mobileLongDescription3,
      this.mobileLongDescription4,
      this.longDescription,
      this.price,
      this.time,
      this.sort,
      this.timeType,
      this.discount,
      this.discountType,
      this.mainCategoryId,
      this.categoryId,
      this.subCategoryId,
      this.packagesId,
      this.locationId,
      this.image,
      this.defaultImage,
      this.status,
      this.altImage,
      this.preferedService,
      this.locationCity,
      this.homePage,
      this.seoTitle,
      this.seoDesc,
      this.seoKey,
      this.createdAt,
      this.updatedAt,
      this.ratingPer,
      this.ratingPop,
      this.inventoryId,
      this.productUsage,
      this.scratched,
      this.cashbackId,
      this.type,
      this.serviceImageUrl,
      this.serviceDetailUrl,
      this.discountedPrice,
      this.category});

  CashbackService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    mobileLongDescription = json['mobile_long_description'];
    mobileLongDescription2 = json['mobile_long_description2'];
    mobileLongDescription3 = json['mobile_long_description3'];
    mobileLongDescription4 = json['mobile_long_description4'];
    longDescription = json['long_description'];
    price = json['price'];
    time = json['time'];
    sort = json['sort'];
    timeType = json['time_type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    mainCategoryId = json['main_category_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    packagesId = json['packages_id'];
    locationId = json['location_id'];
    image = json['image'].cast<String>();
    defaultImage = json['default_image'];
    status = json['status'];
    altImage = json['altImage'];
    preferedService = json['prefered_service'];
    locationCity = json['location_city'];
    homePage = json['home_page'];
    seoTitle = json['seo_title'];
    seoDesc = json['seo_desc'];
    seoKey = json['seo_key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratingPer = json['rating_per'];
    ratingPop = json['rating_pop'];
    inventoryId = json['inventory_id'];
    productUsage = json['product_usage'];
    scratched = json['scratched'];
    cashbackId = json['cashbackId'];
    type = json['type'];
    serviceImageUrl = json['service_image_url'];
    serviceDetailUrl = json['service_detail_url'];
    discountedPrice = json['discounted_price'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['mobile_long_description'] = this.mobileLongDescription;
    data['mobile_long_description2'] = this.mobileLongDescription2;
    data['mobile_long_description3'] = this.mobileLongDescription3;
    data['mobile_long_description4'] = this.mobileLongDescription4;
    data['long_description'] = this.longDescription;
    data['price'] = this.price;
    data['time'] = this.time;
    data['sort'] = this.sort;
    data['time_type'] = this.timeType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['main_category_id'] = this.mainCategoryId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['packages_id'] = this.packagesId;
    data['location_id'] = this.locationId;
    data['image'] = this.image;
    data['default_image'] = this.defaultImage;
    data['status'] = this.status;
    data['altImage'] = this.altImage;
    data['prefered_service'] = this.preferedService;
    data['location_city'] = this.locationCity;
    data['home_page'] = this.homePage;
    data['seo_title'] = this.seoTitle;
    data['seo_desc'] = this.seoDesc;
    data['seo_key'] = this.seoKey;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['rating_per'] = this.ratingPer;
    data['rating_pop'] = this.ratingPop;
    data['inventory_id'] = this.inventoryId;
    data['product_usage'] = this.productUsage;
    data['scratched'] = this.scratched;
    data['cashbackId'] = this.cashbackId;
    data['type'] = this.type;
    data['service_image_url'] = this.serviceImageUrl;
    data['service_detail_url'] = this.serviceDetailUrl;
    data['discounted_price'] = this.discountedPrice;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? mainCategoryId;
  String? name;
  String? slug;
  String? image;
  String? status;
  String? sortOrder;
  String? createdAt;
  String? updatedAt;
  String? ratingPer;
  int? ratingPop;
  String? categoryImageUrl;

  Category(
      {this.id,
      this.mainCategoryId,
      this.name,
      this.slug,
      this.image,
      this.status,
      this.sortOrder,
      this.createdAt,
      this.updatedAt,
      this.ratingPer,
      this.ratingPop,
      this.categoryImageUrl});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainCategoryId = json['main_category_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    status = json['status'];
    sortOrder = json['sort_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratingPer = json['rating_per'];
    ratingPop = json['rating_pop'];
    categoryImageUrl = json['category_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main_category_id'] = this.mainCategoryId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['status'] = this.status;
    data['sort_order'] = this.sortOrder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['rating_per'] = this.ratingPer;
    data['rating_pop'] = this.ratingPop;
    data['category_image_url'] = this.categoryImageUrl;
    return data;
  }
}

class Cashback {
  int? cashbackId;
  String? amount;
  String? unit;
  String? scratched;
  String? type;

  Cashback(
      {this.cashbackId, this.amount, this.unit, this.scratched, this.type});

  Cashback.fromJson(Map<String, dynamic> json) {
    cashbackId = json['cashbackId'];
    amount = json['amount'];
    unit = json['unit'];
    scratched = json['scratched'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cashbackId'] = this.cashbackId;
    data['amount'] = this.amount;
    data['unit'] = this.unit;
    data['scratched'] = this.scratched;
    data['type'] = this.type;
    return data;
  }
}

class ThirdPartyCoupon {
  int? id;
  String? title;
  String? startDateTime;
  String? endDateTime;
  int? usesLimit;
  int? usedTime;
  int? amount;
  int? percent;
  int? minimumPurchaseAmount;
  String? days;
  String? status;
  String? description;
  int? newUsers;
  int? visibility;
  String? createdAt;
  String? updatedAt;
  int? cashbackId;
  String? cashbackName;
  String? scratched;
  String? type;

  ThirdPartyCoupon(
      {this.id,
      this.title,
      this.startDateTime,
      this.endDateTime,
      this.usesLimit,
      this.usedTime,
      this.amount,
      this.percent,
      this.minimumPurchaseAmount,
      this.days,
      this.status,
      this.description,
      this.newUsers,
      this.visibility,
      this.createdAt,
      this.updatedAt,
      this.cashbackId,
      this.cashbackName,
      this.scratched,
      this.type});

  ThirdPartyCoupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    usesLimit = json['uses_limit'];
    usedTime = json['used_time'];
    amount = json['amount'];
    percent = json['percent'];
    minimumPurchaseAmount = json['minimum_purchase_amount'];
    days = json['days'];
    status = json['status'];
    description = json['description'];
    newUsers = json['new_users'];
    visibility = json['visibility'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cashbackId = json['cashbackId'];
    cashbackName = json['cashbackName'];
    scratched = json['scratched'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start_date_time'] = this.startDateTime;
    data['end_date_time'] = this.endDateTime;
    data['uses_limit'] = this.usesLimit;
    data['used_time'] = this.usedTime;
    data['amount'] = this.amount;
    data['percent'] = this.percent;
    data['minimum_purchase_amount'] = this.minimumPurchaseAmount;
    data['days'] = this.days;
    data['status'] = this.status;
    data['description'] = this.description;
    data['new_users'] = this.newUsers;
    data['visibility'] = this.visibility;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cashbackId'] = this.cashbackId;
    data['cashbackName'] = this.cashbackName;
    data['scratched'] = this.scratched;
    data['type'] = this.type;
    return data;
  }
}
