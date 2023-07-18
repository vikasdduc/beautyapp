class CashbackViewModel {
  String? status;
  List<Reward>? reward;

  CashbackViewModel({this.status, this.reward});

  CashbackViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['Reward'] != null) {
      reward = <Reward>[];
      json['Reward'].forEach((v) {
        reward!.add(Reward.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (reward != null) {
      data['Reward'] = reward!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reward {
  String? type;
  String? reward;
  String? expiry;
  String? describtion;
  int? bookingId;
  int? id;

  Reward(
      {this.type,
      this.reward,
      this.expiry,
      this.describtion,
      this.bookingId,
      this.id});

  Reward.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    reward = json['reward'];
    expiry = json['expiry'];
    describtion = json['describtion'];
    bookingId = json['booking_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['reward'] = reward;
    data['expiry'] = expiry;
    data['describtion'] = describtion;
    data['booking_id'] = bookingId;
    data['id'] = id;
    return data;
  }
}
