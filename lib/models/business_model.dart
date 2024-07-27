class BusinessModel {
  List<Datum> data;

  BusinessModel({
    required this.data,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String name;
  int businessId;
  int locationId;
  String? logo;
  String token;
  String? aboutUs;
  String? termsAndCondition;

  Datum({
    required this.id,
    required this.name,
    required this.businessId,
    required this.locationId,
    this.logo,
    required this.token,
    this.aboutUs,
    this.termsAndCondition,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        businessId: json["business_id"],
        locationId: json["location_id"],
        logo: json["logo"],
        token: json["token"],
        aboutUs: json["about_us"],
        termsAndCondition: json["term_condition"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "business_id": businessId,
        "location_id": locationId,
        "logo": logo,
        "token": token,
        "term_condition": termsAndCondition,
        "about_us": aboutUs,
      };
}
