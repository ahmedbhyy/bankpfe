class DonationModel {
  final String title;
  final String description;
  final String type;
  final String place;
  final String orgonizedby;
  final String orgonizedbyimage;
  final String orgonizedbylink;
  final double totalamount;
  final double currentamount;
  final int givers;
   String id;
  final String donationimage;
  final String orgonizedbydescription;
  final String daysleft;
  final String donationid;

  DonationModel({
    required this.title,
    required this.place,
    required this.orgonizedby,
    required this.orgonizedbyimage,
    required this.orgonizedbylink,
    required this.currentamount,
    required this.givers,
    required this.description,
    required this.type,
    required this.totalamount,
    required this.donationimage,
    required this.orgonizedbydescription,
    required this.daysleft,
    required this.donationid,
    required this.id,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      title: json['title'] ?? '',
      place: json['place'] ?? '',
      description: json['description'] ?? '',
      id: json['id'] ?? "",
      orgonizedby: json['orgonizedby'] ?? '',
      orgonizedbyimage: json['orgonizedbyimage'] ?? '',
      orgonizedbylink: json['orgonizedbylink'] ?? '',
      currentamount:
          json['currentamount'] == null ? 0.0 : (json['currentamount'] + 0.0),
      totalamount:
          json['totalamount'] == null ? 0.0 : (json['totalamount'] + 0.0),
      givers: json['givers'] ?? 0,
      type: json['type'] ?? '',
      donationimage: json['donationimage'] ?? '',
      daysleft: json['daysleft'].toString(),
      orgonizedbydescription: json['orgonizedbydescription'] ?? '',
      donationid: json['donation_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'place': place,
      'description': description,
      'orgonizedby': orgonizedby,
      'orgonizedbyimage': orgonizedbyimage,
      'orgonizedbylink': orgonizedbylink,
      'currentamount': currentamount,
      'totalamount': totalamount,
      'id':id,
      'givers': givers,
      'type': type,
      'donationimage': donationimage,
      'daysleft': daysleft,
      'orgonizedbydescription': orgonizedbydescription,
      'donation_id': donationid,
    };
  }
}
