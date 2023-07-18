import 'dart:convert';

/// status : "success"
/// message : "My Booking Details"
/// OngoingBookingsArr : [{"user_name":"Tejesh Reddy","booking_id":2682,"booking_order_date":"2022-12-16T08:36:55.000000Z","booking_date":"2022-12-28","booking_time":"16:00:00","payment_gateway":"cash","order_status":"canceled","service_charge":195,"discounted_price":117,"save_price":78,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":166,"payment_status":"pending","service_name":"Hair Cut Kids","service_image":"https://glamcode.in/user-uploads/service/198/fdac942fd8172c6efbc5e5b2fc6e0722.jpeg.webp","service_time":20,"service_main_cat":"Hair Care","service_cat":"Hair Cut"},{"user_name":"Tejesh Reddy","booking_id":2682,"booking_order_date":"2022-12-16T08:36:55.000000Z","booking_date":"2022-12-28","booking_time":"16:00:00","payment_gateway":"cash","order_status":"canceled","service_charge":7498,"discounted_price":2999.1999999999998181010596454143524169921875,"save_price":4498.8000000000001818989403545856475830078125,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":3048.1999999999998181010596454143524169921875,"payment_status":"pending","service_name":"Permanent Smoothening - S","service_image":"https://glamcode.in/user-uploads/service/189/d23710304c1cd72c3069abbc8e4d6d1d.jpeg.webp","service_time":210,"service_main_cat":"Hair Care","service_cat":"Hair Treatment"},{"user_name":"Tejesh Reddy","booking_id":2676,"booking_order_date":"2022-12-16T06:23:18.000000Z","booking_date":"2022-12-28","booking_time":"14:30:00","payment_gateway":"cash","order_status":"canceled","service_charge":998,"discounted_price":499,"save_price":499,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":548,"payment_status":"pending","service_name":"Fruit Facial","service_image":"https://glamcode.in/user-uploads/service/97/2f9ebdfb0cf92869c90e9e0078b0a102.jpeg.webp","service_time":60,"service_main_cat":"Facial","service_cat":"Luxury Facial"},{"user_name":"Tejesh Reddy","booking_id":2677,"booking_order_date":"2022-12-16T06:48:59.000000Z","booking_date":"2022-12-28","booking_time":"10:30:00","payment_gateway":"cash","order_status":"canceled","service_charge":2998,"discounted_price":1798.799999999999954525264911353588104248046875,"save_price":1199.200000000000045474735088646411895751953125,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":1847.799999999999954525264911353588104248046875,"payment_status":"pending","service_name":"Light Touch Make UP","service_image":"https://glamcode.in/user-uploads/service/74/6693f92de3deb86f99121bfffb85ab80.jpeg.webp","service_time":90,"service_main_cat":"Make Up","service_cat":"Party Makeup"},{"user_name":"Tejesh Reddy","booking_id":2678,"booking_order_date":"2022-12-16T07:01:20.000000Z","booking_date":"2022-12-23","booking_time":"13:00:00","payment_gateway":"cash","order_status":"canceled","service_charge":1450,"discounted_price":725,"save_price":725,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":774,"payment_status":"pending","service_name":"Instant Ready","service_image":"https://glamcode.in/user-uploads/service/113/7fb6d2adbed883eac243dd086c28861b.png.webp","service_time":75,"service_main_cat":"Packages Deals","service_cat":"Facial Deals"},{"user_name":"Tejesh Reddy","booking_id":2679,"booking_order_date":"2022-12-16T07:04:07.000000Z","booking_date":"2022-12-23","booking_time":"13:00:00","payment_gateway":"cash","order_status":"canceled","service_charge":1450,"discounted_price":725,"save_price":725,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":774,"payment_status":"pending","service_name":"Instant Ready","service_image":"https://glamcode.in/user-uploads/service/113/7fb6d2adbed883eac243dd086c28861b.png.webp","service_time":75,"service_main_cat":"Packages Deals","service_cat":"Facial Deals"},{"user_name":"Tejesh Reddy","booking_id":2607,"booking_order_date":"2022-12-08T05:15:44.000000Z","booking_date":"2022-12-22","booking_time":"13:00:00","payment_gateway":"cash","order_status":"canceled","service_charge":998,"discounted_price":499,"save_price":499,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":548,"payment_status":"pending","service_name":"Fruit Facial","service_image":"https://glamcode.in/user-uploads/service/97/2f9ebdfb0cf92869c90e9e0078b0a102.jpeg.webp","service_time":60,"service_main_cat":"Facial","service_cat":"Luxury Facial"},{"user_name":"Tejesh Reddy","booking_id":2607,"booking_order_date":"2022-12-08T05:15:44.000000Z","booking_date":"2022-12-22","booking_time":"13:00:00","payment_gateway":"cash","order_status":"canceled","service_charge":1098,"discounted_price":549,"save_price":549,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":598,"payment_status":"pending","service_name":"Red Wine Facial","service_image":"https://glamcode.in/user-uploads/service/1729/055547b313be7b7d8b3e9dc564c3e29a.jpg.webp","service_time":60,"service_main_cat":"Facial","service_cat":"Luxury Facial"},{"user_name":"Tejesh Reddy","booking_id":2607,"booking_order_date":"2022-12-08T05:15:44.000000Z","booking_date":"2022-12-22","booking_time":"13:00:00","payment_gateway":"cash","order_status":"canceled","service_charge":998,"discounted_price":598.799999999999954525264911353588104248046875,"save_price":399.200000000000045474735088646411895751953125,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":647.799999999999954525264911353588104248046875,"payment_status":"pending","service_name":"Lotus Puravital Facial","service_image":"https://glamcode.in/user-uploads/service/103/dc453d0926b61303f8b4c0fbc80711b3.jpg.webp","service_time":60,"service_main_cat":"Facial","service_cat":"Luxury Facial"},{"user_name":"Tejesh Reddy","booking_id":2675,"booking_order_date":"2022-12-16T06:11:20.000000Z","booking_date":"2022-12-21","booking_time":"10:30:00","payment_gateway":"cash","order_status":"canceled","service_charge":998,"discounted_price":499,"save_price":499,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":548,"payment_status":"pending","service_name":"Fruit Facial","service_image":"https://glamcode.in/user-uploads/service/97/2f9ebdfb0cf92869c90e9e0078b0a102.jpeg.webp","service_time":60,"service_main_cat":"Facial","service_cat":"Luxury Facial"},{"user_name":"Tejesh Reddy","booking_id":2674,"booking_order_date":"2022-12-16T05:58:31.000000Z","booking_date":"2022-12-19","booking_time":"10:30:00","payment_gateway":"cash","order_status":"canceled","service_charge":998,"discounted_price":499,"save_price":499,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":548,"payment_status":"pending","service_name":"Fruit Facial","service_image":"https://glamcode.in/user-uploads/service/97/2f9ebdfb0cf92869c90e9e0078b0a102.jpeg.webp","service_time":60,"service_main_cat":"Facial","service_cat":"Luxury Facial"},{"user_name":"Tejesh Reddy","booking_id":2672,"booking_order_date":"2022-12-16T05:55:08.000000Z","booking_date":"2022-12-16","booking_time":"14:00:00","payment_gateway":"cash","order_status":"canceled","service_charge":1450,"discounted_price":725,"save_price":725,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":774,"payment_status":"pending","service_name":"Instant Ready","service_image":"https://glamcode.in/user-uploads/service/485/8c2541f8f1ef3c64a78f0bc3c96eb2e1.png.webp","service_time":75,"service_main_cat":"Packages Deals","service_cat":"Facial Deals"},{"user_name":"Tejesh Reddy","booking_id":2672,"booking_order_date":"2022-12-16T05:55:08.000000Z","booking_date":"2022-12-16","booking_time":"14:00:00","payment_gateway":"cash","order_status":"canceled","service_charge":1450,"discounted_price":725,"save_price":725,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":774,"payment_status":"pending","service_name":"Santa Baby","service_image":"https://glamcode.in/user-uploads/service/1738/0ff91fa27b4479ecb8f02d618519b7e1.png.webp","service_time":85,"service_main_cat":"GC Christmas Sale","service_cat":"Steal Deals"},{"user_name":"Tejesh Reddy","booking_id":2601,"booking_order_date":"2022-12-07T22:41:16.000000Z","booking_date":"2022-12-08","booking_time":"11:11:16","payment_gateway":"cash","order_status":"canceled","service_charge":295,"discounted_price":177,"save_price":118,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":226,"payment_status":"pending","service_name":"Hair Trimming","service_image":"https://glamcode.in/user-uploads/service/1099/ce6da86e0988ac31956f487f2aee14f2.jpeg.webp","service_time":30,"service_main_cat":"Hair Care","service_cat":"Hair Cut"},{"user_name":"Tejesh Reddy","booking_id":2596,"booking_order_date":"2022-12-07T04:41:13.000000Z","booking_date":"2022-12-07","booking_time":"17:11:13","payment_gateway":"cash","order_status":"canceled","service_charge":3998,"discounted_price":1999,"save_price":1999,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":2048,"payment_status":"pending","service_name":"Light Touch Make UP","service_image":"https://glamcode.in/user-uploads/service/1013/9ade4933077be7e480ec58451678860e.png.webp","service_time":90,"service_main_cat":"Make Up","service_cat":"Party Makeup"},{"user_name":"Tejesh Reddy","booking_id":2581,"booking_order_date":"2022-12-06T05:40:53.000000Z","booking_date":"2022-12-06","booking_time":"18:10:53","payment_gateway":"cash","order_status":"canceled","service_charge":3998,"discounted_price":1999,"save_price":1999,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":2048,"payment_status":"pending","service_name":"Light Touch Make UP","service_image":"https://glamcode.in/user-uploads/service/1013/9ade4933077be7e480ec58451678860e.png.webp","service_time":90,"service_main_cat":"Make Up","service_cat":"Party Makeup"},{"user_name":"Tejesh Reddy","booking_id":2578,"booking_order_date":"2022-12-06T01:56:14.000000Z","booking_date":"2022-12-06","booking_time":"14:26:14","payment_gateway":"cash","order_status":"canceled","service_charge":898,"discounted_price":449,"save_price":449,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":498,"payment_status":"pending","service_name":"Exotic Pedicure","service_image":"https://glamcode.in/user-uploads/service/818/eec8eb5cccd503791cceb10c869ff3cc.png.webp","service_time":45,"service_main_cat":"Mani-Pedi","service_cat":"Pedicure"},{"user_name":"Tejesh Reddy","booking_id":2578,"booking_order_date":"2022-12-06T01:56:14.000000Z","booking_date":"2022-12-06","booking_time":"14:26:14","payment_gateway":"cash","order_status":"canceled","service_charge":998,"discounted_price":499,"save_price":499,"safety_hygiene_fee":49,"transportation_fee":0,"total_amount":548,"payment_status":"pending","service_name":"Anti Tan","service_image":"https://glamcode.in/user-uploads/service/1421/dadbe4bc2a07d662923e7beaa4498d5c.jpeg.webp","service_time":60,"service_main_cat":"Facial","service_cat":"Luxury Facial"}]

