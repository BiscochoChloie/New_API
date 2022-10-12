// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:q/models/userModel.dart';
import 'package:q/widgets/link_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_services.dart';
import '../../widgets/auth_textfield.dart';
import '../home_screen.dart';
import 'register_screen.dart';
import '../../widgets/button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  late SharedPreferences preferences;

  _initSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Column(
                      children: const [
                        Text(
                          "Login",
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
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
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
                                  label: 'Email'),
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
                                label: 'Password',
                                isObscure: true,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    ButtonWidget(
                      text: 'Login',
                      onClicked: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            AuthServices.logIn(
                              emailController.text,
                              passwordController.text,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          });
                        } else {
                          print('error');
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Does not have account?'),
                        LinkButton(
                            label: "Register",
                            otherPage: (() => RegisterScreen())),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
