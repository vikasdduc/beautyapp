import 'dart:convert';

/// status : "success"
/// message : "Booking Id"
/// bookingid : "2772"
/// payments : "2020"
/// serviceInsrted : "completed"
/// bookingget : {"id":2772,"deal_id":null,"deal_quantity":0,"coupon_id":null,"user_id":3965,"date_time":"2022-12-30T07:00:00.000000Z","status":"pending","payment_gateway":"cash","original_amount":5904,"discount":0,"coupon_discount":0,"discount_percent":0,"tax_name":"","tax_percent":0,"tax_amount":null,"extra_fees":49,"distance_fee":0,"amount_to_pay":5953,"payment_status":"pending","source":"online","additional_notes":"","created_at":null,"updated_at":null,"user":{"id":3965,"group_id":null,"refcode":null,"wallet":null,"parent_id":null,"name":"Tejesh Reddy","email":"6309672824@glamcode.com","address":"Sonewherw,3/27, 3/27, Jaipuria Rd, Vineet Khand, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India","detailed_address":"Sonewherw,3/27, 3/27, Jaipuria Rd, Vineet Khand, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India","latitude":22.958048999999999040255715954117476940155029296875,"longitude":88.435383599999994430618244223296642303466796875,"mobile":"6309672824","vender_loction_id":null,"calling_code":"+91","mobile_verified":1,"image":null,"created_at":"2022-12-05 09:28:45","updated_at":"2022-12-05 09:32:42","deleted_at":null,"user_image_url":"https://www.glamcode.in/img/default-avatar-user.png","mobile_with_code":"916309672824","formatted_mobile":"+91-6309672824"},"items":[{"id":12299,"booking_id":2772,"business_service_id":502,"quantity":2,"unit_price":429,"amount":429,"created_at":"2022-12-29 17:31:51","updated_at":"2022-12-29 17:31:51","business_service":{"id":502,"name":"Legs Show Off","slug":"legs-show-off-noida","description":"<p>&nbsp; Honey Wax - FA ,UA &amp; FL.</p><p>&nbsp; Threading: Eye Brows &amp; Upper Lips&nbsp;</p>","mobile_long_description":null,"mobile_long_description2":null,"mobile_long_description3":null,"mobile_long_description4":null,"long_description":null,"price":858,"time":60,"sort":null,"time_type":"minutes","discount":50,"discount_type":"percent","main_category_id":33,"category_id":244,"sub_category_id":null,"packages_id":0,"location_id":6,"image":["da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp"],"default_image":"da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp","status":"active","prefered_service":"Yes","location_city":"Noida","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-15 03:49:54","updated_at":"2022-12-11 03:54:05","rating_per":"4.75","rating_pop":12000,"service_image_url":"https://www.glamcode.in/user-uploads/service/502/da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp","service_detail_url":"https://www.glamcode.in/499-store/legs-show-off-noida","discounted_price":429,"category":{"id":244,"main_category_id":"33","name":"499 Store","slug":"499-store","image":"3840a99398a49a9ff7edeaa00976da60.png.webp","status":"active","sort_order":null,"created_at":"2021-12-14 21:52:46","updated_at":"2022-11-19 03:24:11","rating_per":"4.75","rating_pop":12000,"category_image_url":"https://www.glamcode.in/user-uploads/subcategory/3840a99398a49a9ff7edeaa00976da60.png.webp"}}},{"id":12300,"booking_id":2772,"business_service_id":497,"quantity":1,"unit_price":1599,"amount":1599,"created_at":"2022-12-29 17:31:51","updated_at":"2022-12-29 17:31:51","business_service":{"id":497,"name":"Glam Code Gift","slug":"glam-code-gift-noida","description":"<p><span style=\"font-size: 14px;\">&nbsp;VLCC Insta Glow Facial.</span></p><p><span style=\"font-size: 14px;\">&nbsp;Exotic Manicure-Pedicure.</span></p><p><span style=\"font-size: 14px;\">&nbsp;Honey Wax - Full Arms, Full Legs&amp; Under Arms.</span></p><p><span style=\"font-size: 14px;\">&nbsp;Bleach / De Tan (Face and Neck).</span><br></p><p><span style=\"font-size: 14px;\">&nbsp;Free threading - Eyebrows &amp;Upper lip</span></p>","mobile_long_description":null,"mobile_long_description2":null,"mobile_long_description3":null,"mobile_long_description4":null,"long_description":"<p>VLCC Insta Glow Facial.</p><p>Exotic Manicure-Pedicure.</p><p>Honey Wax - Full Arms, Full Legs&amp; Under Arms.</p><p>Bleach / De Tan (Face and Neck).<br></p><p>Free threading - Eyebrows &amp;Upper lip</p>","price":2665,"time":205,"sort":1,"time_type":"minutes","discount":40,"discount_type":"percent","main_category_id":29,"category_id":239,"sub_category_id":null,"packages_id":0,"location_id":6,"image":["16765b9851c5c6b3dbcb4dc6f4a05b7c.png.webp"],"default_image":"16765b9851c5c6b3dbcb4dc6f4a05b7c.png.webp","status":"active","prefered_service":"Yes","location_city":"Noida","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-15 03:47:22","updated_at":"2022-12-13 07:35:55","rating_per":"4.75","rating_pop":12000,"service_image_url":"https://www.glamcode.in/user-uploads/service/497/16765b9851c5c6b3dbcb4dc6f4a05b7c.png.webp","service_detail_url":"https://www.glamcode.in/tip-to-toe/glam-code-gift-noida","discounted_price":1599,"category":{"id":239,"main_category_id":"29","name":"Tip To Toe","slug":"tip-to-toe","image":"3d328acbe5e4db60d1de7a7c606edf8d.png.webp","status":"active","sort_order":null,"created_at":"2021-12-14 21:50:09","updated_at":"2022-11-18 08:25:33","rating_per":"4.75","rating_pop":12000,"category_image_url":"https://www.glamcode.in/user-uploads/subcategory/3d328acbe5e4db60d1de7a7c606edf8d.png.webp"}}},{"id":12301,"booking_id":2772,"business_service_id":499,"quantity":1,"unit_price":1799,"amount":1799,"created_at":"2022-12-29 17:31:51","updated_at":"2022-12-29 17:31:51","business_service":{"id":499,"name":"Fitness Beauty","slug":"fitness-beauty-noida","description":"<p><font face=\"HelveticaNeue\"><span style=\"font-size: 12px;\"><span style=\"font-size: 14px;\">F</span><span style=\"font-size: 14px;\">acial : Sara Gold.</span></span></font></p><p><span style=\"font-size: 14px; font-family: HelveticaNeue;\">Honey Wax: Full Legs , Full Arms &amp; Underarms .</span></p><p><span style=\"font-family: HelveticaNeue; font-size: 14px;\">Vedic Valley Manicure.</span></p><p><span style=\"font-family: HelveticaNeue; font-size: 14px;\">Vedic Valley Pedicure.</span></p><p><span style=\"font-family: HelveticaNeue; font-size: 14px;\">Detan/Bleach ( Face&amp; Neck).</span></p><p><span style=\"font-family: HelveticaNeue; font-size: 14px;\"><span style=\"font-size: 14px;\">Head Massage (10 mins)</span></span><br></p><p><font face=\"HelveticaNeue\"><span style=\"font-size: 14px;\"><br></span></font></p><p><font face=\"HelveticaNeue\"><span style=\"font-size: 12px;\"><br></span></font></p>","mobile_long_description":null,"mobile_long_description2":null,"mobile_long_description3":null,"mobile_long_description4":null,"long_description":"<p>&nbsp;Ac is Highly recommended.</p>","price":3598,"time":220,"sort":3,"time_type":"minutes","discount":50,"discount_type":"percent","main_category_id":29,"category_id":239,"sub_category_id":null,"packages_id":0,"location_id":6,"image":["4b9cc7b8a6626e3ed0613b12351c8b79.jpeg.webp"],"default_image":"4b9cc7b8a6626e3ed0613b12351c8b79.jpeg.webp","status":"active","prefered_service":"Yes","location_city":"Noida","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-15 03:48:23","updated_at":"2022-12-13 07:32:39","rating_per":"4.75","rating_pop":12000,"service_image_url":"https://www.glamcode.in/user-uploads/service/499/4b9cc7b8a6626e3ed0613b12351c8b79.jpeg.webp","service_detail_url":"https://www.glamcode.in/tip-to-toe/fitness-beauty-noida","discounted_price":1799,"category":{"id":239,"main_category_id":"29","name":"Tip To Toe","slug":"tip-to-toe","image":"3d328acbe5e4db60d1de7a7c606edf8d.png.webp","status":"active","sort_order":null,"created_at":"2021-12-14 21:50:09","updated_at":"2022-11-18 08:25:33","rating_per":"4.75","rating_pop":12000,"category_image_url":"https://www.glamcode.in/user-uploads/subcategory/3d328acbe5e4db60d1de7a7c606edf8d.png.webp"}}},{"id":12302,"booking_id":2772,"business_service_id":485,"quantity":2,"unit_price":725,"amount":725,"created_at":"2022-12-29 17:31:51","updated_at":"2022-12-29 17:31:51","business_service":{"id":485,"name":"Instant Ready","slug":"instant-ready-noida","description":"<p>&nbsp;Facial: VLCC.</p><p>&nbsp;Face &amp; Neck Bleach / De Tan.</p><p>&nbsp;Free Threading Eyebrows.</p><p>&nbsp;Free Threading Upper lip</p>","mobile_long_description":null,"mobile_long_description2":null,"mobile_long_description3":null,"mobile_long_description4":null,"long_description":"<p><span style=\"text-align: center;\">&nbsp;Steam is not included.</span><br></p><p>&nbsp;Facial: VLCC.</p><p>&nbsp;Face &amp; Neck Bleach/Raaga DeTan.</p><p>&nbsp;Free Threading Eyebrows &amp; Upper lips.</p><p>&nbsp;Choose from Any.</p><p>&nbsp;VLCC Fruit.</p><p>&nbsp;VLCC Insta Glow.</p><p>&nbsp;VLCC Skin Tightening.</p><p>&nbsp;VLCC Anti Tan Facial<br></p><p><br></p>","price":1450,"time":75,"sort":1,"time_type":"minutes","discount":50,"discount_type":"percent","main_category_id":29,"category_id":230,"sub_category_id":null,"packages_id":0,"location_id":6,"image":["8c2541f8f1ef3c64a78f0bc3c96eb2e1.png.webp"],"default_image":"8c2541f8f1ef3c64a78f0bc3c96eb2e1.png.webp","status":"active","prefered_service":"No","location_city":"Noida","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-15 03:31:29","updated_at":"2022-12-13 07:37:29","rating_per":"4.75","rating_pop":12000,"service_image_url":"https://www.glamcode.in/user-uploads/service/485/8c2541f8f1ef3c64a78f0bc3c96eb2e1.png.webp","service_detail_url":"https://www.glamcode.in/facial-deals/instant-ready-noida","discounted_price":725,"category":{"id":230,"main_category_id":"29","name":"Facial Deals","slug":"facial-deals","image":"991cfef24a9d5bb567c8ff199fae92e2.png.webp","status":"active","sort_order":null,"created_at":"2021-12-14 21:48:09","updated_at":"2022-11-18 08:24:28","rating_per":"4.75","rating_pop":12000,"category_image_url":"https://www.glamcode.in/user-uploads/subcategory/991cfef24a9d5bb567c8ff199fae92e2.png.webp"}}}]}

