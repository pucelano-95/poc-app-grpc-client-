class ApplicationUser {

  ApplicationUser({
    this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.birthDate,
  });

  ApplicationUser.withIdAndUsername({this.id, this.username});

  int ?id;
  String ?username;
  String ?firstName;
  String ?lastName;
  String ?email;
  String ?phone;
  DateTime ?birthDate;
}
