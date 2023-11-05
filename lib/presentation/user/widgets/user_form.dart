import 'package:flutter/material.dart';

import 'form_button.dart';

class CreateUserForm extends StatelessWidget {
  final GlobalKey<State> formKey;
  final VoidCallback onServerStoreRandomData;

  const CreateUserForm({
    super.key,
    required this.formKey,
    required this.onServerStoreRandomData,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormButton(
              onPressed: onServerStoreRandomData,
              label: "Send to the server some random data"),
        ],
      ),
    );
  }
}