BookingsModel bookingsFromJson(String str) =>
    BookingsModel.fromJson(json.decode(str));
String bookingsToJson(BookingsModel data) => json.encode(data.toJson());

class BookingsModel {
  BookingsModel({
    this.status,
    this.message,
    this.ongoingBookingsArr,
  });

  BookingsModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['OngoingBookingsArr'] != null) {
      ongoingBookingsArr = [];
      json['OngoingBookingsArr'].forEach((v) {
        ongoingBookingsArr?.add(OngoingBookingsArr.fromJson(v));
      });
    }
  }
  String? status;
  String? message;
  List<OngoingBookingsArr>? ongoingBookingsArr;
  BookingsModel copyWith({
    String? status,
    String? message,
    List<OngoingBookingsArr>? ongoingBookingsArr,
  }) =>
      BookingsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        ongoingBookingsArr: ongoingBookingsArr ?? this.ongoingBookingsArr,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (ongoingBookingsArr != null) {
      map['OngoingBookingsArr'] =
          ongoingBookingsArr?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// user_name : "Tejesh Reddy"
/// booking_id : 2682
/// booking_order_date : "2022-12-16T08:36:55.000000Z"
/// booking_date : "2022-12-28"
/// booking_time : "16:00:00"
/// payment_gateway : "cash"
/// order_status : "canceled"
/// service_charge : 195
/// discounted_price : 117
/// save_price : 78
/// safety_hygiene_fee : 49
/// transportation_fee : 0
/// total_amount : 166
/// payment_status : "pending"
/// service_name : "Hair Cut Kids"
/// service_image : "https://glamcode.in/user-uploads/service/198/fdac942fd8172c6efbc5e5b2fc6e0722.jpeg.webp"
/// service_time : 20
/// service_main_cat : "Hair Care"
/// service_cat : "Hair Cut"

OngoingBookingsArr ongoingBookingsArrFromJson(String str) =>
    OngoingBookingsArr.fromJson(json.decode(str));
String ongoingBookingsArrToJson(OngoingBookingsArr data) =>
    json.encode(data.toJson());

class OngoingBookingsArr {
  OngoingBookingsArr({
    this.userName,
    this.bookingId,
    this.bookingOrderDate,
    this.bookingDate,
    this.bookingTime,
    this.paymentGateway,
    this.orderStatus,
    this.serviceCharge,
    this.discountedPrice,
    this.savePrice,
    this.safetyHygieneFee,
    this.transportationFee,
    this.totalAmount,
    this.paymentStatus,
    this.serviceName,
    this.serviceImage,
    this.serviceTime,
    this.serviceMainCat,
    this.serviceCat,
  });

  OngoingBookingsArr.fromJson(dynamic json) {
    userName = json['user_name'];
    bookingId = json['booking_id'];
    bookingOrderDate = json['booking_order_date'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    paymentGateway = json['payment_gateway'];
    orderStatus = json['order_status'];
    serviceCharge = json['service_charge'];
    discountedPrice = json['discounted_price'];
    savePrice = json['save_price'];
    safetyHygieneFee = json['safety_hygiene_fee'];
    transportationFee = json['transportation_fee'];
    totalAmount = json['total_amount'];
    paymentStatus = json['payment_status'];
    serviceName = json['service_name'];
    serviceImage = json['service_image'];
    serviceTime = json['service_time'];
    serviceMainCat = json['service_main_cat'];
    serviceCat = json['service_cat'];
  }
  String? userName;
  num? bookingId;
  String? bookingOrderDate;
  String? bookingDate;
  String? bookingTime;
  String? paymentGateway;
  String? orderStatus;
  num? serviceCharge;
  num? discountedPrice;
  num? savePrice;
  num? safetyHygieneFee;
  num? transportationFee;
  num? totalAmount;
  String? paymentStatus;
  String? serviceName;
  String? serviceImage;
  num? serviceTime;
  String? serviceMainCat;
  String? serviceCat;
  OngoingBookingsArr copyWith({
    String? userName,
    num? bookingId,
    String? bookingOrderDate,
    String? bookingDate,
    String? bookingTime,
    String? paymentGateway,
    String? orderStatus,
    num? serviceCharge,
    num? discountedPrice,
    num? savePrice,
    num? safetyHygieneFee,
    num? transportationFee,
    num? totalAmount,
    String? paymentStatus,
    String? serviceName,
    String? serviceImage,
    num? serviceTime,
    String? serviceMainCat,
    String? serviceCat,
  }) =>
      OngoingBookingsArr(
        userName: userName ?? this.userName,
        bookingId: bookingId ?? this.bookingId,
        bookingOrderDate: bookingOrderDate ?? this.bookingOrderDate,
        bookingDate: bookingDate ?? this.bookingDate,
        bookingTime: bookingTime ?? this.bookingTime,
        paymentGateway: paymentGateway ?? this.paymentGateway,
        orderStatus: orderStatus ?? this.orderStatus,
        serviceCharge: serviceCharge ?? this.serviceCharge,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        savePrice: savePrice ?? this.savePrice,
        safetyHygieneFee: safetyHygieneFee ?? this.safetyHygieneFee,
        transportationFee: transportationFee ?? this.transportationFee,
        totalAmount: totalAmount ?? this.totalAmount,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        serviceName: serviceName ?? this.serviceName,
        serviceImage: serviceImage ?? this.serviceImage,
        serviceTime: serviceTime ?? this.serviceTime,
        serviceMainCat: serviceMainCat ?? this.serviceMainCat,
        serviceCat: serviceCat ?? this.serviceCat,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = userName;
    map['booking_id'] = bookingId;
    map['booking_order_date'] = bookingOrderDate;
    map['booking_date'] = bookingDate;
    map['booking_time'] = bookingTime;
    map['payment_gateway'] = paymentGateway;
    map['order_status'] = orderStatus;
    map['service_charge'] = serviceCharge;
    map['discounted_price'] = discountedPrice;
    map['save_price'] = savePrice;
    map['safety_hygiene_fee'] = safetyHygieneFee;
    map['transportation_fee'] = transportationFee;
    map['total_amount'] = totalAmount;
    map['payment_status'] = paymentStatus;
    map['service_name'] = serviceName;
    map['service_image'] = serviceImage;
    map['service_time'] = serviceTime;
    map['service_main_cat'] = serviceMainCat;
    map['service_cat'] = serviceCat;
    return map;
  }
}
