import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateUserBidirectionalScreen extends StatefulWidget {

  const CreateUserBidirectionalScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateUserBidirectionalState();
  }
}

class _CreateUserBidirectionalState extends State<CreateUserBidirectionalScreen> {

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Text("Hello bidirectional stream"),
    ]);
  }
}
