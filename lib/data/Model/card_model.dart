class CardModel {
  final String background;
  final String name;
  final String cardNumber;
  final double balance;
  final String relatedaccount;
   String id;

  CardModel({
    required this.background,
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.balance,
    required this.relatedaccount, 
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      background: json['background'] ?? '',
      id: json['id'] ?? '',
      balance : json['balance'] ?? 0.0,
      relatedaccount :json['relatedaccount'] ?? '',
      name: json['name'] ?? '',
      cardNumber: json['cardnumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'background': background,
      'id': id,
      'balance':balance,
      'relatedaccount': relatedaccount,
      'name': name,
      'cardnumber': cardNumber,
    };
  }
}
