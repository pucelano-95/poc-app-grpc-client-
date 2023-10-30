import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatedUserCard extends StatelessWidget {
  final int id;
  final String username;

  const CreatedUserCard(this.id, this.username, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("id: $id"),
                  Text("username: $username"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
