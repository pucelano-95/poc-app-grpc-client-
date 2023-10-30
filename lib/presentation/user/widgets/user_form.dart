import 'package:flutter/cupertino.dart';
import 'package:flutter_grpc_poc/presentation/user/widgets/padded_text_form_field.dart';

import 'form_button.dart';

class CreateUserForm extends StatelessWidget {

  final GlobalKey<State> formKey;
  final ValueChanged<String> onUsernameChanged;
  final ValueChanged<String> onFirstNameChanged;
  final ValueChanged<String> onLastNameChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPhoneChanged;
  final ValueChanged<String> onBirthDateChanged;
  final VoidCallback onRandomBtnPressed;
  final VoidCallback onCacheUserPressed;
  final VoidCallback onServerStorePressed;

  const CreateUserForm({
    super.key,
    required this.formKey,
    required this.onUsernameChanged,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onEmailChanged,
    required this.onPhoneChanged,
    required this.onBirthDateChanged,
    required this.onRandomBtnPressed,
    required this.onCacheUserPressed,
    required this.onServerStorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(children: [
        PaddedTextFormField(
            label: "Username",
            textInputType: TextInputType.text,
            onChanged: onUsernameChanged,
        ),
        PaddedTextFormField(
            label: "First Name",
            textInputType: TextInputType.text,
            onChanged: onFirstNameChanged,
        ),
        PaddedTextFormField(
            label: "Last Name",
            textInputType: TextInputType.text,
            onChanged: onLastNameChanged,
        ),
        PaddedTextFormField(
            label: "Email",
            textInputType: TextInputType.emailAddress,
            onChanged: onEmailChanged,
        ),
        PaddedTextFormField(
            label: "Phone",
            textInputType: TextInputType.phone,
            onChanged: onPhoneChanged,
        ),
        PaddedTextFormField(
            label: "Birth Date",
            textInputType: TextInputType.datetime,
            onChanged: onBirthDateChanged,
        ),
        FormButton(
            onPressed: onRandomBtnPressed,
            label: "Generate random data"
        ),
        FormButton(
            onPressed: onCacheUserPressed,
            label: "Cache user"
        ),
        FormButton(
            onPressed: onServerStorePressed,
            label: "Send to the server"
        ),
      ],
      ),
    );
  }
}
