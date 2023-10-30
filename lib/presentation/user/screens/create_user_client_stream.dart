import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateUserClientStreamScreen extends StatefulWidget {

  const CreateUserClientStreamScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateUserBidirectionalState();
  }
}

class _CreateUserBidirectionalState extends State<CreateUserClientStreamScreen> {

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Text("Hello client stream"),
    ]);
  }
}
