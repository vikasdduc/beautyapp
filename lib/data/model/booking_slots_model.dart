// import 'dart:convert';

// /// status : "success"
// /// message : "Data Found"
// /// startTime : "2022-12-28T12:30:00.000000Z"
// /// endTime : "2022-12-28T12:30:00.000000Z"
// /// slotArray : [{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"11:00:00","time_to_display":"11:00 AM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"11:30:00","time_to_display":"11:30 AM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"12:00:00","time_to_display":"12:00 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"12:30:00","time_to_display":"12:30 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"13:00:00","time_to_display":"01:00 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"13:30:00","time_to_display":"01:30 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"14:00:00","time_to_display":"02:00 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"14:30:00","time_to_display":"02:30 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"15:00:00","time_to_display":"03:00 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"15:30:00","time_to_display":"03:30 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"16:00:00","time_to_display":"04:00 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"16:30:00","time_to_display":"04:30 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"17:00:00","time_to_display":"05:00 PM"},{"date":"2022-12-28T12:30:00.000000Z","time_to_show":"17:30:00","time_to_display":"05:30 PM"}]
// /// bookings : [{"id":2676,"date_time":"2022-12-28T09:00:00.000000Z"},{"id":2677,"date_time":"2022-12-28T05:00:00.000000Z"},{"id":2682,"date_time":"2022-12-28T10:30:00.000000Z"},{"id":2722,"date_time":"2022-12-28T09:00:00.000000Z"},{"id":2745,"date_time":"2022-12-28T08:00:00.000000Z"},{"id":2746,"date_time":"2022-12-28T07:00:00.000000Z"},{"id":2747,"date_time":"2022-12-28T07:30:00.000000Z"},{"id":2748,"date_time":"2022-12-28T07:30:00.000000Z"}]

// BookingSlotsModel bookingSlotsModelFromJson(String str) =>
//     BookingSlotsModel.fromJson(json.decode(str));
// String bookingSlotsModelToJson(BookingSlotsModel data) =>
//     json.encode(data.toJson());

// class BookingSlotsModel {
//   BookingSlotsModel({
//     this.status,
//     this.message,
//     this.startTime,
//     this.endTime,
//     this.slotArray,
//     this.bookings,
//   });

//   BookingSlotsModel.fromJson(dynamic json) {
//     status = json['status'];
//     message = json['message'];
//     startTime = json['startTime'];
//     endTime = json['endTime'];
//     if (json['slotArray'] != null) {
//       slotArray = [];
//       json['slotArray'].forEach((v) {
//         slotArray?.add(SlotArray.fromJson(v));
//       });
//     }
//     if (json['bookings'] != null) {
//       bookings = [];
//       json['bookings'].forEach((v) {
//         bookings?.add(Bookings.fromJson(v));
//       });
//     }
//   }
//   String? status;
//   String? message;
//   String? startTime;
//   String? endTime;
//   List<SlotArray>? slotArray;
//   List<Bookings>? bookings;
//   BookingSlotsModel copyWith({
//     String? status,
//     String? message,
//     String? startTime,
//     String? endTime,
//     List<SlotArray>? slotArray,
//     List<Bookings>? bookings,
//   }) =>
//       BookingSlotsModel(
//         status: status ?? this.status,
//         message: message ?? this.message,
//         startTime: startTime ?? this.startTime,
//         endTime: endTime ?? this.endTime,
//         slotArray: slotArray ?? this.slotArray,
//         bookings: bookings ?? this.bookings,
//       );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     map['startTime'] = startTime;
//     map['endTime'] = endTime;
//     if (slotArray != null) {
//       map['slotArray'] = slotArray?.map((v) => v.toJson()).toList();
//     }
//     if (bookings != null) {
//       map['bookings'] = bookings?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

// /// id : 2676
// /// date_time : "2022-12-28T09:00:00.000000Z"

// Bookings bookingsFromJson(String str) => Bookings.fromJson(json.decode(str));
// String bookingsToJson(Bookings data) => json.encode(data.toJson());

// class Bookings {
//   Bookings({
//     this.id,
//     this.dateTime,
//   });

//   Bookings.fromJson(dynamic json) {
//     id = json['id'];
//     dateTime = json['date_time'];
//   }
//   num? id;
//   String? dateTime;
//   Bookings copyWith({
//     num? id,
//     String? dateTime,
//   }) =>
//       Bookings(
//         id: id ?? this.id,
//         dateTime: dateTime ?? this.dateTime,
//       );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['date_time'] = dateTime;
//     return map;
//   }
// }

// /// date : "2022-12-28T12:30:00.000000Z"
// /// time_to_show : "11:00:00"
// /// time_to_display : "11:00 AM"

// SlotArray slotArrayFromJson(String str) => SlotArray.fromJson(json.decode(str));
// String slotArrayToJson(SlotArray data) => json.encode(data.toJson());

// class SlotArray {
//   SlotArray({
//     this.date,
//     this.timeToShow,
//     this.timeToDisplay,
//   });

//   SlotArray.fromJson(dynamic json) {
//     date = json['date'];
//     timeToShow = json['time_to_show'];
//     timeToDisplay = json['time_to_display'];
//   }
//   String? date;
//   String? timeToShow;
//   String? timeToDisplay;
//   SlotArray copyWith({
//     String? date,
//     String? timeToShow,
//     String? timeToDisplay,
//   }) =>
//       SlotArray(
//         date: date ?? this.date,
//         timeToShow: timeToShow ?? this.timeToShow,
//         timeToDisplay: timeToDisplay ?? this.timeToDisplay,
//       );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['date'] = date;
//     map['time_to_show'] = timeToShow;
//     map['time_to_display'] = timeToDisplay;
//     return map;
//   }
// }
