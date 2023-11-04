import 'package:flutter_grpc_poc/domain/user.dart';

class CreateUserState {
  CreateUserState();

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

  ApplicationUser toUser() {
    return ApplicationUser(
      username: username ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      email: email ?? "",
      phone: phone ?? "",
      birthDate: birthDate ?? DateTime.now(),
      country: country ?? "",
      city: city ?? "",
      state: state ?? "",
      address: address ?? "",
      postalCode: postalCode ?? "",
    );
  }
}

class CreatedUsersResponse {
  CreatedUsersResponse(this.id, this.username);
  factory CreatedUsersResponse.fromJson(Map<String, dynamic> json) {
    return CreatedUsersResponse(json['id'], json['username']);
  }
  int? id;
  String? username;
}