PaymentResponseModel paymentResponseFromJson(String str) =>
    PaymentResponseModel.fromJson(json.decode(str));

String paymentResponseToJson(PaymentResponseModel data) =>
    json.encode(data.toJson());

class PaymentResponseModel {
  PaymentResponseModel(
      {this.status,
      this.message,
      this.bookingid,
      this.payments,
      this.serviceInsrted,
      this.bookingget,
      this.coupon});

  PaymentResponseModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    bookingid = json['bookingid'];
    payments = json['payments'];
    serviceInsrted = json['serviceInsrted'];
    bookingget = json['bookingget'] != null
        ? Bookingget.fromJson(json['bookingget'])
        : null;
    coupon = json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null;
  }

  String? status;
  String? message;
  String? bookingid;
  String? payments;
  String? serviceInsrted;
  Bookingget? bookingget;
  Coupon? coupon;

  PaymentResponseModel copyWith({
    String? status,
    String? message,
    String? bookingid,
    String? payments,
    String? serviceInsrted,
    Bookingget? bookingget,
    Coupon? coupon,
  }) =>
      PaymentResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        bookingid: bookingid ?? this.bookingid,
        payments: payments ?? this.payments,
        serviceInsrted: serviceInsrted ?? this.serviceInsrted,
        bookingget: bookingget ?? this.bookingget,
        coupon: coupon ?? this.coupon,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['bookingid'] = bookingid;
    map['payments'] = payments;
    map['serviceInsrted'] = serviceInsrted;
    if (bookingget != null) {
      map['bookingget'] = bookingget?.toJson();
    }
    if (coupon != null) {
      map['coupon'] = coupon!.toJson();
    }
    return map;
  }
}

