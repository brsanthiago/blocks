class RetailPrice {
  double amountInMicros;
  String currencyCode;

  RetailPrice({this.amountInMicros, this.currencyCode});

  RetailPrice.fromJson(Map<String, dynamic> json) {
    amountInMicros = json['amountInMicros'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amountInMicros'] = this.amountInMicros;
    data['currencyCode'] = this.currencyCode;
    return data;
  }
}
