// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField(
      {Key? key,
      required this.textController,
      required this.label,
      this.isObscure = false,
      this.isConfirmPassword = false,
      this.passwordController})
      : super(key: key);

  final TextEditingController textController;
  final String label;
  final bool isObscure;
  final bool isConfirmPassword;
  final TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
            // InputDecoration(labelText: label),
            controller: textController,
            obscureText: isObscure,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }
              if (isConfirmPassword &&
                  value != passwordController?.text.toString()) {
                return 'Password does not match';
              }
              // to do email format validation
              return null;
            }),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
