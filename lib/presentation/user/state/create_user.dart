import 'package:flutter_grpc_poc/domain/user.dart';

class CreateUserState {

  CreateUserState();

  String ?username;
  String ?firstName;
  String ?lastName;
  String ?email;
  String ?phone;
  DateTime ?birthDate;

  ApplicationUser toUser() {
    return ApplicationUser(
        username: username ?? "",
        firstName: firstName ?? "",
        lastName: lastName ?? "",
        email: email ?? "",
        phone: phone ?? "",
        birthDate: birthDate ?? DateTime.now(),
    );
  }
}

class CreatedUsersResponse {

  CreatedUsersResponse(this.id, this.username);

  int ?id;
  String ?username;
}
