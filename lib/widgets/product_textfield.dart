// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProductTextFormField extends StatelessWidget {
  const ProductTextFormField({
    Key? key,
    required this.textController,
    required this.label,
  }) : super(key: key);

  final TextEditingController textController;
  final String label;

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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }

              return null;
            }),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
