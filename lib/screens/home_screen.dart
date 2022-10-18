// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:q/screens/product/list_product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/auth_repository.dart';
import '../repositories/product_repository.dart';
import '../services/shared_preferences.dart';
import 'auth/login_screen.dart';
import 'product/add_product_screen.dart';
import 'package:number_paginator/number_paginator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // var pages = List.generate(
    //   _numPages,
    //   (index) => Center(
    //     child: Text(
    //       "Page ${index + 1}",
    //       style: Theme.of(context).textTheme.headline1,
    //     ),
    //   ),
    // );
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
                          await AuthRepository().logOut();
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
        onPressed: () async {
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
        // Text("Current Page${token!}"),
        Expanded(child: ListProductScreen())
      ])),
      // bottomNavigationBar:
      // Column(
      //   children: [
      //     IconButton(
      //       icon: const Icon(Icons.arrow_left),
      //       tooltip: 'Show Snackbar',
      //       onPressed: () {
      //         if (page > 0) {
      //           setState(() {
      //             page--;
      //             ProductRepository.getAllProducts(page);
      //           });
      //         } else if (page == 0) {
      //           ScaffoldMessenger.of(context)
      //               .showSnackBar(SnackBar(content: Text('end of page')));
      //         }

      //         print(page);
      //         ScaffoldMessenger.of(context)
      //             .showSnackBar(SnackBar(content: Text('end of page')));
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.arrow_right),
      //       tooltip: 'Show Snackbar',
      //       onPressed: () async {
      //         SharedPreferences lastpage =
      //             await SharedPreferences.getInstance();
      //         if (page < lastpage.getInt('last_page')!) {
      //           setState(() {
      //             page++;
      //             ProductRepository.getAllProducts(page);
      //           });
      //         } else {
      //           ScaffoldMessenger.of(context)
      //               .showSnackBar(SnackBar(content: Text('end of page')));
      //         }
      //       },
      //     ),
      //   ],
      // ),

      //     Card(
      //   margin: EdgeInsets.zero,
      //   elevation: 4,
      //   child: NumberPaginator(
      //       // by default, the paginator shows numbers as center content
      //       // numberPages: currentpage,
      //       numberPages: _numPages,
      //       onPageChange: (int index) {
      //         setState(() {
      //           _currentPage = index;
      //         });
      //       }),
      // )
    );
  }
}
