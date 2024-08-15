// To parse this JSON data, do
//
//     final featured = featuredFromMap(jsonString);

import 'dart:convert';

Featured featuredFromMap(String str) => Featured.fromMap(json.decode(str));

String featuredToMap(Featured data) => json.encode(data.toMap());

class Featured {
  List<PaymentDatum> data;

  Featured({
    required this.data,
  });

  factory Featured.fromMap(Map<String, dynamic> json) => Featured(
        data: List<PaymentDatum>.from(
            json["data"].map((x) => PaymentDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class PaymentDatum {
  int id;
  String name;
  String logo;

  PaymentDatum({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory PaymentDatum.fromMap(Map<String, dynamic> json) => PaymentDatum(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}
