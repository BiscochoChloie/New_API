// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:q/screens/product/list_product_screen.dart';
import '../services/auth_services.dart';
import 'auth/login_screen.dart';
import 'product/add_product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // AuthServices.LogOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: Colors.black),
                  itemBuilder: (ctx) => [
                        PopupMenuItem(
                          onTap: () async {
                            await AuthServices.LogOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text('Log Out'),
                        )
                      ])
            ]),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProductScreen()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
        ),
        body: Container(
            child: Column(children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(child: ListProductScreen())
        ])));
  }
}
