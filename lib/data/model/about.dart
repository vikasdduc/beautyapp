/// status : "success"
/// message : "Data Found"
/// pageData : "<p align=\"center\" style=\"margin: 0cm 0cm 18.75pt;\"><b><span style=\"font-size: 24px;\">Let the Skin Blush</span></b></p><p align=\"center\" style=\"margin: 0cm 0cm 18.75pt;\">Glam Code is an Upscale Fully-Equipped Home Salon Services start-up, initiated by mother and daughter in law duo.</p><p align=\"center\" style=\"margin: 0cm 0cm 18.75pt;\">They travelled many places, visited named parlours, took home services and subsequently, decided to incorporate the basic intricacies of Luxury Salon in Home Salon for comfortable, pampering and delightful experience.<o:p></o:p></p><p style=\"margin: 0cm 0cm 18.75pt;\">Day by Day people want to Experiment with their Look.&nbsp; Exquisite Skin Care, Makeup and bridal Services at door steps is the need of the hour.</p><p style=\"margin: 0cm 0cm 18.75pt;\">&nbsp;Glam Code intends to cater two segments of the market. First segment includes catering markets which&nbsp;&nbsp; provides&nbsp; a high quality Skin Care services at a market competitive price.&nbsp; Second segment, is a&nbsp; new Ultra-Luxury Segment , which &nbsp;includes people who intends to get premium,&nbsp; Luxury Experience at their doorstep&nbsp; with no&nbsp; price barrier as Luxury comes as a price.</p><p align=\"center\" style=\"margin: 0cm 0cm 0.0001pt;\">The venture &nbsp;understands customers &nbsp;requirement and at the same time &nbsp;see a bigger picture of &nbsp;community transformation&nbsp; by&nbsp; creating jobs for women. &nbsp;Research shows that women will spend&nbsp;most of &nbsp;their income on health, nutrition, and education for their families. Turning women into breadwinners not only builds self-esteem, but improves their standing in the community and enables them to pool resources and improve infrastructure.<o:p></o:p></p><p class=\"MsoNormal\" style=\"margin: 0cm 0cm 0.0001pt;\"><o:p style=\"\">&nbsp;</o:p></p>"

class About {
  About({
    String? status,
    String? message,
    String? pageData,
  }) {
    _status = status;
    _message = message;
    _pageData = pageData;
  }

  About.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _pageData = json['pageData'];
  }
  String? _status;
  String? _message;
  String? _pageData;
  About copyWith({
    String? status,
    String? message,
    String? pageData,
  }) =>
      About(
        status: status ?? _status,
        message: message ?? _message,
        pageData: pageData ?? _pageData,
      );
  String? get status => _status;
  String? get message => _message;
  String? get pageData => _pageData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['pageData'] = _pageData;
    return map;
  }
}
