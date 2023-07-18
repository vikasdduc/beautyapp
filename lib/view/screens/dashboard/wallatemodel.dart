class WalletModel {
  String? status;
  List<Wallet>? wallet;
  int? total;
  String? username;

  WalletModel({this.status, this.wallet, this.total, this.username});

  WalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['Wallet'] != null) {
      wallet = <Wallet>[];
      json['Wallet'].forEach((v) {
        wallet!.add(Wallet.fromJson(v));
      });
    }
    total = json['total'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (wallet != null) {
      data['Wallet'] = wallet!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['username'] = username;
    return data;
  }
}

class Wallet {
  int? sr;
  int? points;
  String? expiry;
  String? createdAt;

  Wallet({this.sr, this.points, this.expiry, this.createdAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    sr = json['sr'];
    points = json['points'];
    expiry = json['expiry'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sr'] = sr;
    data['points'] = points;
    data['expiry'] = expiry;
    data['created_at'] = createdAt;
    return data;
  }
}
