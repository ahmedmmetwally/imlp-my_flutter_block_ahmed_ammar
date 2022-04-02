class Quotes {
  String? quote;

  Quotes({this.quote,});

  Quotes.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];

  }
}