// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:q/models/productModel.dart';
import 'package:q/widgets/product_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/product_services.dart';
import '../../widgets/dialog_widget.dart';
import '../home_screen.dart';
import '../../widgets/button_widget.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late int id;
  final GlobalKey<FormState> _addProductFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController imageLinkController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want add this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await ProductServices.addProduct(nameController.text,
                    imageLinkController.text, priceController.text);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            key: _addProductFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Add Product",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 45,
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
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              ProductTextFormField(
                                  textController: nameController,
                                  label: 'Name'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Image Link",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              ProductTextFormField(
                                  textController: imageLinkController,
                                  label: 'Image Link')
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              ProductTextFormField(
                                  textController: descriptionController,
                                  label: 'Description')
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              ProductTextFormField(
                                  textController: priceController,
                                  label: 'Price')
                            ],
                          ),
                        ],
                      ),
                    ),
                    ButtonWidget(
                      text: 'Save',
                      onClicked: () {
                        if (_addProductFormKey.currentState!.validate()) {
                          setState(() {
                            _confirmDialog();
                            // showDialog(
                            //     context: context,
                            //     barrierDismissible: false,
                            //     builder: (_) => DialogWidget(
                            //           text: 'Are you sure want add this item?',
                            //           function: () {
                            //             ProductServices.addProduct(
                            //                 nameController.text,
                            //                 imageLinkController.text,
                            //                 priceController.text);
                            //           },
                            //           otherPage: (() => HomeScreen()),
                            //         ));
                          });
                        } else {
                          print('error');
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
