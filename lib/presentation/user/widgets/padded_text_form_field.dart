import 'package:flutter/material.dart';

class PaddedTextFormField extends StatelessWidget {

  const PaddedTextFormField({
    super.key,
    required this.label,
    required this.textInputType,
    required this.onChanged,
  });

  final String label;
  final TextInputType textInputType;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          labelText: label,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide()),
        ),
        keyboardType: textInputType,
        onChanged: onChanged,
      ),
    );
  }
}