class Coupon {
  int? userId;
  int? bookingId;
  int? points;
  String? coupon;
  CouponType couponType = CouponType.POINTS;
  String? expiry;
  int? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Coupon(
      {this.userId,
      this.bookingId,
      this.points,
      this.expiry,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Coupon.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    bookingId = json['booking_id'];
    points = json['points'] != null ? int.parse(json['points']) : null;
    coupon = json['coupon'];
    if (points != null) {
      couponType = CouponType.POINTS;
    } else {
      if (coupon!.contains("#")) {
        couponType = CouponType.DISCOUNT;
      } else {
        couponType = CouponType.SERVICE_ADD_ON;
      }
    }
    expiry = json['expiry'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['booking_id'] = bookingId;
    data['points'] = points;
    data['expiry'] = expiry;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

/// id : 2772
/// deal_id : null
/// deal_quantity : 0
/// coupon_id : null
/// user_id : 3965
/// date_time : "2022-12-30T07:00:00.000000Z"
/// status : "pending"
/// payment_gateway : "cash"
/// original_amount : 5904
/// discount : 0
/// coupon_discount : 0
/// discount_percent : 0
/// tax_name : ""
/// tax_percent : 0
/// tax_amount : null
/// extra_fees : 49
/// distance_fee : 0
/// amount_to_pay : 5953
/// payment_status : "pending"
/// source : "online"
/// additional_notes : ""
/// created_at : null
/// updated_at : null
/// user : {"id":3965,"group_id":null,"refcode":null,"wallet":null,"parent_id":null,"name":"Tejesh Reddy","email":"6309672824@glamcode.com","address":"Sonewherw,3/27, 3/27, Jaipuria Rd, Vineet Khand, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India","detailed_address":"Sonewherw,3/27, 3/27, Jaipuria Rd, Vineet Khand, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India","latitude":22.958048999999999040255715954117476940155029296875,"longitude":88.435383599999994430618244223296642303466796875,"mobile":"6309672824","vender_loction_id":null,"calling_code":"+91","mobile_verified":1,"image":null,"created_at":"2022-12-05 09:28:45","updated_at":"2022-12-05 09:32:42","deleted_at":null,"user_image_url":"https://www.glamcode.in/img/default-avatar-user.png","mobile_with_code":"916309672824","formatted_mobile":"+91-6309672824"}
/// items : [{"id":12299,"booking_id":2772,"business_service_id":502,"quantity":2,"unit_price":429,"amount":429,"created_at":"2022-12-29 17:31:51","updated_at":"2022-12-29 17:31:51","business_service":{"id":502,"name":"Legs Show Off","slug":"legs-show-off-noida","description":"<p>&nbsp; Honey Wax - FA ,UA &amp; FL.</p><p>&nbsp; Threading: Eye Brows &amp; Upper Lips&nbsp;</p>","mobile_long_description":null,"mobile_long_description2":null,"mobile_long_description3":null,"mobile_long_description4":null,"long_description":null,"price":858,"time":60,"sort":null,"time_type":"minutes","discount":50,"discount_type":"percent","main_category_id":33,"category_id":244,"sub_category_id":null,"packages_id":0,"location_id":6,"image":["da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp"],"default_image":"da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp","status":"active","prefered_service":"Yes","location_city":"Noida","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-15 03:49:54","updated_at":"2022-12-11 03:54:05","rating_per":"4.75","rating_pop":12000,"service_image_url":"https://www.glamcode.in/user-uploads/service/502/da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp","service_detail_url":"https://www.glamcode.in/499-store/legs-show-off-noida","discounted_price":429,"category":{"id":244,"main_category_id":"33","name":"499 Store","slug":"499-store","image":"3840a99398a49a9ff7edeaa00976da60.png.webp","status":"active","sort_order":null,"created_at":"2021-12-14 21:52:46","updated_at":"2022-11-19 03:24:11","rating_per":"4.75","rating_pop":12000,"category_image_url":"https://www.glamcode.in/user-uploads/subcategory/3840a99398a49a9ff7edeaa00976da60.png.webp"}}},{"id":12300,"booking_id":2772,"business_service_id":497,"quantity":1,"unit_price":1599,"amount":1599,"created_at":"2022-12-29 17:31:51","updated_at":"2022-12-29 17:31:51","business_service":{"id":497,"name":"Glam Code Gift","slug":"glam-code-gift-noida","description":"<p><span style=\"font-size: 14px;\">&nbsp;VLCC Insta Glow Facial.</span></p><p><span style=\"font-size: 14px;\">&nbsp;Exotic Manicure-Pedicure.</span></p><p><span style=\"font-size: 14px;\">&nbsp;Honey Wax - Full Arms, Full Legs&amp; Under Arms.</span></p><p><span style=\"font-size: 14px;\">&nbsp;Bleach / De Tan (Face and Neck).</span><br></p><p><span style=\"font-size: 14px;\">&nbsp;Free threading - Eyebrows &amp;Upper lip</span></p>","mobile_long_description":null,"mobile_long_description2":null,"mobile_long_description3":null,"mobile_long_description4":null,"long_description":"<p>VLCC Insta Glow Facial.</p><p>Exotic Manicure-Pedicure.</p><p>Honey Wax - Full Arms, Full Legs&amp; Under Arms.</p><p>Bleach / De Tan (Face and Neck).<br></p><p>Free threading - Eyebrows &amp;Upper lip</p>","price":2665,"time":205,"sort":1,"time_type":"minutes","discount":40,"discount_type":"percent","main_category_id":29,"category_id":239,"sub_category_id":null,"packages_id":0,"location_id":6,"image":["16765b9851c5c6b3dbcb4dc6f4a05b7c.png.webp"],"default_image":"16765b9851c5c6b3dbcb4dc6f4a05b7c.png.webp","status":"active","prefered_service":"Yes","location_city":"Noida","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-15 03:47:22","updated_at":"2022-12-13 07:35:55","rating_per":"4.75","rating_pop":12000,"service_image_url":"https://www.glamcode.in/user-uploads/service/497/16765b9851c5c6b3dbcb4dc6f4a05b7c.png.webp","service_detail_url":"https://www.glamcode.in/tip-to-toe/glam-code-gift-noida","discounted_price":1599,"category":{"id":239,"main_category_id":"29","name":"Tip To Toe","slug":"tip-to-toe","image":"3d328acbe5e4db60d1de7a7c606edf8d.png.webp","status":"active","sort_order":null,"created_at":"2021-12-14 21:50:09","updated_at":"2022-11-18 08:25:33","rating_per":"4.75","rating_pop":12000,"category_image_url":"https://www.glamcode.in/user-uploads/subcategory/3d328acbe5e4db60d1de7a7c606edf8d.png.webp"}}},{"id":12301,"booking_id":2772,"business_service_id":499,"quantity":1,"unit_price":1799,"amount":1799,"created_at":"2022-12-29 17:31:51","updated_at":"2022-12-29 17:31:51","business_service":{"id":499,"name":"Fitness Beauty","slug":"fitness-beauty-noida","description":"<p><font face=\"HelveticaNeue\"><span style=\"font-size: 12px;\"><span style=\"font-size: 14px;\">F</span><span style=\"font-size: 14px;\">acial : Sara Gold.</span></span></font></p><p><span style=\"font-size: 14px; font-family: HelveticaNeue;\">Honey Wax: Full Legs , Full Arms &amp; Underarms .</span></p><p><span style=\"font-family: HelveticaNeue; font-size: 14px;\">Vedic Valley Manicure.</span></p><p><span style=\"font-family: HelveticaNeue; font-size: 14px;\">Vedic Valley Pedicure.</span></p><p><span style=\"font-family: HelveticaNeue; font-size: 14px;\">Detan/Bleach ( Face&amp; Neck).</span></p><p><span style=\"font-family: HelveticaNeue; font-size: 14px;\"><span style=\"font-size: 14px;\">Head Massage (10 mins)</span></span><br></p><p><font face=\"HelveticaNeue\"><span style=\"font-size: 14px;\"><br></span></font></p><p><font face=\"HelveticaNeue\"><span style=\"font-size: 12px;\"><br></span></font></p>","mobile_long_description":null,"mobile_long_description2":null,"mobile_long_description3":null,"mobile_long_description4":null,"long_description":"<p>&nbsp;Ac is Highly recommended.</p>","price":3598,"time":220,"sort":3,"time_type":"minutes","discount":50,"discount_type":"percent","main_category_id":29,"category_id":239,"sub_category_id":null,"packages_id":0,"location_id":6,"image":["4b9cc7b8a6626e3ed0613b12351c8b79.jpeg.webp"],"default_image":"4b9cc7b8a6626e3ed0613b12351c8b79.jpeg.webp","status":"active","prefered_service":"Yes","location_city":"Noida","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-15 03:48:23","updated_at":"2022-12-13 07:32:39","rating_per":"4.75","rating_pop":12000,"service_image_url":"https://www.glamcode.in/user-uploads/service/499/4b9cc7b8a6626e3ed0613b12351c8b79.jpeg.webp","service_detail_url":"https://www.glamcode.in/tip-to-toe/fitness-beauty-noida","discounted_price":1799,"category":{"id":239,"main_category_id":"29","name":"Tip To Toe","slug":"tip-to-toe","image":"3d328acbe5e4db60d1de7a7c606edf8d.png.webp","status":"active","sort_order":null,"created_at":"2021-12-14 21:50:09","updated_at":"2022-11-18 08:25:33","rating_per":"4.75","rating_pop":12000,"category_image_url":"https://www.glamcode.in/user-uploads/subcategory/3d328acbe5e4db60d1de7a7c606edf8d.png.webp"}}},{"id":12302,"booking_id":2772,"business_service_id":485,"quantity":2,"unit_price":725,"amount":725,"created_at":"2022-12-29 17:31:51","updated_at":"2022-12-29 17:31:51","business_service":{"id":485,"name":"Instant Ready","slug":"instant-ready-noida","description":"<p>&nbsp;Facial: VLCC.</p><p>&nbsp;Face &amp; Neck Bleach / De Tan.</p><p>&nbsp;Free Threading Eyebrows.</p><p>&nbsp;Free Threading Upper lip</p>","mobile_long_description":null,"mobile_long_description2":null,"mobile_long_description3":null,"mobile_long_description4":null,"long_description":"<p><span style=\"text-align: center;\">&nbsp;Steam is not included.</span><br></p><p>&nbsp;Facial: VLCC.</p><p>&nbsp;Face &amp; Neck Bleach/Raaga DeTan.</p><p>&nbsp;Free Threading Eyebrows &amp; Upper lips.</p><p>&nbsp;Choose from Any.</p><p>&nbsp;VLCC Fruit.</p><p>&nbsp;VLCC Insta Glow.</p><p>&nbsp;VLCC Skin Tightening.</p><p>&nbsp;VLCC Anti Tan Facial<br></p><p><br></p>","price":1450,"time":75,"sort":1,"time_type":"minutes","discount":50,"discount_type":"percent","main_category_id":29,"category_id":230,"sub_category_id":null,"packages_id":0,"location_id":6,"image":["8c2541f8f1ef3c64a78f0bc3c96eb2e1.png.webp"],"default_image":"8c2541f8f1ef3c64a78f0bc3c96eb2e1.png.webp","status":"active","prefered_service":"No","location_city":"Noida","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-15 03:31:29","updated_at":"2022-12-13 07:37:29","rating_per":"4.75","rating_pop":12000,"service_image_url":"https://www.glamcode.in/user-uploads/service/485/8c2541f8f1ef3c64a78f0bc3c96eb2e1.png.webp","service_detail_url":"https://www.glamcode.in/facial-deals/instant-ready-noida","discounted_price":725,"category":{"id":230,"main_category_id":"29","name":"Facial Deals","slug":"facial-deals","image":"991cfef24a9d5bb567c8ff199fae92e2.png.webp","status":"active","sort_order":null,"created_at":"2021-12-14 21:48:09","updated_at":"2022-11-18 08:24:28","rating_per":"4.75","rating_pop":12000,"category_image_url":"https://www.glamcode.in/user-uploads/subcategory/991cfef24a9d5bb567c8ff199fae92e2.png.webp"}}}]

Bookingget bookinggetFromJson(String str) =>
    Bookingget.fromJson(json.decode(str));

String bookinggetToJson(Bookingget data) => json.encode(data.toJson());

class Bookingget {
  Bookingget({
    this.id,
    this.dealId,
    this.dealQuantity,
    this.couponId,
    this.userId,
    this.dateTime,
    this.status,
    this.paymentGateway,
    this.originalAmount,
    this.discount,
    this.couponDiscount,
    this.discountPercent,
    this.taxName,
    this.taxPercent,
    this.taxAmount,
    this.extraFees,
    this.distanceFee,
    this.amountToPay,
    this.paymentStatus,
    this.source,
    this.additionalNotes,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.items,
  });

  Bookingget.fromJson(dynamic json) {
    id = json['id'];
    dealId = json['deal_id'];
    dealQuantity = json['deal_quantity'];
    couponId = json['coupon_id'];
    userId = json['user_id'];
    dateTime = json['date_time'];
    status = json['status'];
    paymentGateway = json['payment_gateway'];
    originalAmount = json['original_amount'];
    discount = json['discount'];
    couponDiscount = json['coupon_discount'];
    discountPercent = json['discount_percent'];
    taxName = json['tax_name'];
    taxPercent = json['tax_percent'];
    taxAmount = json['tax_amount'];
    extraFees = json['extra_fees'];
    distanceFee = json['distance_fee'];
    amountToPay = json['amount_to_pay'];
    paymentStatus = json['payment_status'];
    source = json['source'];
    additionalNotes = json['additional_notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? PaymentUser.fromJson(json['user']) : null;
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }

  num? id;
  dynamic dealId;
  num? dealQuantity;
  dynamic couponId;
  num? userId;
  String? dateTime;
  String? status;
  String? paymentGateway;
  num? originalAmount;
  num? discount;
  num? couponDiscount;
  num? discountPercent;
  String? taxName;
  num? taxPercent;
  dynamic taxAmount;
  num? extraFees;
  num? distanceFee;
  num? amountToPay;
  String? paymentStatus;
  String? source;
  String? additionalNotes;
  dynamic createdAt;
  dynamic updatedAt;
  PaymentUser? user;
  List<Items>? items;

  Bookingget copyWith({
    num? id,
    dynamic dealId,
    num? dealQuantity,
    dynamic couponId,
    num? userId,
    String? dateTime,
    String? status,
    String? paymentGateway,
    num? originalAmount,
    num? discount,
    num? couponDiscount,
    num? discountPercent,
    String? taxName,
    num? taxPercent,
    dynamic taxAmount,
    num? extraFees,
    num? distanceFee,
    num? amountToPay,
    String? paymentStatus,
    String? source,
    String? additionalNotes,
    dynamic createdAt,
    dynamic updatedAt,
    PaymentUser? user,
    List<Items>? items,
  }) =>
      Bookingget(
        id: id ?? this.id,
        dealId: dealId ?? this.dealId,
        dealQuantity: dealQuantity ?? this.dealQuantity,
        couponId: couponId ?? this.couponId,
        userId: userId ?? this.userId,
        dateTime: dateTime ?? this.dateTime,
        status: status ?? this.status,
        paymentGateway: paymentGateway ?? this.paymentGateway,
        originalAmount: originalAmount ?? this.originalAmount,
        discount: discount ?? this.discount,
        couponDiscount: couponDiscount ?? this.couponDiscount,
        discountPercent: discountPercent ?? this.discountPercent,
        taxName: taxName ?? this.taxName,
        taxPercent: taxPercent ?? this.taxPercent,
        taxAmount: taxAmount ?? this.taxAmount,
        extraFees: extraFees ?? this.extraFees,
        distanceFee: distanceFee ?? this.distanceFee,
        amountToPay: amountToPay ?? this.amountToPay,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        source: source ?? this.source,
        additionalNotes: additionalNotes ?? this.additionalNotes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
        items: items ?? this.items,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deal_id'] = dealId;
    map['deal_quantity'] = dealQuantity;
    map['coupon_id'] = couponId;
    map['user_id'] = userId;
    map['date_time'] = dateTime;
    map['status'] = status;
    map['payment_gateway'] = paymentGateway;
    map['original_amount'] = originalAmount;
    map['discount'] = discount;
    map['coupon_discount'] = couponDiscount;
    map['discount_percent'] = discountPercent;
    map['tax_name'] = taxName;
    map['tax_percent'] = taxPercent;
    map['tax_amount'] = taxAmount;
    map['extra_fees'] = extraFees;
    map['distance_fee'] = distanceFee;
    map['amount_to_pay'] = amountToPay;
    map['payment_status'] = paymentStatus;
    map['source'] = source;
    map['additional_notes'] = additionalNotes;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 12299
/// booking_id : 2772
/// business_service_id : 502
/// quantity : 2
/// unit_price : 429
/// amount : 429
/// created_at : "2022-12-29 17:31:51"
/// updated_at : "2022-12-29 17:31:51"
/// business_service : {"id":502,"name":"Legs Show Off","slug":"legs-show-off-noida","description":"<p>&nbsp; Honey Wax - FA ,UA &amp; FL.</p><p>&nbsp; Threading: Eye Brows &amp; Upper Lips&nbsp;</p>","mobile_long_description":null,"mobile_long_description2":null,"mobile_long_description3":null,"mobile_long_description4":null,"long_description":null,"price":858,"time":60,"sort":null,"time_type":"minutes","discount":50,"discount_type":"percent","main_category_id":33,"category_id":244,"sub_category_id":null,"packages_id":0,"location_id":6,"image":["da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp"],"default_image":"da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp","status":"active","prefered_service":"Yes","location_city":"Noida","seo_title":null,"seo_desc":null,"seo_key":null,"created_at":"2021-12-15 03:49:54","updated_at":"2022-12-11 03:54:05","rating_per":"4.75","rating_pop":12000,"service_image_url":"https://www.glamcode.in/user-uploads/service/502/da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp","service_detail_url":"https://www.glamcode.in/499-store/legs-show-off-noida","discounted_price":429,"category":{"id":244,"main_category_id":"33","name":"499 Store","slug":"499-store","image":"3840a99398a49a9ff7edeaa00976da60.png.webp","status":"active","sort_order":null,"created_at":"2021-12-14 21:52:46","updated_at":"2022-11-19 03:24:11","rating_per":"4.75","rating_pop":12000,"category_image_url":"https://www.glamcode.in/user-uploads/subcategory/3840a99398a49a9ff7edeaa00976da60.png.webp"}}

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  Items({
    this.id,
    this.bookingId,
    this.businessServiceId,
    this.quantity,
    this.unitPrice,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.businessService,
  });

  Items.fromJson(dynamic json) {
    id = json['id'];
    bookingId = json['booking_id'];
    businessServiceId = json['business_service_id'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    businessService = json['business_service'] != null
        ? BusinessService.fromJson(json['business_service'])
        : null;
  }

  num? id;
  num? bookingId;
  num? businessServiceId;
  num? quantity;
  num? unitPrice;
  num? amount;
  String? createdAt;
  String? updatedAt;
  BusinessService? businessService;

  Items copyWith({
    num? id,
    num? bookingId,
    num? businessServiceId,
    num? quantity,
    num? unitPrice,
    num? amount,
    String? createdAt,
    String? updatedAt,
    BusinessService? businessService,
  }) =>
      Items(
        id: id ?? this.id,
        bookingId: bookingId ?? this.bookingId,
        businessServiceId: businessServiceId ?? this.businessServiceId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        businessService: businessService ?? this.businessService,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['booking_id'] = bookingId;
    map['business_service_id'] = businessServiceId;
    map['quantity'] = quantity;
    map['unit_price'] = unitPrice;
    map['amount'] = amount;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (businessService != null) {
      map['business_service'] = businessService?.toJson();
    }
    return map;
  }
}

/// id : 502
/// name : "Legs Show Off"
/// slug : "legs-show-off-noida"
/// description : "<p>&nbsp; Honey Wax - FA ,UA &amp; FL.</p><p>&nbsp; Threading: Eye Brows &amp; Upper Lips&nbsp;</p>"
/// mobile_long_description : null
/// mobile_long_description2 : null
/// mobile_long_description3 : null
/// mobile_long_description4 : null
/// long_description : null
/// price : 858
/// time : 60
/// sort : null
/// time_type : "minutes"
/// discount : 50
/// discount_type : "percent"
/// main_category_id : 33
/// category_id : 244
/// sub_category_id : null
/// packages_id : 0
/// location_id : 6
/// image : ["da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp"]
/// default_image : "da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp"
/// status : "active"
/// prefered_service : "Yes"
/// location_city : "Noida"
/// seo_title : null
/// seo_desc : null
/// seo_key : null
/// created_at : "2021-12-15 03:49:54"
/// updated_at : "2022-12-11 03:54:05"
/// rating_per : "4.75"
/// rating_pop : 12000
/// service_image_url : "https://www.glamcode.in/user-uploads/service/502/da5d0189bcddf2c6dae17132c5a9cfd5.jpeg.webp"
/// service_detail_url : "https://www.glamcode.in/499-store/legs-show-off-noida"
/// discounted_price : 429
/// category : {"id":244,"main_category_id":"33","name":"499 Store","slug":"499-store","image":"3840a99398a49a9ff7edeaa00976da60.png.webp","status":"active","sort_order":null,"created_at":"2021-12-14 21:52:46","updated_at":"2022-11-19 03:24:11","rating_per":"4.75","rating_pop":12000,"category_image_url":"https://www.glamcode.in/user-uploads/subcategory/3840a99398a49a9ff7edeaa00976da60.png.webp"}

BusinessService businessServiceFromJson(String str) =>
    BusinessService.fromJson(json.decode(str));

String businessServiceToJson(BusinessService data) =>
    json.encode(data.toJson());

class BusinessService {
  BusinessService({
    this.id,
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
    this.preferedService,
    this.locationCity,
    this.seoTitle,
    this.seoDesc,
    this.seoKey,
    this.createdAt,
    this.updatedAt,
    this.ratingPer,
    this.ratingPop,
    this.serviceImageUrl,
    this.serviceDetailUrl,
    this.discountedPrice,
    this.category,
  });

  BusinessService.fromJson(dynamic json) {
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
    image = json['image'] != null ? json['image'].cast<String>() : [];
    defaultImage = json['default_image'];
    status = json['status'];
    preferedService = json['prefered_service'];
    locationCity = json['location_city'];
    seoTitle = json['seo_title'];
    seoDesc = json['seo_desc'];
    seoKey = json['seo_key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratingPer = json['rating_per'];
    ratingPop = json['rating_pop'];
    serviceImageUrl = json['service_image_url'];
    serviceDetailUrl = json['service_detail_url'];
    discountedPrice = json['discounted_price'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  num? id;
  String? name;
  String? slug;
  String? description;
  dynamic mobileLongDescription;
  dynamic mobileLongDescription2;
  dynamic mobileLongDescription3;
  dynamic mobileLongDescription4;
  dynamic longDescription;
  num? price;
  num? time;
  dynamic sort;
  String? timeType;
  num? discount;
  String? discountType;
  num? mainCategoryId;
  num? categoryId;
  dynamic subCategoryId;
  num? packagesId;
  num? locationId;
  List<String>? image;
  String? defaultImage;
  String? status;
  String? preferedService;
  String? locationCity;
  dynamic seoTitle;
  dynamic seoDesc;
  dynamic seoKey;
  String? createdAt;
  String? updatedAt;
  String? ratingPer;
  num? ratingPop;
  String? serviceImageUrl;
  String? serviceDetailUrl;
  num? discountedPrice;
  Category? category;

  BusinessService copyWith({
    num? id,
    String? name,
    String? slug,
    String? description,
    dynamic mobileLongDescription,
    dynamic mobileLongDescription2,
    dynamic mobileLongDescription3,
    dynamic mobileLongDescription4,
    dynamic longDescription,
    num? price,
    num? time,
    dynamic sort,
    String? timeType,
    num? discount,
    String? discountType,
    num? mainCategoryId,
    num? categoryId,
    dynamic subCategoryId,
    num? packagesId,
    num? locationId,
    List<String>? image,
    String? defaultImage,
    String? status,
    String? preferedService,
    String? locationCity,
    dynamic seoTitle,
    dynamic seoDesc,
    dynamic seoKey,
    String? createdAt,
    String? updatedAt,
    String? ratingPer,
    num? ratingPop,
    String? serviceImageUrl,
    String? serviceDetailUrl,
    num? discountedPrice,
    Category? category,
  }) =>
      BusinessService(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        mobileLongDescription:
            mobileLongDescription ?? this.mobileLongDescription,
        mobileLongDescription2:
            mobileLongDescription2 ?? this.mobileLongDescription2,
        mobileLongDescription3:
            mobileLongDescription3 ?? this.mobileLongDescription3,
        mobileLongDescription4:
            mobileLongDescription4 ?? this.mobileLongDescription4,
        longDescription: longDescription ?? this.longDescription,
        price: price ?? this.price,
        time: time ?? this.time,
        sort: sort ?? this.sort,
        timeType: timeType ?? this.timeType,
        discount: discount ?? this.discount,
        discountType: discountType ?? this.discountType,
        mainCategoryId: mainCategoryId ?? this.mainCategoryId,
        categoryId: categoryId ?? this.categoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        packagesId: packagesId ?? this.packagesId,
        locationId: locationId ?? this.locationId,
        image: image ?? this.image,
        defaultImage: defaultImage ?? this.defaultImage,
        status: status ?? this.status,
        preferedService: preferedService ?? this.preferedService,
        locationCity: locationCity ?? this.locationCity,
        seoTitle: seoTitle ?? this.seoTitle,
        seoDesc: seoDesc ?? this.seoDesc,
        seoKey: seoKey ?? this.seoKey,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        ratingPer: ratingPer ?? this.ratingPer,
        ratingPop: ratingPop ?? this.ratingPop,
        serviceImageUrl: serviceImageUrl ?? this.serviceImageUrl,
        serviceDetailUrl: serviceDetailUrl ?? this.serviceDetailUrl,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        category: category ?? this.category,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['description'] = description;
    map['mobile_long_description'] = mobileLongDescription;
    map['mobile_long_description2'] = mobileLongDescription2;
    map['mobile_long_description3'] = mobileLongDescription3;
    map['mobile_long_description4'] = mobileLongDescription4;
    map['long_description'] = longDescription;
    map['price'] = price;
    map['time'] = time;
    map['sort'] = sort;
    map['time_type'] = timeType;
    map['discount'] = discount;
    map['discount_type'] = discountType;
    map['main_category_id'] = mainCategoryId;
    map['category_id'] = categoryId;
    map['sub_category_id'] = subCategoryId;
    map['packages_id'] = packagesId;
    map['location_id'] = locationId;
    map['image'] = image;
    map['default_image'] = defaultImage;
    map['status'] = status;
    map['prefered_service'] = preferedService;
    map['location_city'] = locationCity;
    map['seo_title'] = seoTitle;
    map['seo_desc'] = seoDesc;
    map['seo_key'] = seoKey;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['rating_per'] = ratingPer;
    map['rating_pop'] = ratingPop;
    map['service_image_url'] = serviceImageUrl;
    map['service_detail_url'] = serviceDetailUrl;
    map['discounted_price'] = discountedPrice;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    return map;
  }
}

/// id : 244
/// main_category_id : "33"
/// name : "499 Store"
/// slug : "499-store"
/// image : "3840a99398a49a9ff7edeaa00976da60.png.webp"
/// status : "active"
/// sort_order : null
/// created_at : "2021-12-14 21:52:46"
/// updated_at : "2022-11-19 03:24:11"
/// rating_per : "4.75"
/// rating_pop : 12000
/// category_image_url : "https://www.glamcode.in/user-uploads/subcategory/3840a99398a49a9ff7edeaa00976da60.png.webp"

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
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
    this.categoryImageUrl,
  });

  Category.fromJson(dynamic json) {
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

  num? id;
  String? mainCategoryId;
  String? name;
  String? slug;
  String? image;
  String? status;
  dynamic sortOrder;
  String? createdAt;
  String? updatedAt;
  String? ratingPer;
  num? ratingPop;
  String? categoryImageUrl;

  Category copyWith({
    num? id,
    String? mainCategoryId,
    String? name,
    String? slug,
    String? image,
    String? status,
    dynamic sortOrder,
    String? createdAt,
    String? updatedAt,
    String? ratingPer,
    num? ratingPop,
    String? categoryImageUrl,
  }) =>
      Category(
        id: id ?? this.id,
        mainCategoryId: mainCategoryId ?? this.mainCategoryId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        status: status ?? this.status,
        sortOrder: sortOrder ?? this.sortOrder,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        ratingPer: ratingPer ?? this.ratingPer,
        ratingPop: ratingPop ?? this.ratingPop,
        categoryImageUrl: categoryImageUrl ?? this.categoryImageUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['main_category_id'] = mainCategoryId;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['status'] = status;
    map['sort_order'] = sortOrder;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['rating_per'] = ratingPer;
    map['rating_pop'] = ratingPop;
    map['category_image_url'] = categoryImageUrl;
    return map;
  }
}

/// id : 3965
/// group_id : null
/// refcode : null
/// wallet : null
/// parent_id : null
/// name : "Tejesh Reddy"
/// email : "6309672824@glamcode.com"
/// address : "Sonewherw,3/27, 3/27, Jaipuria Rd, Vineet Khand, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India"
/// detailed_address : "Sonewherw,3/27, 3/27, Jaipuria Rd, Vineet Khand, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India"
/// latitude : 22.958048999999999040255715954117476940155029296875
/// longitude : 88.435383599999994430618244223296642303466796875
/// mobile : "6309672824"
/// vender_loction_id : null
/// calling_code : "+91"
/// mobile_verified : 1
/// image : null
/// created_at : "2022-12-05 09:28:45"
/// updated_at : "2022-12-05 09:32:42"
/// deleted_at : null
/// user_image_url : "https://www.glamcode.in/img/default-avatar-user.png"
/// mobile_with_code : "916309672824"
/// formatted_mobile : "+91-6309672824"

PaymentUser userFromJson(String str) => PaymentUser.fromJson(json.decode(str));

String userToJson(PaymentUser data) => json.encode(data.toJson());

class PaymentUser {
  PaymentUser({
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

  PaymentUser.fromJson(dynamic json) {
    id = json['id'];
    groupId = json['group_id'];
    refcode = json['refcode'];
    wallet = json['wallet'];
    parentId = json['parent_id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    detailedAddress = json['detailed_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    mobile = json['mobile'];
    venderLoctionId = json['vender_loction_id'];
    callingCode = json['calling_code'];
    mobileVerified = json['mobile_verified'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    userImageUrl = json['user_image_url'];
    mobileWithCode = json['mobile_with_code'];
    formattedMobile = json['formatted_mobile'];
  }

  num? id;
  dynamic groupId;
  dynamic refcode;
  dynamic wallet;
  dynamic parentId;
  String? name;
  String? email;
  String? address;
  String? detailedAddress;
  num? latitude;
  num? longitude;
  String? mobile;
  dynamic venderLoctionId;
  String? callingCode;
  num? mobileVerified;
  dynamic image;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? userImageUrl;
  String? mobileWithCode;
  String? formattedMobile;

  PaymentUser copyWith({
    num? id,
    dynamic groupId,
    dynamic refcode,
    dynamic wallet,
    dynamic parentId,
    String? name,
    String? email,
    String? address,
    String? detailedAddress,
    num? latitude,
    num? longitude,
    String? mobile,
    dynamic venderLoctionId,
    String? callingCode,
    num? mobileVerified,
    dynamic image,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    String? userImageUrl,
    String? mobileWithCode,
    String? formattedMobile,
  }) =>
      PaymentUser(
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['group_id'] = groupId;
    map['refcode'] = refcode;
    map['wallet'] = wallet;
    map['parent_id'] = parentId;
    map['name'] = name;
    map['email'] = email;
    map['address'] = address;
    map['detailed_address'] = detailedAddress;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['mobile'] = mobile;
    map['vender_loction_id'] = venderLoctionId;
    map['calling_code'] = callingCode;
    map['mobile_verified'] = mobileVerified;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['user_image_url'] = userImageUrl;
    map['mobile_with_code'] = mobileWithCode;
    map['formatted_mobile'] = formattedMobile;
    return map;
  }
}

enum CouponType { POINTS, SERVICE_ADD_ON, DISCOUNT }
