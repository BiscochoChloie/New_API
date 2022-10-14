import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final GlobalKey<FormState> formKey;
  final bool isProcessing;
  final Function() validated;

  const SubmitButton({
    required this.label,
    required this.formKey,
    required this.isProcessing,
    required this.validated,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
          padding: EdgeInsets.only(top: 3, left: 3),
          child: MaterialButton(
            minWidth: double.infinity,
            height: 60,
            onPressed: isProcessing ? null : validated,
            color: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          )));
}
