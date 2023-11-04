class ApplicationUser {
  ApplicationUser({
    this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.country,
    required this.city,
    required this.state,
    required this.address,
    required this.postalCode,
  });

  ApplicationUser.withIdAndUsername({this.id, this.username});

  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  DateTime? birthDate;
  String? country;
  String? city;
  String? state;
  String? address;
  String? postalCode;
}
