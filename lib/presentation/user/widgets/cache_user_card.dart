import 'package:flutter/material.dart';

class CacheUserCard extends StatelessWidget {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String birthDate;

  const CacheUserCard(this.username, this.firstName, this.lastName, this.email,
      this.phone, this.birthDate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          child: Column(
            children: [
              Text("username: $username"),
              Text("first name: $firstName"),
              Text("last name: $lastName"),
              Text("email: $email"),
              Text("phone: $phone"),
              Text("birth date: $birthDate")
            ],
          ),
        ),
      );
  }
}
