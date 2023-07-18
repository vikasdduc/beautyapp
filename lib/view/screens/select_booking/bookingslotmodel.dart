class BookingSlotModel {
  List<Status>? status;

  BookingSlotModel({this.status});

  BookingSlotModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = <Status>[];
      json['status'].forEach((v) {
        status!.add(new Status.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  int? slots;
  String? d;
  int? slotCount;
  String? newDate;
  String? otherDate;

  Status({this.slots, this.d, this.slotCount, this.newDate, this.otherDate});

  Status.fromJson(Map<String, dynamic> json) {
    slots = json['slots'];
    d = json['d'];
    slotCount = json['slot_count'];
    newDate = json['newDate'];
    otherDate = json['otherDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slots'] = this.slots;
    data['d'] = this.d;
    data['slot_count'] = this.slotCount;
    data['newDate'] = this.newDate;
    data['otherDate'] = this.otherDate;
    return data;
  }
}
