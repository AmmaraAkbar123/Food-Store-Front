
class User {
  final String type;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final int businessId;
  final int createdBy;
  final String name;
  final String contactId;
  final String updatedAt;
  final String createdAt;
  final int id;

  User({
    required this.type,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.businessId,
    required this.createdBy,
    required this.name,
    required this.contactId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      type: json['type'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      businessId: json['business_id'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      name: json['name'] ?? '',
      contactId: json['contact_id'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      id: json['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'first_name': firstName,
      'last_name': lastName,
      'mobile': mobile,
      'email': email,
      'business_id': businessId,
      'created_by': createdBy,
      'name': name,
      'contact_id': contactId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}

