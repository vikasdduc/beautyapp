class CancelReschedule {
  String? status;
  String? message;
  String? bookingid;

  CancelReschedule({this.status, this.message, this.bookingid});

  CancelReschedule.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    bookingid = json['bookingid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['bookingid'] = this.bookingid;
    return data;
  }
}