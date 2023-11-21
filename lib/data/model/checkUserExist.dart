class CheckUserExist {
  String? status;
  bool? isExist;

  CheckUserExist({this.status, this.isExist});

  CheckUserExist.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    isExist = json['isExist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['isExist'] = this.isExist;
    return data;
  }
}