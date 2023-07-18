class ReferalModel {
  String? status;
  String? message;
  List<ReferFriendsDetails>? referFriendsDetails;

  ReferalModel({this.status, this.message, this.referFriendsDetails});

  ReferalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['referFriendsDetails'] != null) {
      referFriendsDetails = <ReferFriendsDetails>[];
      json['referFriendsDetails'].forEach((v) {
        referFriendsDetails!.add(ReferFriendsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (referFriendsDetails != null) {
      data['referFriendsDetails'] =
          referFriendsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferFriendsDetails {
  String? pageContent;
  String? referCode;
  String? referUrl;

  ReferFriendsDetails({this.pageContent, this.referCode, this.referUrl});

  ReferFriendsDetails.fromJson(Map<String, dynamic> json) {
    pageContent = json['pageContent'];
    referCode = json['referCode'];
    referUrl = json['referUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageContent'] = pageContent;
    data['referCode'] = referCode;
    data['referUrl'] = referUrl;
    return data;
  }
}
