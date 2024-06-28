class CardModel {
  final String background;
  final String name;
  final String cardNumber;
  final String rib;
  final double balance;
   String relatedaccount;
  final String cardtype;
   String id;

  CardModel( {
    required this.background,
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.balance,
    required this.relatedaccount, 
    required this.rib,
    required this.cardtype,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      background: json['background'] ?? '',
      rib: json['rib'] ?? '',
      id: json['id'] ?? '',
      balance : json['balance']+0.0 ?? 0.0,
      relatedaccount :json['relatedaccount'] ?? '',
      name: json['name'] ?? '',
      cardNumber: json['cardnumber'] ?? '',
      cardtype: json['cardtype'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'background': background,
      'id': id,
      'rib':rib,
      'balance':balance,
      'relatedaccount': relatedaccount,
      'name': name,
      'cardnumber': cardNumber,
      'cardtype':cardtype,
    };
  }
}
