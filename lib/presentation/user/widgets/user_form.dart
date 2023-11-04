import 'package:flutter/material.dart';
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
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onCityChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onAddressChanged;
  final ValueChanged<String> onPostalCodeChanged;
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
    required this.onCountryChanged,
    required this.onCityChanged,
    required this.onStateChanged,
    required this.onAddressChanged,
    required this.onPostalCodeChanged,
    required this.onRandomBtnPressed,
    required this.onCacheUserPressed,
    required this.onServerStorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          PaddedTextFormField(
            label: "Username",
            icon: const Icon(Icons.person),
            textInputType: TextInputType.text,
            onChanged: onUsernameChanged,
          ),
          PaddedTextFormField(
            label: "First Name",
            icon: const Icon(Icons.person),
            textInputType: TextInputType.text,
            onChanged: onFirstNameChanged,
          ),
          PaddedTextFormField(
            label: "Last Name",
            icon: const Icon(Icons.person),
            textInputType: TextInputType.text,
            onChanged: onLastNameChanged,
          ),
          PaddedTextFormField(
            label: "Email",
            icon: const Icon(Icons.email),
            textInputType: TextInputType.emailAddress,
            onChanged: onEmailChanged,
          ),
          PaddedTextFormField(
            label: "Phone",
            icon: const Icon(Icons.phone),
            textInputType: TextInputType.phone,
            onChanged: onPhoneChanged,
          ),
          PaddedTextFormField(
            label: "Birth Date",
            icon: const Icon(Icons.calendar_today),
            textInputType: TextInputType.datetime,
            onChanged: onBirthDateChanged,
          ),
          PaddedTextFormField(
            label: "Country",
            icon: const Icon(Icons.public),
            textInputType: TextInputType.datetime,
            onChanged: onCountryChanged,
          ),
          PaddedTextFormField(
            label: "City",
            icon: const Icon(Icons.location_city),
            textInputType: TextInputType.datetime,
            onChanged: onCityChanged,
          ),
          PaddedTextFormField(
            label: "State",
            icon: const Icon(Icons.location_on),
            textInputType: TextInputType.datetime,
            onChanged: onStateChanged,
          ),
          PaddedTextFormField(
            label: "Address",
            icon: const Icon(Icons.home),
            textInputType: TextInputType.datetime,
            onChanged: onAddressChanged,
          ),
          PaddedTextFormField(
            label: "Postal code",
            icon: const Icon(Icons.email),
            textInputType: TextInputType.datetime,
            onChanged: onPostalCodeChanged,
          ),
          FormButton(
              onPressed: onRandomBtnPressed, label: "Generate random data"),
          FormButton(onPressed: onCacheUserPressed, label: "Cache user"),
          FormButton(
              onPressed: onServerStorePressed, label: "Send to the server"),
        ],
      ),
    );
  }
}
