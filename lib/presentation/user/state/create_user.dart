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

  int calculateSizeInBytes() {
    int size = 0;
    size += (username != null) ? (username!.length * 2) : 0;
    size += (firstName != null) ? (firstName!.length * 2) : 0;
    size += (lastName != null) ? (lastName!.length * 2) : 0;
    size += (email != null) ? (email!.length * 2) : 0;
    size += (phone != null) ? (phone!.length * 2) : 0;
    size += 8; // datetime
    size += (country != null) ? (country!.length * 2) : 0;
    size += (city != null) ? (city!.length * 2) : 0;
    size += (state != null) ? (state!.length * 2) : 0;
    size += (address != null) ? (address!.length * 2) : 0;
    size += (postalCode != null) ? (postalCode!.length * 2) : 0;
    return size;
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
