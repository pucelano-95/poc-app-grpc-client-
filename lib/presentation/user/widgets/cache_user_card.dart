import 'package:flutter/material.dart';

class CacheUserCard extends StatelessWidget {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String birthDate;
  final String country;
  final String city;
  final String state;
  final String address;
  final String postalCode;

  const CacheUserCard(
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.birthDate,
      this.country,
      this.city,
      this.state,
      this.address,
      this.postalCode,
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
            Text("birth date: $birthDate"),
            Text("country: $country"),
            Text("city: $city"),
            Text("state: $state"),
            Text("address: $address"),
            Text("postal code: $postalCode"),
          ],
        ),
      ),
    );
  }
}
