// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../repositories/auth_repository.dart';
import '../../widgets/auth_textfield.dart';
import '../../widgets/link_button.dart';
import '../../widgets/submit_button.dart';
import '../home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  void registerUser() {
    setState(() {
      _isProcessing = true;
    });

    Future.delayed(const Duration(seconds: 2)).then((value) async {
      await AuthRepository().register(nameController.text, emailController.text,
          passwordController.text, passwordConfirmationController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });

    setState(() {
      _isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Form(
              key: _registerFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                AuthTextFormField(
                                    textController: nameController,
                                    label: "Name"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                AuthTextFormField(
                                    textController: emailController,
                                    label: "Email"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                AuthTextFormField(
                                    textController: passwordController,
                                    label: "Password",
                                    isObscure: true),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Confirm Password",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                AuthTextFormField(
                                    textController:
                                        passwordConfirmationController,
                                    label: "Confirm Password",
                                    isObscure: true,
                                    isConfirmPassword: true,
                                    passwordController: passwordController),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SubmitButton(
                        label: 'Register',
                        formKey: _registerFormKey,
                        isProcessing: _isProcessing,
                        validated: () {
                          if (_registerFormKey.currentState!.validate()) {
                            registerUser();
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Already have an account?'),
                          LinkButton(
                              label: "Log In", otherPage: (() => LoginScreen()))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
